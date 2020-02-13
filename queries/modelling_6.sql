-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bottle_ass_ddbb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bottle_ass_ddbb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bottle_ass_ddbb` ;
USE `bottle_ass_ddbb` ;

-- -----------------------------------------------------
-- Table `bottle_ass_ddbb`.`Provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bottle_ass_ddbb`.`Provider` (
  `nif` VARCHAR(9) NOT NULL,
  `name` VARCHAR(45) NULL,
  `phone` INT(9) NULL,
  `fax` INT(9) NULL,
  `Address_street` VARCHAR(50) NOT NULL,
  `Address_number` INT NULL,
  `Address_floor` INT NULL,
  `Address_door` INT NULL,
  `Address_postal_code` INT(5) NOT NULL,
  `Address_country` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`nif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bottle_ass_ddbb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bottle_ass_ddbb`.`Address` (
  `street` VARCHAR(50) NOT NULL,
  `number` INT NOT NULL,
  `floor` INT NOT NULL,
  `door` INT NOT NULL,
  `city` VARCHAR(24) NULL,
  `postal_code` INT(5) NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`street`, `number`, `floor`, `door`, `postal_code`, `country`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bottle_ass_ddbb`.`Brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bottle_ass_ddbb`.`Brand` (
  `name` VARCHAR(30) NOT NULL,
  `Provider_nif` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_Brand_Provider1_idx` (`Provider_nif` ASC) VISIBLE,
  CONSTRAINT `fk_Brand_Provider1`
    FOREIGN KEY (`Provider_nif`)
    REFERENCES `bottle_ass_ddbb`.`Provider` (`nif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bottle_ass_ddbb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bottle_ass_ddbb`.`Customer` (
  `email` VARCHAR(100) NOT NULL,
  `name` VARCHAR(45) NULL,
  `phone` INT(9) NULL,
  `registration_date` DATE NOT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bottle_ass_ddbb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bottle_ass_ddbb`.`Employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bottle_ass_ddbb`.`Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bottle_ass_ddbb`.`Glasses` (
  `idGlasses` INT NOT NULL AUTO_INCREMENT,
  `Brand_name` VARCHAR(30) NOT NULL,
  `prescription_left` DECIMAL NOT NULL,
  `prescription_right` DECIMAL NOT NULL,
  `frame_type` ENUM("rimless", "metal", "plastic") NULL,
  `frame_color` VARCHAR(24) NULL,
  `left_glass_color` VARCHAR(24) NULL,
  `right_glass_color` VARCHAR(16) NULL,
  `price` DECIMAL NOT NULL,
  `Customer_email` VARCHAR(100) NOT NULL,
  `Employee_idEmployee` INT NOT NULL,
  INDEX `fk_Glasses_Brand1_idx` (`Brand_name` ASC) VISIBLE,
  INDEX `fk_Glasses_Customer1_idx` (`Customer_email` ASC) VISIBLE,
  INDEX `fk_Glasses_Employee1_idx` (`Employee_idEmployee` ASC) VISIBLE,
  PRIMARY KEY (`idGlasses`),
  CONSTRAINT `fk_Glasses_Brand1`
    FOREIGN KEY (`Brand_name`)
    REFERENCES `bottle_ass_ddbb`.`Brand` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Glasses_Customer1`
    FOREIGN KEY (`Customer_email`)
    REFERENCES `bottle_ass_ddbb`.`Customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Glasses_Employee1`
    FOREIGN KEY (`Employee_idEmployee`)
    REFERENCES `bottle_ass_ddbb`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bottle_ass_ddbb`.`Customer_has_Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bottle_ass_ddbb`.`Customer_has_Address` (
  `Customer_email` VARCHAR(100) NOT NULL,
  `Address_street` VARCHAR(50) NOT NULL,
  `Address_number` INT NOT NULL,
  `Address_floor` INT NOT NULL,
  `Address_door` INT NOT NULL,
  `Address_postal_code` INT(5) NOT NULL,
  `Address_country` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Customer_email`, `Address_street`, `Address_number`, `Address_floor`, `Address_door`, `Address_postal_code`, `Address_country`),
  INDEX `fk_Customer_has_Address_Address1_idx` (`Address_street` ASC, `Address_number` ASC, `Address_floor` ASC, `Address_door` ASC, `Address_postal_code` ASC, `Address_country` ASC) VISIBLE,
  INDEX `fk_Customer_has_Address_Customer1_idx` (`Customer_email` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_has_Address_Customer1`
    FOREIGN KEY (`Customer_email`)
    REFERENCES `bottle_ass_ddbb`.`Customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Address_Address1`
    FOREIGN KEY (`Address_street` , `Address_number` , `Address_floor` , `Address_door` , `Address_postal_code` , `Address_country`)
    REFERENCES `bottle_ass_ddbb`.`Address` (`street` , `number` , `floor` , `door` , `postal_code` , `country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
