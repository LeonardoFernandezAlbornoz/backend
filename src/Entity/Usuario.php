<?php

namespace App\Entity;

use App\Repository\UsuarioRepository;
use Doctrine\ORM\Mapping as ORM;

use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

#[ORM\Entity(repositoryClass: UsuarioRepository::class)]
class Usuario implements PasswordAuthenticatedUserInterface, UserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $nomUsuario = null;

    #[ORM\Column(length: 255)]
    private ?string $nombre = null;

    #[ORM\Column(length: 255)]
    private ?string $apellidos = null;


    #[ORM\Column(length: 255)]
    private ?string $correo = null;

    #[ORM\Column(length: 255)]
    private ?string $contrasenha = null;

    #[ORM\Column]
    private ?bool $admin = null;

    #[ORM\Column]
    private ?bool $activado = null;


    public function __construct()
    {
        $this->activado = true;
    }
    public function getId(): ?int
    {
        return $this->id;
    }
    public function getNomUsuario(): ?string
    {
        return $this->nomUsuario;
    }

    public function setNomUsuario(string $nomUsuario): static
    {
        $this->nomUsuario = $nomUsuario;

        return $this;
    }

    public function getNombre(): ?string
    {
        return $this->nombre;
    }

    public function setNombre(string $nombre): static
    {
        $this->nombre = $nombre;

        return $this;
    }

    public function getApellidos(): ?string
    {
        return $this->apellidos;
    }

    public function setApellidos(string $apellidos): static
    {
        $this->apellidos = $apellidos;

        return $this;
    }

    public function getCorreo(): ?string
    {
        return $this->correo;
    }

    public function setCorreo(string $correo): static
    {
        $this->correo = $correo;

        return $this;
    }

    public function getContrasenha(): ?string
    {
        return $this->contrasenha;
    }

    public function setContrasenha(string $contrasenha): static
    {
        $this->contrasenha = $contrasenha;

        return $this;
    }

    public function isAdmin(): ?bool
    {
        return $this->admin;
    }

    public function setAdmin(bool $admin): static
    {
        $this->admin = $admin;

        return $this;
    }
    public function getUserIdentifier(): string
    {
        return (string) $this->nomUsuario;
    }

    public function getUsername(): ?string
    {
        return $this->getNomUsuario();
    }

    public function getPassword(): ?string
    {
        return $this->contrasenha;
    }

    public function getRoles(): array
    {
        return $this->isAdmin() ? ['ROLE_ADMIN'] : ['ROLE_USER'];
    }

    public function getSalt(): ?string
    {
        return null;
    }

    public function eraseCredentials(): void
    {

    }

    public function isActivado(): ?bool
    {
        return $this->activado;
    }

    public function setActivado(bool $activado): static
    {
        $this->activado = $activado;

        return $this;

    }

}
