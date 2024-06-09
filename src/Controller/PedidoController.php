<?php
namespace App\Controller;

use App\Entity\Pedido;
use App\Entity\Productospedido;
use App\Repository\PedidoRepository;
use App\Repository\ProductoRepository;
use App\Repository\ProductospedidoRepository;
use App\Repository\UsuarioRepository;
use Lexik\Bundle\JWTAuthenticationBundle\Encoder\JWTEncoderInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;

class PedidoController extends AbstractController
{



    #[Route("/pedidos", methods: ["GET"])]
    public function getPedidos(Request $request, JWTEncoderInterface $jwtEncoder, SerializerInterface $serializer, PedidoRepository $pedidoRepository)
    {

        $token = $request->headers->get('Authorization');
        $auth = $jwtEncoder->decode($token);
        if ($auth && $auth["admin"]) {
            $pedidos = $pedidoRepository->findAll();
            $pedidosJson = $serializer->serialize($pedidos, 'json');
            return new Response($pedidosJson, Response::HTTP_OK, [
                'Content-Type' => 'application/json'
            ]);

        } else {
            return new JsonResponse(["status" => "No estás autorizado a realizar esta acción"], Response::HTTP_UNAUTHORIZED);
        }

    }
    #[Route("/pedidos/usuario", methods: ["GET"])]
    public function getPedidosUsuario(Request $request, JWTEncoderInterface $jwtEncoder, SerializerInterface $serializer, PedidoRepository $pedidoRepository)
    {

        $token = $request->headers->get('Authorization');
        $usuario = $jwtEncoder->decode($token);

        $pedidos = $pedidoRepository->findByUsuario($usuario['id']);
        $pedidosJson = $serializer->serialize($pedidos, 'json');
        return new Response($pedidosJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);

    }

    #[Route("/pedidos/modificar-estado/{idPedido<\d+>}", methods: ["PATCH", "PUT"])]
    public function modificarEstado(Request $request, JWTEncoderInterface $jwtEncoder, SerializerInterface $serializer, PedidoRepository $pedidoRepository, int $idPedido)
    {

        $token = $request->headers->get('Authorization');
        $auth = $jwtEncoder->decode($token);
        $data = json_decode($request->getContent(), true);
        if ($auth && $auth["admin"]) {
            $pedido = $pedidoRepository->find($idPedido);
            $pedido->setEstado($data['estado']);
            $pedidoRepository->add($pedido, true);
            return new JsonResponse(["status" => "Pedido modificado correctamente"], Response::HTTP_OK);
        } else {
            return new JsonResponse(["status" => "No estás autorizado a realizar esta acción"], Response::HTTP_UNAUTHORIZED);
        }
    }



    #[Route("/pedido/productos/{idPedido<\d+>}", methods: ["GET"])]
    public function getProductosPedido(int $idPedido, ProductospedidoRepository $productospedidoRepository, SerializerInterface $serializer)
    {
        $productosPedido = $productospedidoRepository->findByPedido($idPedido);

        $productosPedidoJson = $serializer->serialize($productosPedido, 'json');
        return new Response($productosPedidoJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);

    }

    #[Route("/pedido/eliminar/{id<\d+>}", methods: ["DELETE"])]
    public function removePedido(PedidoRepository $pedidoRepository, int $id)
    {
        $pedido = $pedidoRepository->find($id);
        $pedidoRepository->removeProducto($pedido, true);

        return new JsonResponse(["status" => "Pedido " . $id . " eliminado correctamente"], Response::HTTP_OK);
    }

    #[Route("/pedido/crear", methods: ["POST"])]
    public function addPedido(PedidoRepository $pedidoRepository, Request $request, UsuarioRepository $usuarioRepository)
    {

        $data = json_decode($request->getContent(), true);
        $pedido = new Pedido();

        $usuario = $usuarioRepository->find($data["idUsuario"]);
        $pedido->setGastosEnvio($data["gastosEnvio"]);
        $pedido->setUsuario($usuario);

        $idPedido = $pedidoRepository->add($pedido, true);

        return new JsonResponse(["status" => "Pedido añadido correctamente", "idPedido" => $idPedido], Response::HTTP_OK);
    }

    #[Route("/productopedido/crear/{idPedido<\d+>}/{idProducto<\d+>}", methods: ["POST"])]
    public function addProductoPedido(int $idPedido, int $idProducto, PedidoRepository $pedidoRepository, ProductoRepository $productoRepository, ProductospedidoRepository $productospedidoRepository, Request $request)
    {

        $data = json_decode($request->getContent(), true);
        $productosPedido = new Productospedido();
        $pedido = $pedidoRepository->find($idPedido);
        $producto = $productoRepository->find($idProducto);
        $cantidad = $data["cantidad"];
        $precio = $data["precio"];
        $descuento = $data["descuento"];
        if ($producto->getStock() < $cantidad) {
            $pedidoRepository->removePedido($pedido, true);
            return new JsonResponse(["error" => "No se ha podido completar el pedido: El artículo " . $producto->getNombre() . " no está disponible"], Response::HTTP_CONFLICT);
        }

        $productosPedido->setCantidad($cantidad);
        $productosPedido->setPedido($pedido);
        $productosPedido->setProducto($producto);
        $productosPedido->setPrecio($precio);
        $productosPedido->setDescuento($descuento);
        $productospedidoRepository->add($productosPedido, true);

        $producto->setStock($producto->getStock() - $cantidad);
        $productoRepository->add($producto, true);

        return new JsonResponse(["status" => "Producto añadido al pedido"], Response::HTTP_OK);
    }

}