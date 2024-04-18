<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240403180235 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE carrito (id INT AUTO_INCREMENT NOT NULL, usuario_id INT DEFAULT NULL, UNIQUE INDEX UNIQ_77E6BED5DB38439E (usuario_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE categoria (id INT AUTO_INCREMENT NOT NULL, descripcion VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE pedido (id INT AUTO_INCREMENT NOT NULL, usuario_id INT DEFAULT NULL, fecha DATETIME NOT NULL, estado VARCHAR(255) NOT NULL, INDEX IDX_C4EC16CEDB38439E (usuario_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE producto (id INT AUTO_INCREMENT NOT NULL, id_categoria INT DEFAULT NULL, nombre VARCHAR(255) NOT NULL, descripcion VARCHAR(255) NOT NULL, precio NUMERIC(10, 2) NOT NULL, stock INT NOT NULL, descuento INT NOT NULL, imagen VARCHAR(255) NOT NULL, INDEX IDX_A7BB0615CE25AE0A (id_categoria), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE productoscarrito (producto_id INT NOT NULL, carrito_id INT NOT NULL, cantidad INT NOT NULL, INDEX IDX_48F682F47645698E (producto_id), INDEX IDX_48F682F4DE2CF6E7 (carrito_id), PRIMARY KEY(producto_id, carrito_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE productospedido (producto_id INT NOT NULL, pedido_id INT NOT NULL, cantidad INT NOT NULL, INDEX IDX_61D6EA687645698E (producto_id), INDEX IDX_61D6EA684854653A (pedido_id), PRIMARY KEY(producto_id, pedido_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE resenha (id INT AUTO_INCREMENT NOT NULL, usuario_id INT DEFAULT NULL, producto_id INT DEFAULT NULL, valoracion NUMERIC(2, 1) NOT NULL, opinion VARCHAR(255) NOT NULL, fecha DATETIME NOT NULL, INDEX IDX_D9F04BF0DB38439E (usuario_id), INDEX IDX_D9F04BF07645698E (producto_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE usuario (id INT AUTO_INCREMENT NOT NULL, nom_usuario VARCHAR(255) NOT NULL, nombre VARCHAR(255) NOT NULL, apellidos VARCHAR(255) NOT NULL, correo VARCHAR(255) NOT NULL, contrasenha VARCHAR(255) NOT NULL, admin TINYINT(1) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE carrito ADD CONSTRAINT FK_77E6BED5DB38439E FOREIGN KEY (usuario_id) REFERENCES usuario (id)');
        $this->addSql('ALTER TABLE pedido ADD CONSTRAINT FK_C4EC16CEDB38439E FOREIGN KEY (usuario_id) REFERENCES usuario (id)');
        $this->addSql('ALTER TABLE producto ADD CONSTRAINT FK_A7BB0615CE25AE0A FOREIGN KEY (id_categoria) REFERENCES categoria (id)');
        $this->addSql('ALTER TABLE productoscarrito ADD CONSTRAINT FK_48F682F47645698E FOREIGN KEY (producto_id) REFERENCES producto (id)');
        $this->addSql('ALTER TABLE productoscarrito ADD CONSTRAINT FK_48F682F4DE2CF6E7 FOREIGN KEY (carrito_id) REFERENCES carrito (id)');
        $this->addSql('ALTER TABLE productospedido ADD CONSTRAINT FK_61D6EA687645698E FOREIGN KEY (producto_id) REFERENCES producto (id)');
        $this->addSql('ALTER TABLE productospedido ADD CONSTRAINT FK_61D6EA684854653A FOREIGN KEY (pedido_id) REFERENCES pedido (id)');
        $this->addSql('ALTER TABLE resenha ADD CONSTRAINT FK_D9F04BF0DB38439E FOREIGN KEY (usuario_id) REFERENCES usuario (id)');
        $this->addSql('ALTER TABLE resenha ADD CONSTRAINT FK_D9F04BF07645698E FOREIGN KEY (producto_id) REFERENCES producto (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE carrito DROP FOREIGN KEY FK_77E6BED5DB38439E');
        $this->addSql('ALTER TABLE pedido DROP FOREIGN KEY FK_C4EC16CEDB38439E');
        $this->addSql('ALTER TABLE producto DROP FOREIGN KEY FK_A7BB0615CE25AE0A');
        $this->addSql('ALTER TABLE productoscarrito DROP FOREIGN KEY FK_48F682F47645698E');
        $this->addSql('ALTER TABLE productoscarrito DROP FOREIGN KEY FK_48F682F4DE2CF6E7');
        $this->addSql('ALTER TABLE productospedido DROP FOREIGN KEY FK_61D6EA687645698E');
        $this->addSql('ALTER TABLE productospedido DROP FOREIGN KEY FK_61D6EA684854653A');
        $this->addSql('ALTER TABLE resenha DROP FOREIGN KEY FK_D9F04BF0DB38439E');
        $this->addSql('ALTER TABLE resenha DROP FOREIGN KEY FK_D9F04BF07645698E');
        $this->addSql('DROP TABLE carrito');
        $this->addSql('DROP TABLE categoria');
        $this->addSql('DROP TABLE pedido');
        $this->addSql('DROP TABLE producto');
        $this->addSql('DROP TABLE productoscarrito');
        $this->addSql('DROP TABLE productospedido');
        $this->addSql('DROP TABLE resenha');
        $this->addSql('DROP TABLE usuario');
    }
}
