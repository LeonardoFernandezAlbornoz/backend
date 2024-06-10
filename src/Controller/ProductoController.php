<?php
namespace App\Controller;

use App\Entity\Producto;
use App\Repository\CategoriaRepository;
use App\Repository\ProductoRepository;
use Lexik\Bundle\JWTAuthenticationBundle\Encoder\JWTEncoderInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;

class ProductoController extends AbstractController
{

    #[Route("/productos", methods: ["GET"])]
    public function getProductos(ProductoRepository $productoRepository, SerializerInterface $serializer)
    {


        $productos = $productoRepository->findAll();

        $productosJson = $serializer->serialize($productos, 'json');
        return new Response($productosJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }

    #[Route("/productos/buscar/{slug<[A-Za-zÁÉÍÓÚáéíóú\süÜ]+>}", methods: ["GET"])]
    public function searchProducto(string $slug, ProductoRepository $productoRepository, SerializerInterface $serializer)
    {
        $producto = $productoRepository->searchProduct($slug);

        $productoJson = $serializer->serialize($producto, 'json');
        return new Response($productoJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }


    #[Route("/producto/{slug}", methods: ["GET"])]
    public function getProducto(int $slug, ProductoRepository $productoRepository, SerializerInterface $serializer)
    {
        $producto = $productoRepository->find($slug);

        $productoJson = $serializer->serialize($producto, 'json');
        return new Response($productoJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }


    #[Route("/productos/categoria/{idCategoria<\d+>}", methods: ["GET"])]
    public function getProductoByCategoria(int $idCategoria, ProductoRepository $productoRepository, SerializerInterface $serializer)
    {
        $productos = $productoRepository->findByCategoria($idCategoria);

        $productoJson = $serializer->serialize($productos, 'json');
        return new Response($productoJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }


    #[Route("/productos/categoria/{nomCategoria<[A-Za-zÁÉÍÓÚáéíóú\süÜ]+>}", methods: ["GET"])]
    public function getProductoByNomCategoria(string $nomCategoria, ProductoRepository $productoRepository, SerializerInterface $serializer)
    {
        $productos = $productoRepository->findByNomCategoria($nomCategoria);

        $productoJson = $serializer->serialize($productos, 'json');
        return new Response($productoJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }



    #[Route("/producto/crear", methods: ["POST"])]
    public function addProducto(ProductoRepository $productoRepository, CategoriaRepository $categoriaRepository, Request $request, JWTEncoderInterface $jwtEncoder)
    {
        $data = json_decode($request->getContent(), true);

        $token = $request->headers->get('Authorization');
        $auth = $jwtEncoder->decode($token);
        if ($auth && $auth["admin"]) {
            $producto = new Producto();
            $producto->setNombre($data["nombre"]);
            $producto->setDescripcion($data["descripcion"]);
            $producto->setPrecio($data["precio"]);
            $producto->setStock($data["stock"]);
            $producto->setImagen($data["imagen"]);
            $producto->setDescuento($data["descuento"]);
            $producto->setCategoria($categoriaRepository->find($data["idCategoria"]));
            $productoRepository->add($producto, true);

            return new JsonResponse(["status" => "Producto añadido correctamente"], Response::HTTP_OK);
        } else {
            return new JsonResponse(["status" => "No estás autorizado a realizar esta acción"], Response::HTTP_UNAUTHORIZED);
        }
    }

  
    #[Route("/producto/eliminar/{id<\d+>}", methods: ["DELETE"])]
    public function removeProducto(Request $request, ProductoRepository $productoRepository, CategoriaRepository $categoriaRepository, int $id, JWTEncoderInterface $jwtEncoder)
    {

        $token = $request->headers->get('Authorization');
        $auth = $jwtEncoder->decode($token);
        if ($auth && $auth["admin"]) {
            $producto = $productoRepository->findOneBy(["id" => $id]);
            $productoRepository->removeProducto($producto, true);

            return new JsonResponse(["status" => "Producto " . $id . " eliminado correctamente"], Response::HTTP_OK);

        } else {
            return new JsonResponse(["status" => "No estás autorizado a realizar esta acción"], Response::HTTP_UNAUTHORIZED);
        }
    }


    #[Route("/producto/modificar/{id<\d+>}", methods: ["PATCH", "PUT"])]
    public function updateProducto(int $id, ProductoRepository $productoRepository, CategoriaRepository $categoriaRepository, Request $request, JWTEncoderInterface $jwtEncoder)
    {
        $token = $request->headers->get('Authorization');
        $auth = $jwtEncoder->decode($token);
        if ($auth && $auth["admin"]) {
            $data = json_decode($request->getContent(), true);
            $producto = $productoRepository->find($id);
            $producto->setNombre($data["nombre"]);
            $producto->setDescripcion($data["descripcion"]);
            $producto->setPrecio($data["precio"]);
            $producto->setDescuento($data["descuento"]);
            $producto->setStock($data["stock"]);
            $producto->setImagen($data["imagen"]);
            $producto->setCategoria($categoriaRepository->find($data["idCategoria"]));
            $productoRepository->add($producto, true);

            return new JsonResponse(["status" => "Producto " . $id . "  modificado correctamente"], Response::HTTP_OK);

        } else {
            return new JsonResponse(["status" => "No estás autorizado a realizar esta acción"], Response::HTTP_UNAUTHORIZED);
        }
    }




}
