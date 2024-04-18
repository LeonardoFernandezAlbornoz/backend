<?php

namespace App\Repository;

use App\Entity\Usuario;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Usuario>
 *
 * @method Usuario|null find($id, $lockMode = null, $lockVersion = null)
 * @method Usuario|null findOneBy(array $criteria, array $orderBy = null)
 * @method Usuario[]    findAll()
 * @method Usuario[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UsuarioRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Usuario::class);
    }

    public function add(Usuario $usuario, bool $flush)
    {
        $this->getEntityManager()->persist($usuario);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

        return $usuario->getId();

    }
    public function removeUsuario(Usuario $usuario, bool $flush)
    {
        $this->getEntityManager()->remove($usuario);

        if ($flush) {
            $this->getEntityManager()->flush();
        }

    }

    public function login(string $correo, string $contrasenha)
    {
        return $this->createQueryBuilder("u")->andWhere("u.correo = :correo")->setParameter("correo", $correo)->andWhere("u.contrasenha = :contrasenha")->setParameter("contrasenha", $contrasenha)->getQuery()->getOneOrNullResult();

    }

    public function findByCorreo(string $correo)
    {
        return $this->createQueryBuilder("u")->andWhere("u.correo = :correo")->setParameter("correo", $correo)->getQuery()->getOneOrNullResult();

    }

    public function findByNomUsuario(string $nomUsuario)
    {
        return $this->createQueryBuilder("u")->andWhere("u.nomUsuario = :nomUsuario")->setParameter("nomUsuario", $nomUsuario)->getQuery()->getOneOrNullResult();

    }



    //    /**
    //     * @return Usuario[] Returns an array of Usuario objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('u')
    //            ->andWhere('u.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('u.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Usuario
    //    {
    //        return $this->createQueryBuilder('u')
    //            ->andWhere('u.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
