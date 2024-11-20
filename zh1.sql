-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zh1
-- -----------------------------------------------------
drop table eladok;
drop table kisbolt;
drop table arufeltolto;
-- -----------------------------------------------------
-- Schema zh1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zh1` DEFAULT CHARACTER SET utf8 ;
USE `zh1` ;

-- -----------------------------------------------------
-- Table `zh1`.`arufeltolto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zh1`.`arufeltolto` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nev` VARCHAR(45) NULL,
  `fizetes` INT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zh1`.`kisbolt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zh1`.`kisbolt` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `cim` VARCHAR(45) NULL,
  `terulet` INT NULL,
  `arufeltolto_ID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_kisbolt_arufeltolto1_idx` (`arufeltolto_ID`),
  CONSTRAINT `fk_kisbolt_arufeltolto1`
    FOREIGN KEY (`arufeltolto_ID`)
    REFERENCES `zh1`.`arufeltolto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zh1`.`eladok`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zh1`.`eladok` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nev` VARCHAR(45) NULL,
  `fizetes` INT NULL,
  `kisbolt_ID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_eladok_kisbolt1_idx` (`kisbolt_ID`),
  CONSTRAINT `fk_eladok_kisbolt1`
    FOREIGN KEY (`kisbolt_ID`)
    REFERENCES `zh1`.`kisbolt` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into arufeltolto (nev, fizetes) values ('Nagy Dénes', 255000);
insert into arufeltolto (nev, fizetes) values ('Nagy Erika', 255000);
insert into arufeltolto (nev, fizetes) values ('Kiss János', 200000);

insert into kisbolt (cim, terulet, arufeltolto_ID) values ('Kő utca 3', 200, (select ID from arufeltolto where nev = 'Nagy Dénes' LIMIT 1));
insert into kisbolt (cim, terulet, arufeltolto_ID) values ('Fa út 4/B', 150, (select ID from arufeltolto where nev = 'Nagy Erika' LIMIT 1));
insert into kisbolt (cim, terulet, arufeltolto_ID) values ('Fa út 224', 300, (select ID from arufeltolto where nev = 'Nagy Dénes' LIMIT 1));
insert into kisbolt (cim, terulet, arufeltolto_ID) values ('Nagy tér 1', 125, (select ID from arufeltolto where nev = 'Kiss János' LIMIT 1));

insert into eladok (nev, fizetes, kisbolt_ID) values ('Kiss Anna', 300000, (select ID from kisbolt where cim = 'Kő utca 3' LIMIT 1));
insert into eladok (nev, fizetes, kisbolt_ID) values ('Nagy Cecil', 370000, (select ID from kisbolt where cim = 'Kő utca 3' LIMIT 1));
insert into eladok (nev, fizetes, kisbolt_ID) values ('Közepes Béla', 350000, (select ID from kisbolt where cim = 'Fa út 4/B' LIMIT 1));

select * from arufeltolto;
select * from kisbolt;
select * from eladok;

