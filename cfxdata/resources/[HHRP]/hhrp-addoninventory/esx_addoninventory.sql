USE `hhrp-base`;

CREATE TABLE `addon_inventory` (
	`name` varchar(60) NOT NULL,
	`label` varchar(255) NOT NULL,
	`shared` int(11) NOT NULL,

	PRIMARY KEY (`name`)
);

CREATE TABLE `addon_inventory_items` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`inventory_name` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`count` int(11) NOT NULL,
	`owner` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`id`)
);