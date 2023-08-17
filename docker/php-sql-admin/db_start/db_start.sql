CREATE TABLE `rta-db`.`user` (`user_id` INT NOT NULL AUTO_INCREMENT , `user_name` VARCHAR(255) NOT NULL , `user_password` VARCHAR(255) NOT NULL , PRIMARY KEY (`user_id`)) ENGINE = InnoDB;
CREATE TABLE `rta-db`.`name` (`name_id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(255) NOT NULL , `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , PRIMARY KEY (`name_id`)) ENGINE = InnoDB;


INSERT INTO `rta-db`.`user` (`user_name`, `user_password`) VALUES ('rodrigo tavares', 'test12345');
INSERT INTO `rta-db`.`user` (`user_name`, `user_password`) VALUES ('muster max', '9876543210');
INSERT INTO `rta-db`.`user` (`user_name`, `user_password`) VALUES ('fritz mueller', 'password');
INSERT INTO `rta-db`.`user` (`user_name`, `user_password`) VALUES ('meier schmidt', 'katze123');