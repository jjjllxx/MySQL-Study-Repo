-- MySQL Workbench Synchronization
-- Generated: 2022-06-03 13:16
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: 金乐轩

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `school`.`enrollment` 
DROP FOREIGN KEY `fk_enrollment_courses`;

ALTER TABLE `school`.`courses` 
DROP FOREIGN KEY `fk_courses_instructors1`;

ALTER TABLE `school`.`course_tags` 
DROP FOREIGN KEY `fk_ course_tags_courses1`,
DROP FOREIGN KEY `fk_ course_tags_tags1`;

ALTER TABLE `school`.`students` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`enrollment` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
ADD COLUMN `coupon` VARCHAR(50) NULL DEFAULT NULL AFTER `price`,
DROP INDEX `fk_enrollment_courses` ;
;

ALTER TABLE `school`.`courses` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`tags` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`course_tags` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`instructors` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `school`.`enrollment` 
DROP FOREIGN KEY `fk_enrollment_students`;

ALTER TABLE `school`.`enrollment` ADD CONSTRAINT `fk_enrollment_students`
  FOREIGN KEY (`student_id`)
  REFERENCES `school`.`students` (`student_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_enrollment_courses`
  FOREIGN KEY (`course_id`)
  REFERENCES `school`.`courses` (`course_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE `school`.`courses` 
ADD CONSTRAINT `fk_courses_instructors1`
  FOREIGN KEY (`instructor_id`)
  REFERENCES `school`.`instructors` (`instructor_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE `school`.`course_tags` 
ADD CONSTRAINT `fk_ course_tags_courses1`
  FOREIGN KEY (`course_id`)
  REFERENCES `school`.`courses` (`course_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ course_tags_tags1`
  FOREIGN KEY (`tag_id`)
  REFERENCES `school`.`tags` (`tag_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
