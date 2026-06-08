-- Создание базы данных и всех таблиц
-- CREATE DATABASE `cookbook`;
-- USE `cookbook`;

-- Таблица: users (пользователи)
CREATE TABLE IF NOT EXISTS `users` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `login` VARCHAR(255) NOT NULL,
    `type` ENUM('ADMIN', 'USER') NOT NULL DEFAULT 'USER',
    `created_at` TIMESTAMP,
    PRIMARY KEY (`id`)
);

-- Таблица: categories (категории рецептов)
CREATE TABLE IF NOT EXISTS `categories` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

-- Таблица: recipes (рецепты)
-- status: 'DRAFT' - черновик/не опубликован, 'PUBLISHED' - опубликован
CREATE TABLE IF NOT EXISTS `recipes` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` INT(10) UNSIGNED NOT NULL,
    `user_id` INT(10) UNSIGNED NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `prep_time` TINYINT(3) UNSIGNED,
    `status` ENUM('DRAFT', 'PUBLISHED') NOT NULL DEFAULT 'DRAFT',
    `created_at` TIMESTAMP,
    PRIMARY KEY (`id`)
);

-- Таблица: ingredients (справочник ингредиентов)
CREATE TABLE IF NOT EXISTS `ingredients` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (`id`)
);

-- Таблица: units (справочник единиц измерения)
CREATE TABLE IF NOT EXISTS `units` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `short_name` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`id`)
);

-- Таблица: recipe_ingredients (состав рецепта)
CREATE TABLE IF NOT EXISTS `recipe_ingredients` (
    `recipe_id` INT(10) UNSIGNED NOT NULL,
    `ingredient_id` INT(10) UNSIGNED NOT NULL,
    `unit_id` INT(10) UNSIGNED NOT NULL,
    `amount` DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (`recipe_id`, `ingredient_id`)
);

-- Таблица: comments (комментарии и оценки)
CREATE TABLE IF NOT EXISTS `comments` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `recipe_id` INT(10) UNSIGNED NOT NULL,
    `user_id` INT(10) UNSIGNED NOT NULL,
    `rating` TINYINT(3) UNSIGNED,
    `text` TEXT,
    `created_at` TIMESTAMP,
    PRIMARY KEY (`id`)
);

-- Таблица: favorites (избранные рецепты пользователей)
CREATE TABLE IF NOT EXISTS `favorites` (
    `user_id` INT(10) UNSIGNED NOT NULL,
    `recipe_id` INT(10) UNSIGNED NOT NULL,
    `created_at` TIMESTAMP,
    PRIMARY KEY (`user_id`, `recipe_id`)
);

-- Добавление внешних ключей (связей между таблицами)
ALTER TABLE `recipes` ADD FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`);
ALTER TABLE `recipes` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);

ALTER TABLE `recipe_ingredients` ADD FOREIGN KEY (`recipe_id`) REFERENCES `recipes`(`id`);
ALTER TABLE `recipe_ingredients` ADD FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients`(`id`);
ALTER TABLE `recipe_ingredients` ADD FOREIGN KEY (`unit_id`) REFERENCES `units`(`id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`recipe_id`) REFERENCES `recipes`(`id`);
ALTER TABLE `comments` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);

ALTER TABLE `favorites` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);
ALTER TABLE `favorites` ADD FOREIGN KEY (`recipe_id`) REFERENCES `recipes`(`id`);