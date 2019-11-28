
ALTER TABLE `properties` ADD COLUMN `garage` varchar(255) DEFAULT NULL
AFTER `room_menu`;

CREATE TABLE `user_parkings` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `plate` varchar(60) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `zone` longtext,
  `vehicle` longtext,

  PRIMARY KEY (`id`)
);

ALTER TABLE `owned_vehicles` ADD COLUMN  `garageperso` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Garage Personnel' 
AFTER `state` ;
