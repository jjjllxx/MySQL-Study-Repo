-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `school` DEFAULT CHARACTER SET utf8 ;
USE `school` ;

-- -----------------------------------------------------
-- Table `school`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `date_registered` DATETIME NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`instructors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`instructors` (
  `instructor_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`instructor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `instructor_id` SMALLINT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_courses_instructors1_idx` (`instructor_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_instructors1`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `school`.`instructors` (`instructor_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`enrollment` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`student_id`, `course_id`),
  CONSTRAINT `fk_enrollment_students`
    FOREIGN KEY (`student_id`)
    REFERENCES `school`.`students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollment_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `school`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`tags` (
  `tag_id` TINYINT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `school`.`course_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`course_tags` (
  `course_id` INT NOT NULL,
  `tag_id` TINYINT NOT NULL,
  INDEX `fk_ course_tags_courses1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_ course_tags_tags1_idx` (`tag_id` ASC) VISIBLE,
  PRIMARY KEY (`course_id`, `tag_id`),
  CONSTRAINT `fk_ course_tags_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `school`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ course_tags_tags1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `school`.`tags` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
