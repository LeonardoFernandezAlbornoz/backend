<?php
namespace App\Controller;

use App\Repository\CategoriaRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;


class CategoriaController extends AbstractController
{

    #[Route("/categorias", methods: ["GET"])]
    public function getProductos(CategoriaRepository $categoriasRepository, SerializerInterface $serializer)
    {
        $categorias = $categoriasRepository->findAll();

        $categoriasJson = $serializer->serialize($categorias, 'json');
        return new Response($categoriasJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }
}