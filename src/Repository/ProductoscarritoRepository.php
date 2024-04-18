<?php

namespace App\Repository;

use App\Entity\Productoscarrito;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Productoscarrito>
 *
 * @method Productoscarrito|null find($id, $lockMode = null, $lockVersion = null)
 * @method Productoscarrito|null findOneBy(array $criteria, array $orderBy = null)
 * @method Productoscarrito[]    findAll()
 * @method Productoscarrito[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductoscarritoRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Productoscarrito::class);
    }


    public function add(Productoscarrito $productoscarrito, bool $flush)
    {
        $this->getEntityManager()->persist($productoscarrito);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function removeProductosCarrito(Productoscarrito $productoscarrito, bool $flush)
    {
        $this->getEntityManager()->remove($productoscarrito);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }


    public function findByCarrito(int $idCarrito)
    {
        return $this->createQueryBuilder("p")->andWhere("p.carrito = :idCarrito")->setParameter("idCarrito", $idCarrito)->getQuery()->getResult();

    }





    //    /**
    //     * @return Productoscarrito[] Returns an array of Productoscarrito objects
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

    //    public function findOneBySomeField($value): ?Productoscarrito
    //    {
    //        return $this->createQueryBuilder('p')
    //            ->andWhere('p.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
