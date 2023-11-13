CREATE TABLE
    IF NOT EXISTS `users` (
        `id` INT,
        `first_name` VARCHAR(32) NOT NULL,
        `last_name` VARCHAR(32) NOT NULL,
        `username` VARCHAR(50) NOT NULL UNIQUE,
        `password` VARCHAR(50) NOT NULL,
        PRIMARY KEY (`id`)
    );

CREATE TABLE
    IF NOT EXISTS `schools` (
        `id` INT,
        `type` ENUM ('Primary', 'Secondary', 'Higher Education') NOT NULL,
        `location` VARCHAR(80) NOT NULL,
        `foundation` SMALLINT UNSIGNED,
        PRIMARY KEY (`id`)
    );

CREATE TABLE
    IF NOT EXISTS `companies` (
        `id` INT,
        `name` VARCHAR(32) NOT NULL,
        `industry` ENUM ('Technology', 'Education', 'Business') NOT NULL,
        `location` VARCHAR(32),
        PRIMARY KEY (`id`)
    );

CREATE TABLE
    IF NOT EXISTS `peer_connections` (
        `first_user_id` INT,
        `second_user_Id` INT,
        FOREIGN KEY (`first_user_id`) REFERENCES `users` (`id`),
        FOREIGN KEY (`second_user_id`) REFERENCES `users` (`id`)
    );

CREATE TABLE
    IF NOT EXISTS `school_connections` (
        `user_id` INT,
        `school_id` INT,
        FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
        FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`)
    );

CREATE TABLE
    IF NOT EXISTS `company_connections` (
        `user_id` INT,
        `company_id` INT,
        FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
        FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`)
    );
