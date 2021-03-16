-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Instructor` (
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`First_Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Courses` (
  `CName` VARCHAR(45) NOT NULL,
  `CDescription` VARCHAR(450) NOT NULL,
  `Instructor_First_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CName`),
  INDEX `fk_Courses_Instructor1_idx` (`Instructor_First_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_Instructor1`
    FOREIGN KEY (`Instructor_First_Name`)
    REFERENCES `mydb`.`Instructor` (`First_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Modules` (
  `Module_Name` VARCHAR(45) NOT NULL,
  `Courses_CName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Module_Name`),
  INDEX `fk_Modules_Courses1_idx` (`Courses_CName` ASC) VISIBLE,
  CONSTRAINT `fk_Modules_Courses1`
    FOREIGN KEY (`Courses_CName`)
    REFERENCES `mydb`.`Courses` (`CName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lessons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lessons` (
  `LName` VARCHAR(45) NOT NULL,
  `LDescription` LONGTEXT NULL,
  `Video_File_Path` MEDIUMTEXT NULL,
  `Completion_Status` BINARY(1) NOT NULL,
  `Modules_Module_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`LName`),
  INDEX `fk_Lessons_Modules1_idx` (`Modules_Module_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Lessons_Modules1`
    FOREIGN KEY (`Modules_Module_Name`)
    REFERENCES `mydb`.`Modules` (`Module_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Resources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Resources` (
  `Files` BLOB NULL,
  `Lessons_LName` VARCHAR(45) NOT NULL,
  INDEX `fk_Lesson_Resources_Lessons1_idx` (`Lessons_LName` ASC) VISIBLE,
  CONSTRAINT `fk_Lesson_Resources_Lessons1`
    FOREIGN KEY (`Lessons_LName`)
    REFERENCES `mydb`.`Lessons` (`LName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comments` (
  `Text` LONGTEXT NOT NULL,
  `Timestamp` DATETIME NOT NULL,
  `Person` VARCHAR(45) NOT NULL,
  `Lessons_LName` VARCHAR(45) NOT NULL,
  `Comments_Timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`Timestamp`),
  INDEX `fk_Comments_Lessons1_idx` (`Lessons_LName` ASC) VISIBLE,
  INDEX `fk_Comments_Comments1_idx` (`Comments_Timestamp` ASC) VISIBLE,
  CONSTRAINT `fk_Comments_Lessons1`
    FOREIGN KEY (`Lessons_LName`)
    REFERENCES `mydb`.`Lessons` (`LName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_Comments1`
    FOREIGN KEY (`Comments_Timestamp`)
    REFERENCES `mydb`.`Comments` (`Timestamp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `SFirst_Name` VARCHAR(45) NOT NULL,
  `SLast_Name` VARCHAR(45) NULL,
  `Classification` VARCHAR(45) NOT NULL,
  `Major` VARCHAR(45) NOT NULL,
  `SUsername` VARCHAR(45) NOT NULL,
  `SPassword` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SFirst_Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Course_Of_Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Course_Of_Students` (
  `Courses_CName` VARCHAR(45) NOT NULL,
  `Student_SFirst_Name` VARCHAR(45) NOT NULL,
  INDEX `fk_Course_Of_Students_Courses1_idx` (`Courses_CName` ASC) VISIBLE,
  INDEX `fk_Course_Of_Students_Student1_idx` (`Student_SFirst_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Of_Students_Courses1`
    FOREIGN KEY (`Courses_CName`)
    REFERENCES `mydb`.`Courses` (`CName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_Of_Students_Student1`
    FOREIGN KEY (`Student_SFirst_Name`)
    REFERENCES `mydb`.`Student` (`SFirst_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Quiz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Quiz` (
  `Quiz_ID` INT NOT NULL,
  `Quiz_Name` VARCHAR(45) NOT NULL,
  `Lessons_LName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Quiz_ID`),
  INDEX `fk_Quiz_Lessons1_idx` (`Lessons_LName` ASC) VISIBLE,
  CONSTRAINT `fk_Quiz_Lessons1`
    FOREIGN KEY (`Lessons_LName`)
    REFERENCES `mydb`.`Lessons` (`LName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Question` (
  `Question_ID` INT NOT NULL,
  `Question_Text` LONGTEXT NOT NULL,
  `Quiz_Quiz_ID` INT NOT NULL,
  PRIMARY KEY (`Question_ID`),
  INDEX `fk_Question_Quiz1_idx` (`Quiz_Quiz_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Question_Quiz1`
    FOREIGN KEY (`Quiz_Quiz_ID`)
    REFERENCES `mydb`.`Quiz` (`Quiz_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Answer` (
  `Answer_ID` INT NOT NULL,
  `Correct_Answer` CHAR(1) NOT NULL,
  `Question_Question_ID` INT NOT NULL,
  PRIMARY KEY (`Answer_ID`),
  INDEX `fk_Answer_Question1_idx` (`Question_Question_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Answer_Question1`
    FOREIGN KEY (`Question_Question_ID`)
    REFERENCES `mydb`.`Question` (`Question_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Quiz_Responses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Quiz_Responses` (
  `Quiz_Quiz_ID` INT NOT NULL,
  `Student_SFirst_Name` VARCHAR(45) NOT NULL,
  `Correct_Count` INT NOT NULL,
  `Incorrect_Count` INT NOT NULL,
  PRIMARY KEY (`Quiz_Quiz_ID`, `Student_SFirst_Name`),
  INDEX `fk_Quiz_has_Student_Student1_idx` (`Student_SFirst_Name` ASC) VISIBLE,
  INDEX `fk_Quiz_has_Student_Quiz1_idx` (`Quiz_Quiz_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Quiz_has_Student_Quiz1`
    FOREIGN KEY (`Quiz_Quiz_ID`)
    REFERENCES `mydb`.`Quiz` (`Quiz_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quiz_has_Student_Student1`
    FOREIGN KEY (`Student_SFirst_Name`)
    REFERENCES `mydb`.`Student` (`SFirst_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
