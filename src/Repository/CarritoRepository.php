<?php

namespace App\Repository;

use App\Entity\Carrito;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Carrito>
 *
 * @method Carrito|null find($id, $lockMode = null, $lockVersion = null)
 * @method Carrito|null findOneBy(array $criteria, array $orderBy = null)
 * @method Carrito[]    findAll()
 * @method Carrito[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CarritoRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Carrito::class);
    }

    public function add(Carrito $carrito, bool $flush)
    {
        $this->getEntityManager()->persist($carrito);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function removeCarrito(Carrito $carrito, bool $flush)
    {
        $this->getEntityManager()->remove($carrito);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }


    public function findByUsuario(int $idUsuario)
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.usuario = :idUsuario')->setParameter('idUsuario', $idUsuario)->getQuery()->getOneOrNullResult();

    }





    //    /**
    //     * @return Carrito[] Returns an array of Carrito objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('c')
    //            ->andWhere('c.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('c.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Carrito
    //    {
    //        return $this->createQueryBuilder('c')
    //            ->andWhere('c.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
