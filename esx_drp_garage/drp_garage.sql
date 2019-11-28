ALTER TABLE `owned_vehicles` ADD `state` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Etat de la voiture' AFTER `owner`;

ALTER TABLE `owned_vehicles` ADD `garage_position` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Garage Pos' AFTER `state` ;

