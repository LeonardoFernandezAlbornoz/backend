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
    #[Route("/resenhas/{idProducto}", methods: ["GET"])]
    public function getResenhasProducto(string $idProducto, ResenhaRepository $resenhaRepository, SerializerInterface $serializer)
    {
        $resenhas = $resenhaRepository->findByProducto($idProducto);
        $resenhasJson = $serializer->serialize($resenhas, 'json');
        return new Response($resenhasJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }


    #[Route("/resenha/crear/{idProducto}", methods: ["GET"])]
    public function addResenha(string $idProducto, ResenhaRepository $resenhaRepository, Request $request, ProductoRepository $productoRepository, UsuarioRepository $usuarioRepository)
    {
        $data = json_decode($request->getContent(), true);
        $resenha = new Resenha();
        $resenha->setOpinion($data["opinion"]);
        $resenha->setValoracion($data["valoracion"]);
        $resenha->setProducto($productoRepository->find($idProducto));
        $resenha->setUsuario($usuarioRepository->find($data["idUsuario"]));

        return new JsonResponse(["status" => "Reseña añadida correctamente"], Response::HTTP_OK);
    }


}