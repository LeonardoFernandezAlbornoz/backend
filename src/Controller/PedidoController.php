<?php
namespace App\Controller;

use App\Entity\Pedido;
use App\Entity\Productospedido;
use App\Repository\PedidoRepository;
use App\Repository\ProductoRepository;
use App\Repository\ProductospedidoRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;

class PedidoController extends AbstractController
{

    #[Route("/pedidos/usuario/{idUsuario}", methods: ["GET"])]
    public function getPedidosUsuario(int $idUsuario, SerializerInterface $serializer, PedidoRepository $pedidoRepository)
    {
        $pedidos = $pedidoRepository->findByUsuario($idUsuario);

        $pedidosJson = $serializer->serialize($pedidos, 'json');
        return new Response($pedidosJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);

    }

    #[Route("/pedido/productos/{idPedido}", methods: ["GET"])]
    public function getProductosPedido(int $idPedido, ProductospedidoRepository $productospedidoRepository, SerializerInterface $serializer)
    {
        $productosPedido = $productospedidoRepository->findByPedido($idPedido);

        $productosPedidoJson = $serializer->serialize($productosPedido, 'json');
        return new Response($productosPedidoJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);

    }

    #[Route("/pedido/eliminar/{id}", methods: ["DELETE"])]
    public function removePedido(PedidoRepository $pedidoRepository, int $id)
    {
        $pedido = $pedidoRepository->find($id);
        $pedidoRepository->removeProducto($pedido, true);

        return new JsonResponse(["status" => "Pedido " . $id . " eliminado correctamente"], Response::HTTP_OK);
    }

    #[Route("/pedido/crear", methods: ["PUT", "PATCH"])]
    public function addPedido(PedidoRepository $pedidoRepository, int $id, Request $request)
    {

        $data = json_decode($request->getContent(), true);
        $pedido = new Pedido();
        $pedido->setDescuentos($data["descuentos"]);
        $pedido->setGastosEnvio($data["datosEnvio"]);
        $pedido->setUsuario($data["idUsuario"]);

        $idPedido = $pedidoRepository->add($pedido, true);

        return new JsonResponse(["status" => "Pedido " . $id . " añadido correctamente", "idPedido" => $idPedido], Response::HTTP_OK);
    }

    #[Route("/productopedido/crear/{idPedido}/{idProducto}", methods: ["PUT", "PATCH"])]
    public function addProductoPedido(int $idPedido, int $idProducto, PedidoRepository $pedidoRepository, ProductoRepository $productoRepository, ProductospedidoRepository $productospedidoRepository, Request $request)
    {

        $data = json_decode($request->getContent(), true);
        $productosPedido = new Productospedido();
        $pedido = $pedidoRepository->find($idPedido);
        $producto = $productoRepository->find($idProducto);
        $cantidad = $data["cantidad"];

        if ($producto->getStock() < $cantidad) {
            $pedidoRepository->removePedido($pedido, true);
            return new JsonResponse(["error" => "No se ha podido completar el pedido: El artículo " . $producto->getNombre() . " no está disponible"], Response::HTTP_CONFLICT);
        }

        $productosPedido->setCantidad($cantidad);
        $productosPedido->setPedido($pedido);
        $productosPedido->setProducto($producto);
        $productospedidoRepository->add($productosPedido, true);

        $producto->setStock($producto->getStock() - $cantidad);
        $productoRepository->add($producto, true);

        return new JsonResponse(["status" => "Producto añadido al pedido"], Response::HTTP_OK);
    }

}