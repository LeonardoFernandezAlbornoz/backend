<?php
namespace App\Controller;

use App\Entity\Resenha;
use App\Repository\ProductoRepository;
use App\Repository\ResenhaRepository;
use App\Repository\UsuarioRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;

class ResenhaController extends AbstractController
{
    #[Route("/resenhas/{idProducto<\d+>}", methods: ["GET"])]
    public function getResenhasProducto(int $idProducto, ResenhaRepository $resenhaRepository, SerializerInterface $serializer)
    {
        $resenhas = $resenhaRepository->findByProducto($idProducto);
        $resenhasJson = $serializer->serialize($resenhas, 'json');
        return new Response($resenhasJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }

    #[Route("/resenhas/{nomProducto}", methods: ["GET"])]
    public function getResenhasNomProducto(string $nomProducto, ResenhaRepository $resenhaRepository, ProductoRepository $productoRepository, SerializerInterface $serializer)
    {
        $producto = $productoRepository->findByNombre($nomProducto);
        $resenhas = $resenhaRepository->findByProducto($producto->getId());
        $resenhasJson = $serializer->serialize($resenhas, 'json');
        return new Response($resenhasJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }


    #[Route("/resenha/crear/{nomProducto}", methods: ["POST"])]
    public function addResenha(string $nomProducto, ResenhaRepository $resenhaRepository, Request $request, ProductoRepository $productoRepository, UsuarioRepository $usuarioRepository)
    {

        $data = json_decode($request->getContent(), true);
        $resenha = new Resenha();
        $resenha->setOpinion($data["opinion"]);
        $resenha->setValoracion($data["valoracion"]);
        $resenha->setProducto($productoRepository->findByNombre($nomProducto));
        $resenha->setUsuario($usuarioRepository->find($data["idUsuario"]));
        $resenhaRepository->add($resenha, true);
        return new JsonResponse(["status" => "Tu reseña ha sido publicada"], Response::HTTP_OK);
    }


}