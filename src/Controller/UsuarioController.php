<?php

namespace App\Controller;

use App\Entity\Carrito;
use App\Entity\Usuario;
use App\Repository\CarritoRepository;
use App\Repository\UsuarioRepository;
use Lexik\Bundle\JWTAuthenticationBundle\Encoder\JWTEncoderInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;

class UsuarioController extends AbstractController
{
    #[Route("/usuarios", methods: ["GET"])]
    public function getUsuarios(UsuarioRepository $usuarioRepository, SerializerInterface $serializer)
    {
        $usuarios = $usuarioRepository->findAll();

        $usuariosJson = $serializer->serialize($usuarios, 'json');
        return new Response($usuariosJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }

    #[Route("/usuario/{id<\d+>}", methods: ["GET"])]
    public function getUsuario(int $id, UsuarioRepository $usuarioRepository, SerializerInterface $serializer)
    {
        $usuario = $usuarioRepository->find($id);

        $usuarioJson = $serializer->serialize($usuario, 'json');
        return new Response($usuarioJson, Response::HTTP_OK, [
            'Content-Type' => 'application/json'
        ]);
    }

    #[Route("/usuario/crear", methods: ["POST"])]
    public function addUsuario(Request $request, UsuarioRepository $usuarioRepository, CarritoRepository $carritoRepository, UserPasswordHasherInterface $passwordHasher)
    {
        $data = json_decode($request->getContent(), true);

        $existingNomUsuario = $usuarioRepository->findByNomUsuario($data["nomUsuario"]);
        if ($existingNomUsuario !== null) {
            return new JsonResponse(["error" => "El nombre de usuario ya está en uso"], Response::HTTP_BAD_REQUEST);
        }

        $existingCorreo = $usuarioRepository->findByCorreo($data["correo"]);
        if ($existingCorreo !== null) {
            return new JsonResponse(["error" => "El correo electrónico ya está en uso"], Response::HTTP_BAD_REQUEST);
        }

        $usuario = new Usuario();
        $usuario->setNomUsuario($data["nomUsuario"]);
        $usuario->setNombre($data["nombre"]);
        $usuario->setApellidos($data["apellidos"]);
        $usuario->setCorreo($data["correo"]);
        $usuario->setAdmin($data["admin"]);
        $contrasenhaHash = $passwordHasher->hashPassword($usuario, $data["contrasenha"]);
        $usuario->setContrasenha($contrasenhaHash);
        $newUsuario = $usuarioRepository->add($usuario, true);

        $carrito = new Carrito();
        $carrito->setUsuario($usuarioRepository->find($newUsuario));
        $carritoRepository->add($carrito, true);

        return new JsonResponse(["status" => "Usuario añadido correctamente"], Response::HTTP_OK);
    }

    #[Route("/usuario/eliminar/{id<\d+>}", methods: ["DELETE"])]
    public function removeUsuario(int $id, UsuarioRepository $usuarioRepository)
    {
        $usuario = $usuarioRepository->find($id);
        $usuarioRepository->removeUsuario($usuario, true);

        return new JsonResponse(["status" => "Usuario " . $id . " eliminado correctamente"], Response::HTTP_OK);
    }

    #[Route("/usuario/modificar/{id<\d+>}", methods: ["PATCH", "PUT"])]
    public function updateUsuario(int $id, Request $request, UsuarioRepository $usuarioRepository, UserPasswordHasherInterface $passwordHasher, JWTEncoderInterface $jwtEncoder)
    {
        $token = $request->headers->get('Authorization');
        $auth = $jwtEncoder->decode($token);

        if ($auth && $auth["admin"]) {
            $data = json_decode($request->getContent(), true);
            $usuario = $usuarioRepository->find($id);
            $usuario->setNomUsuario($data["nomUsuario"]);
            $usuario->setNombre($data["nombre"]);
            $usuario->setApellidos($data["apellidos"]);
            $usuario->setCorreo($data["correo"]);
            $usuario->setAdmin($data["admin"]);
            $usuario->setActivado($data["activado"]);
            $usuarioRepository->add($usuario, true);

            return new JsonResponse(["status" => "Usuario " . $id . " modificado correctamente"], Response::HTTP_OK);
        } else {
            return new JsonResponse(["status" => "No estás autorizado a realizar esta acción"], Response::HTTP_UNAUTHORIZED);
        }

    }


    #[Route("/login", methods: ["POST"])]
    public function login(Request $request, UsuarioRepository $usuarioRepository, UserPasswordHasherInterface $passwordHasher, JWTEncoderInterface $jWTEncoder)
    {
        $data = json_decode($request->getContent(), true);

        $usuario = $usuarioRepository->findOneBy(['correo' => $data["correo"]]);

        if (!$usuario) {
            return new JsonResponse(["error" => "Usuario o contraseña incorrectos"], Response::HTTP_UNAUTHORIZED);
        }

        if (!$passwordHasher->isPasswordValid($usuario, $data["contrasenha"])) {
            return new JsonResponse(["error" => "Usuario o contraseña incorrectos"], Response::HTTP_UNAUTHORIZED);
        }

        if (!$usuario->isActivado()) {
            return new JsonResponse(["error" => "Usuario o contraseña incorrectos"], Response::HTTP_UNAUTHORIZED);
        }

        $token = $jWTEncoder->encode([
            "id" => $usuario->getId(),
            "nomUsuario" => $usuario->getNomUsuario(),
            "nombre" => $usuario->getNombre(),
            "apellidos" => $usuario->getApellidos(),
            "correo" => $usuario->getCorreo(),
            "admin" => $usuario->isAdmin(),
        ]);

        return new JsonResponse([
            "status" => "Sesión iniciada correctamente",
            "token" => $token,

        ], Response::HTTP_OK);
    }
}