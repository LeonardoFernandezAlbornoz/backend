<?php

namespace App\Entity;

use App\Repository\ProductospedidoRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProductospedidoRepository::class)]
class Productospedido
{

    #[ORM\Id]
    #[ORM\ManyToOne(targetEntity: Producto::class)]
    #[ORM\JoinColumn(name: "producto_id", referencedColumnName: "id")]
    private ?producto $producto = null;

    #[ORM\Id]
    #[ORM\ManyToOne(targetEntity: Pedido::class)]
    #[ORM\JoinColumn(name: "pedido_id", referencedColumnName: "id")]
    private ?pedido $pedido = null;

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

    public function getCantidad(): ?int
    {
        return $this->cantidad;
    }

    public function setCantidad(int $cantidad): static
    {
        $this->cantidad = $cantidad;

        return $this;
    }

    public function getPedido(): ?Pedido
    {
        return $this->pedido;
    }

    public function setPedido(?Pedido $pedido): static
    {
        $this->pedido = $pedido;

        return $this;
    }
}
