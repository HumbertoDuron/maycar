-- MySQL Script generated by MySQL Workbench
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema workgroup2
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`appointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`appointment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`appointment` (
  `appoinmentId` INT NOT NULL,
  `customerId` INT UNSIGNED NULL,
  `datetime` DATETIME NULL,
  PRIMARY KEY (`appoinmentId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`appointment_has_customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`appointment_has_customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`appointment_has_customer` (
  `customerId` INT UNSIGNED NOT NULL,
  `appoinmentId` INT NOT NULL,
  PRIMARY KEY (`customerId`, `appoinmentId`),
  INDEX `fk_appointment_has_customer_customer1_idx` (`customerId` ASC) VISIBLE,
  INDEX `fk_appointment_has_customer_appointment1_idx` (`appoinmentId` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_has_customer_appointment1`
    FOREIGN KEY (`appoinmentId`)
    REFERENCES `mydb`.`appointment` (`appoinmentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_has_customer_customer1`
    FOREIGN KEY (`customerId`)
    REFERENCES `mydb`.`customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cart` ;

CREATE TABLE IF NOT EXISTS `mydb`.`cart` (
  `cartId` INT UNSIGNED NOT NULL,
  `customerId` INT UNSIGNED NOT NULL,
  `date` DATE NULL,
  PRIMARY KEY (`cartId`, `customerId`),
  INDEX `fk_cart_customer1_idx` (`customerId` ASC) VISIBLE,
  CONSTRAINT `fk_cart_customer1`
    FOREIGN KEY (`customerId`)
    REFERENCES `mydb`.`customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cartDetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cartDetail` ;

CREATE TABLE IF NOT EXISTS `mydb`.`cartDetail` (
  `cartDetailId` INT UNSIGNED NOT NULL,
  `cartId` INT UNSIGNED NOT NULL,
  `productId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cartDetailId`, `cartId`, `productId`),
  INDEX `fk_cartDetail_cart1_idx` (`cartId` ASC) VISIBLE,
  INDEX `fk_cartDetail_product1_idx` (`productId` ASC) VISIBLE,
  CONSTRAINT `fk_cartDetail_cart1`
    FOREIGN KEY (`cartId`)
    REFERENCES `mydb`.`cart` (`cartId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartDetail_product1`
    FOREIGN KEY (`productId`)
    REFERENCES `mydb`.`product` (`productId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `CategoryId` INT GENERATED ALWAYS AS () VIRTUAL,
  `image` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`CategoryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`comment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`comment` (
  `commentid` INT NOT NULL,
  `comment` VARCHAR(45) NULL,
  PRIMARY KEY (`commentid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customerId` INT UNSIGNED NOT NULL,
  `firstname` VARCHAR(25) NULL,
  `email` VARCHAR(40) NULL,
  `phone` VARCHAR(20) NULL,
  `address` VARCHAR(45) NULL,
  `postalCode` SMALLINT(5) UNSIGNED NULL,
  `card` VARCHAR(45) NULL,
  `password` VARCHAR(30) NULL,
  `municipalityId` VARCHAR(25) NULL,
  `orderId` INT UNSIGNED NOT NULL,
  `municipalityId` TINYINT(3) NOT NULL,
  PRIMARY KEY (`customerId`, `orderId`, `municipalityId`),
  INDEX `fk_customer_order1_idx` (`orderId` ASC) VISIBLE,
  INDEX `fk_customer_municipality1_idx` (`municipalityId` ASC) VISIBLE,
  CONSTRAINT `fk_customer_order1`
    FOREIGN KEY (`orderId`)
    REFERENCES `mydb`.`order` (`orderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_municipality1`
    FOREIGN KEY (`municipalityId`)
    REFERENCES `mydb`.`municipality` (`municipalityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `employeeId` INT NOT NULL,
  `email` VARCHAR(40) NULL,
  `Password` VARCHAR(30) NULL,
  PRIMARY KEY (`employeeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`municipality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`municipality` ;

CREATE TABLE IF NOT EXISTS `mydb`.`municipality` (
  `municipalityId` TINYINT(3) NOT NULL,
  `name` VARCHAR(20) NULL,
  PRIMARY KEY (`municipalityId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `orderId` INT UNSIGNED NOT NULL,
  `customerId` INT UNSIGNED NULL,
  `total` INT UNSIGNED NULL,
  `orderDetail_orderID` INT NOT NULL,
  PRIMARY KEY (`orderId`, `orderDetail_orderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orderDetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`orderDetail` ;

CREATE TABLE IF NOT EXISTS `mydb`.`orderDetail` (
  `orderDetailId` INT NOT NULL,
  `orderId` INT UNSIGNED NOT NULL,
  `productId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`orderDetailId`, `orderId`, `productId`),
  INDEX `fk_product_has_order_order1_idx` (`orderId` ASC, `orderDetailId` ASC) VISIBLE,
  INDEX `fk_product_has_order_product1_idx` (`productId` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_order_product1`
    FOREIGN KEY (`productId`)
    REFERENCES `mydb`.`product` (`productId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_order_order1`
    FOREIGN KEY (`orderId` , `orderDetailId`)
    REFERENCES `mydb`.`order` (`orderId` , `orderDetail_orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`product` ;

CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `productId` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NULL,
  `image` BLOB NULL,
  `description` VARCHAR(45) NULL,
  `shortDescrption` VARCHAR(40) NULL,
  `stock` SMALLINT(5) NULL,
  `color` VARCHAR(15) NULL,
  `size` VARCHAR(3) NULL,
  `feature` VARCHAR(45) NULL,
  `assessment` TINYINT(2) NULL,
  `comment_commentid` INT NOT NULL,
  `category_CategoryId` INT NOT NULL,
  PRIMARY KEY (`productId`, `comment_commentid`, `category_CategoryId`),
  INDEX `fk_product_category1_idx` (`category_CategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_CategoryId`)
    REFERENCES `mydb`.`category` (`CategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_has_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`product_has_comment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`product_has_comment` (
  `productId` INT UNSIGNED NOT NULL,
  `commentid` INT NOT NULL,
  PRIMARY KEY (`productId`, `commentid`),
  INDEX `fk_product_has_comment_comment1_idx` (`commentid` ASC) VISIBLE,
  INDEX `fk_product_has_comment_product1_idx` (`productId` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_comment_product1`
    FOREIGN KEY (`productId`)
    REFERENCES `mydb`.`product` (`productId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_comment_comment1`
    FOREIGN KEY (`commentid`)
    REFERENCES `mydb`.`comment` (`commentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wishList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`wishList` ;

CREATE TABLE IF NOT EXISTS `mydb`.`wishList` (
  `wishListId` INT NOT NULL,
  `productId` INT UNSIGNED NOT NULL,
  `customerId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`wishListId`, `productId`, `customerId`),
  INDEX `fk_wishList_product1_idx` (`productId` ASC) VISIBLE,
  INDEX `fk_wishList_customer1_idx` (`customerId` ASC) VISIBLE,
  CONSTRAINT `fk_wishList_product1`
    FOREIGN KEY (`productId`)
    REFERENCES `mydb`.`product` (`productId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wishList_customer1`
    FOREIGN KEY (`customerId`)
    REFERENCES `mydb`.`customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
