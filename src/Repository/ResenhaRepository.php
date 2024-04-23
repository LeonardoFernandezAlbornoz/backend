<?php

namespace App\Repository;

use App\Entity\Resenha;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Resenha>
 *
 * @method Resenha|null find($id, $lockMode = null, $lockVersion = null)
 * @method Resenha|null findOneBy(array $criteria, array $orderBy = null)
 * @method Resenha[]    findAll()
 * @method Resenha[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ResenhaRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Resenha::class);
    }
    public function add(Resenha $resenha, bool $flush)
    {
        $this->getEntityManager()->persist($resenha);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function remove(Resenha $resenha, bool $flush)
    {
        $this->getEntityManager()->remove($resenha);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function findByProducto($id)
    {
        return $this->createQueryBuilder("r")->andWhere("r.producto = :id")->setParameter("id", $id)->getQuery()->getResult();
    }




    //    /**
//     * @return Resenha[] Returns an array of Resenha objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('r')
//            ->andWhere('r.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('r.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

    //    public function findOneBySomeField($value): ?Resenha
//    {
//        return $this->createQueryBuilder('r')
//            ->andWhere('r.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
