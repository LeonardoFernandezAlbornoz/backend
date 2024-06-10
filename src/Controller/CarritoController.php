<?php
namespace App\Controller;

use App\Entity\Productoscarrito;
use App\Repository\CarritoRepository;
use App\Repository\ProductoRepository;
use App\Repository\ProductoscarritoRepository;
use App\Repository\UsuarioRepository;
use Lexik\Bundle\JWTAuthenticationBundle\Encoder\JWTEncoderInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;


class CarritoController extends AbstractController
{
    #[Route("/carrito/usuario/{idUsuario<\d+>}", methods: ["GET"])]
    public function getCarritoUsuario(int $idUsuario, ProductoscarritoRepository $productoscarritoRepository, SerializerInterface $serializer, CarritoRepository $carritoRepository)
    {

        $idCarrito = $carritoRepository->findByUsuario($idUsuario)->getId();

        $carrito = $productoscarritoRepository->findByCarrito($idCarrito);
        $carritoJson = $serializer->serialize($carrito, 'json');
        return new Response($carritoJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }


    #[Route("/productocarrito/crear/{idUsuario<\d+>}/{idProducto<\d+>}", methods: ["PUT", "PATCH"])]
    public function addProductoCarrito(int $idUsuario, int $idProducto, CarritoRepository $carritoRepository, ProductoRepository $productoRepository, ProductoscarritoRepository $productoscarritoRepository, Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $carrito = $carritoRepository->findByUsuario($idUsuario);
        $producto = $productoRepository->find($idProducto);
        $cantidad = intval($data["cantidad"]);

        if ($producto->getStock() < $cantidad) {
            return new JsonResponse([
                "error" => "No se ha podido añadir el producto al carrito: El artículo " . $producto->getNombre() . " no está disponible"
            ], Response::HTTP_CONFLICT);
        }

        $productosCarrito = $productoscarritoRepository->findOneBy([
            'carrito' => $carrito,
            'producto' => $producto
        ]);

        if ($productosCarrito) {
            $nuevaCantidad = $productosCarrito->getCantidad() + $cantidad;

            if ($producto->getStock() < $nuevaCantidad) {
                return new JsonResponse([
                    "error" => "No se ha podido añadir el producto al carrito: No hay suficiente stock del artículo " . $producto->getNombre()
                ], Response::HTTP_CONFLICT);
            }

            $productosCarrito->setCantidad($nuevaCantidad);
        } else {

            $productosCarrito = new Productoscarrito();
            $productosCarrito->setCarrito($carrito);
            $productosCarrito->setProducto($producto);
            $productosCarrito->setCantidad($cantidad);
        }

        $productoscarritoRepository->add($productosCarrito, true);

        return new JsonResponse(["status" => "Producto añadido al carrito"], Response::HTTP_OK);
    }
    
    #[Route("/productocarrito/modificar/{idUsuario<\d+>}/{idProducto<\d+>}", methods: ["PUT", "PATCH"])]
    public function updateProductoCarrito(int $idUsuario, int $idProducto, CarritoRepository $carritoRepository, ProductoRepository $productoRepository, ProductoscarritoRepository $productoscarritoRepository, Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $carrito = $carritoRepository->findByUsuario($idUsuario);
        $producto = $productoRepository->find($idProducto);
        $cantidad = intval($data["cantidad"]);

        if ($producto->getStock() < $cantidad) {
            return new JsonResponse([
                "error" => "No se ha podido añadir el producto al carrito: El artículo " . $producto->getNombre() . " no está disponible"
            ], Response::HTTP_CONFLICT);
        }

        $productosCarrito = $productoscarritoRepository->findOneBy([
            'carrito' => $carrito,
            'producto' => $producto
        ]);
     

        if ($producto->getStock() <  $cantidad) {
            return new JsonResponse([
                "error" => "No se ha podido modificar el producto al carrito: No hay suficiente stock del artículo " . $producto->getNombre()
            ], Response::HTTP_CONFLICT);
        }

        $productosCarrito->setCantidad( $cantidad);
        

        $productoscarritoRepository->add($productosCarrito, true);

        return new JsonResponse(["status" => "Producto modificado"], Response::HTTP_OK);
    }
    #[Route("/productocarrito/eliminar/{idUsuario<\d+>}/{idProducto<\d+>}", methods: ["DELETE"])]
    public function removeProductoPedido(int $idUsuario, int $idProducto, CarritoRepository $carritoRepository, ProductoRepository $productoRepository, ProductoscarritoRepository $productoscarritoRepository)
    {
        $carrito = $carritoRepository->findByUsuario($idUsuario);
        $producto = $productoRepository->find($idProducto);

        $productosCarrito = $productoscarritoRepository->find([
            'producto' => $producto,
            'carrito' => $carrito
        ]);
        ;

        $productoscarritoRepository->removeProductosCarrito($productosCarrito, true);

        return new JsonResponse(["status" => "Producto eliminado del carrito"], Response::HTTP_OK);
    }


    #[Route("/carrito/eliminar/usuario", methods: ["DELETE"])]
    public function eliminarCarritoUsuario(Request $request, CarritoRepository $carritoRepository, ProductoscarritoRepository $productoscarritoRepository, UsuarioRepository $usuarioRepository)
    {

        $data = json_decode($request->getContent(), true);

        $carrito = $carritoRepository->findByUsuario($data["idUsuario"]);
        $productos = $productoscarritoRepository->findByCarrito($carrito->getId());
        foreach ($productos as $producto) {
            $productoscarritoRepository->removeProductosCarrito($producto, true);
        }

        return new Response(Response::HTTP_OK);

    }

}
