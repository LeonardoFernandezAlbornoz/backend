<?php

namespace App\Entity;

use App\Repository\ProductoscarritoRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProductoscarritoRepository::class)]
class Productoscarrito
{
    #[ORM\Id]
    #[ORM\ManyToOne(targetEntity: Producto::class)]
    #[ORM\JoinColumn(name: "producto_id", referencedColumnName: "id")]
    private ?producto $producto = null;


    #[ORM\Id]
    #[ORM\ManyToOne(targetEntity: Carrito::class)]
    #[ORM\JoinColumn(name: "carrito_id", referencedColumnName: "id")]
    private ?carrito $carrito = null;

    #[ORM\Column]
    private ?int $cantidad = null;

    public function getProducto(): ?Producto
    {
        return $this->producto;
    }

    public function setProducto(?Producto $producto): static
    {
        $this->producto = $producto;

        return $this;
    }

    public function getCarrito(): ?Carrito
    {
        return $this->carrito;
    }

    public function setCarrito(?Carrito $carrito): static
    {
        $this->carrito = $carrito;

        return $this;
    }

    public function getCantidad(): ?int
    {
        return $this->cantidad;
    }

    public function setCantidad(int $cantidad): static
    {
        $this->cantidad = $cantidad;

        return $this;
    }
}
