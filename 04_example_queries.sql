-- Типовые операции (SELECT, INSERT, UPDATE, DELETE)

-- 1. SELECT с сортировкой и фильтром (только опубликованные, самые быстрые)
SELECT `title`, `prep_time` 
FROM `recipes` 
WHERE `status` = 'PUBLISHED'
ORDER BY `prep_time` ASC 
LIMIT 5;

-- 2. SELECT с JOIN (рецепты с авторами)
SELECT 
    `r`.`title`,
    `u`.`login` AS `author`
FROM `recipes` `r`
JOIN `users` `u` ON `r`.`user_id` = `u`.`id`
WHERE `r`.`status` = 'PUBLISHED';

-- 3. Агрегация с GROUP BY (количество рецептов по категориям)
SELECT 
    `c`.`name` AS `category`,
    COUNT(`r`.`id`) AS `recipes_count`
FROM `categories` `c`
LEFT JOIN `recipes` `r` ON `c`.`id` = `r`.`category_id` AND `r`.`status` = 'PUBLISHED'
GROUP BY `c`.`id`, `c`.`name`;

-- 4. SELECT с подзапросом (рецепты быстрее среднего времени)
SELECT `title`, `prep_time`
FROM `recipes`
WHERE `prep_time` < (SELECT AVG(`prep_time`) FROM `recipes` WHERE `status` = 'PUBLISHED')
AND `status` = 'PUBLISHED';

-- 5. INSERT (добавление нового рецепта в черновик)
INSERT INTO `recipes` (`category_id`, `user_id`, `title`, `description`, `prep_time`, `status`, `created_at`) 
VALUES (5, 2, 'Экспериментальный торт', 'Пока в разработке', 120, 'DRAFT', NOW());

-- 6. UPDATE (смена статуса: опубликовать рецепт)
UPDATE `recipes` 
SET `status` = 'PUBLISHED' 
WHERE `status` = 'DRAFT'
ORDER BY `id` DESC
LIMIT 1;

-- 7. DELETE (удалить комментарий)
DELETE FROM `comments` WHERE `id` = 1 LIMIT 1;
