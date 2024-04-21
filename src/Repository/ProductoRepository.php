<?php

namespace App\Repository;

use App\Entity\Producto;
use App\Entity\Categoria;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Producto>
 *
 * @method Producto|null find($id, $lockMode = null, $lockVersion = null)
 * @method Producto|null findOneBy(array $criteria, array $orderBy = null)
 * @method Producto[]    findAll()
 * @method Producto[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductoRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Producto::class);
    }

    public function add(Producto $producto, bool $flush)
    {
        $this->getEntityManager()->persist($producto);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function removeProducto(Producto $producto, bool $flush)
    {
        $this->getEntityManager()->remove($producto);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function searchProduct(string $nombre)
    {
        return $this->createQueryBuilder('p')->andWhere('p.nombre LIKE :nombre')->setParameter('nombre', '%' . $nombre . '%')->getQuery()->getResult();
    }

    public function findByNombre(string $nombre)
    {
        return $this->createQueryBuilder('p')->andWhere('p.nombre = :nombre')->setParameter('nombre', $nombre)->getQuery()->getOneOrNullResult();
    }

    public function findByCategoria(int $idCategoria)
    {
        return $this->createQueryBuilder('p')->andWhere('p.categoria = :idCategoria')->setParameter('idCategoria', $idCategoria)->getQuery()->getResult();
    }
    public function findByNomCategoria(string $nomCategoria)
    {

        $idCategoria = $this->getEntityManager()->getRepository(Categoria::class)->findByCategoriaByDescripcion($nomCategoria);
        return $this->createQueryBuilder('p')->andWhere('p.categoria = :idCategoria')->setParameter('idCategoria', $idCategoria)->getQuery()->getResult();
    }


    //    /**
//     * @return Producto[] Returns an array of Producto objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('p')
//            ->andWhere('p.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('p.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

    //    public function findOneBySomeField($value): ?Producto
//    {
//        return $this->createQueryBuilder('p')
//            ->andWhere('p.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
