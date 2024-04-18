<?php

namespace App\Repository;

use App\Entity\Productospedido;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Productospedido>
 *
 * @method Productospedido|null find($id, $lockMode = null, $lockVersion = null)
 * @method Productospedido|null findOneBy(array $criteria, array $orderBy = null)
 * @method Productospedido[]    findAll()
 * @method Productospedido[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductospedidoRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Productospedido::class);
    }

    public function add(Productospedido $productospedido, bool $flush)
    {
        $this->getEntityManager()->persist($productospedido);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function removeProductosPedido(Productospedido $productospedido, bool $flush)
    {
        $this->getEntityManager()->remove($productospedido);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function findByPedido(int $idPedido)
    {
        return $this->createQueryBuilder("p")->andWhere("p.pedido = :idPedido")->setParameter("idPedido", $idPedido)->getQuery()->getResult();

    }


    //    /**
    //     * @return Productospedido[] Returns an array of Productospedido objects
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

    //    public function findOneBySomeField($value): ?Productospedido
    //    {
    //        return $this->createQueryBuilder('p')
    //            ->andWhere('p.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
