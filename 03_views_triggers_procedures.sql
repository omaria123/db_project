-- Создание представлений для удобной работы

-- 1. recipes_full — рецепты с авторами и категориями (только опубликованные)
CREATE VIEW `recipes_full` AS
SELECT 
    `r`.`id`,
    `r`.`title`,
    `c`.`name` AS `category`,
    `u`.`login` AS `author`,
    `r`.`prep_time`,
    `r`.`description`,
    `r`.`created_at`
FROM `recipes` `r`
JOIN `categories` `c` ON `r`.`category_id` = `c`.`id`
JOIN `users` `u` ON `r`.`user_id` = `u`.`id`
WHERE `r`.`status` = 'PUBLISHED';

-- 2. recipe_details — полная информация о рецепте с ингредиентами
CREATE VIEW `recipe_details` AS
SELECT 
    `r`.`id` AS `recipe_id`,
    `r`.`title`,
    `i`.`name` AS `ingredient`,
    `ri`.`amount`,
    `u`.`short_name` AS `unit`
FROM `recipes` `r`
JOIN `recipe_ingredients` `ri` ON `r`.`id` = `ri`.`recipe_id`
JOIN `ingredients` `i` ON `ri`.`ingredient_id` = `i`.`id`
JOIN `units` `u` ON `ri`.`unit_id` = `u`.`id`
WHERE `r`.`status` = 'PUBLISHED';

-- 3. user_favorites — избранное пользователей
CREATE VIEW `user_favorites` AS
SELECT 
    `u`.`login`,
    `r`.`title` AS `favorite_recipe`,
    `f`.`created_at`
FROM `favorites` `f`
JOIN `users` `u` ON `f`.`user_id` = `u`.`id`
JOIN `recipes` `r` ON `f`.`recipe_id` = `r`.`id`
WHERE `r`.`status` = 'PUBLISHED';

-- 4. Процедура: получить рецепты пользователя по логину
DELIMITER //
CREATE PROCEDURE `GetUserRecipes`(IN user_login VARCHAR(255))
BEGIN
    SELECT `r`.`title`, `r`.`prep_time`, `r`.`status`
    FROM `recipes` `r`
    JOIN `users` `u` ON `r`.`user_id` = `u`.`id`
    WHERE `u`.`login` = user_login;
END//
DELIMITER ;

-- 5. Триггер: проверка рейтинга перед вставкой комментария
DELIMITER //
CREATE TRIGGER `check_rating_before_insert` 
BEFORE INSERT ON `comments` 
FOR EACH ROW 
BEGIN
    IF NEW.rating < 1 THEN
        SET NEW.rating = 1;
    ELSEIF NEW.rating > 5 THEN
        SET NEW.rating = 5;
    END IF;
END//
DELIMITER ;
