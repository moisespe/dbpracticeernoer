-- MySQL Workbench Synchronization
-- Generated: 2022-02-16 02:20
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: moises

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `dbaccessgroup` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `dbaccessgroup`.`Logins` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(45) NOT NULL,
  `PasswordSalt` VARCHAR(200) NOT NULL,
  `PasswordHash` VARCHAR(200) NOT NULL,
  `RelatedUserID` INT(11) NOT NULL,
  `Loginscol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_logins_user_id_idx` (`RelatedUserID` ASC) VISIBLE,
  CONSTRAINT `fk_logins_user_id`
    FOREIGN KEY (`RelatedUserID`)
    REFERENCES `dbaccessgroup`.`Users` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `dbaccessgroup`.`Users` (
  `ID` INT(11) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `UserName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ix_username` USING BTREE (`UserName`) VISIBLE,
  CONSTRAINT `fk_logins_users_username`
    FOREIGN KEY ()
    REFERENCES `dbaccessgroup`.`Logins` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `dbaccessgroup`.`Memberships` (
  `ID` INT(11) NOT NULL,
  `RelatedUserID` INT(11) NOT NULL,
  `RelatedCompanyID` INT(11) NOT NULL,
  `RelatedRoleID` INT(11) NOT NULL,
  `AccountEmailAddress` VARCHAR(45) NOT NULL,
  `AccountPhoneNumber` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_memberships_users_id_idx` (`RelatedUserID` ASC) VISIBLE,
  INDEX `fk_memberships_account_id_idx` (`RelatedRoleID` ASC) VISIBLE,
  INDEX `fk_memberships_company_id_idx` (`RelatedCompanyID` ASC) VISIBLE,
  CONSTRAINT `fk_memberships_users_id`
    FOREIGN KEY (`RelatedUserID`)
    REFERENCES `dbaccessgroup`.`Users` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_memberships_account_id`
    FOREIGN KEY (`RelatedRoleID`)
    REFERENCES `dbaccessgroup`.`Accounts` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_memberships_company_id`
    FOREIGN KEY (`RelatedCompanyID`)
    REFERENCES `dbaccessgroup`.`Companies` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `dbaccessgroup`.`Accounts` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `PlanLevel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `dbaccessgroup`.`Companies` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `AccesstLevel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
