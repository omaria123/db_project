-- Заполнение таблиц тестовыми данными
-- USE `cookbook`;

-- 1. Пользователи 
INSERT INTO `users` (`login`, `type`, `created_at`) VALUES 
    ('alex', 'ADMIN', NOW()),
    ('maria', 'USER', NOW()),
    ('dmitry', 'USER', NOW()),
    ('elena', 'USER', NOW()),
    ('pavel', 'USER', NOW());

-- 2. Категории 
INSERT INTO `categories` (`name`) VALUES 
    ('Супы'),
    ('Салаты'),
    ('Горячее'),
    ('Выпечка'),
    ('Десерты'),
    ('Завтраки');

-- 3. Единицы измерения 
INSERT INTO `units` (`name`, `short_name`) VALUES 
    ('грамм', 'г'),
    ('килограмм', 'кг'),
    ('миллилитр', 'мл'),
    ('литр', 'л'),
    ('штука', 'шт'),
    ('столовая ложка', 'ст.л.'),
    ('чайная ложка', 'ч.л.'),
    ('щепотка', 'щеп.'),
    ('по вкусу', 'по вкусу'),
    ('стакан', 'ст.');

-- 4. Ингредиенты 
INSERT INTO `ingredients` (`name`) VALUES 
    ('Картофель'),
    ('Морковь'),
    ('Лук репчатый'),
    ('Лук зеленый'),
    ('Чеснок'),
    ('Капуста белокочанная'),
    ('Свёкла'),
    ('Помидоры'),
    ('Огурцы'),
    ('Перец болгарский'),
    ('Брокколи'),
    ('Зелень (укроп, петрушка)'),
    ('Яблоки'),
    ('Бананы'),
    ('Апельсины'),
    ('Лимоны'),
    ('Груши'),
    ('Клубника'),
    ('Малина'),
    ('Смородина'),
    ('Куриное филе'),
    ('Свинина'),
    ('Говядина'),
    ('Фарш свиной'),
    ('Фарш куриный'),
    ('Рыба филе'),
    ('Колбаса варёная'),
    ('Ветчина'),
    ('Молоко'),
    ('Сливки'),
    ('Сметана'),
    ('Творог'),
    ('Сыр твёрдый'),
    ('Сыр плавленый'),
    ('Масло сливочное'),
    ('Яйца'),
    ('Рис'),
    ('Гречка'),
    ('Макароны'),
    ('Мука пшеничная'),
    ('Овсяные хлопья'),
    ('Хлеб'),
    ('Соль'),
    ('Сахар'),
    ('Масло растительное'),
    ('Перец чёрный'),
    ('Уксус'),
    ('Разрыхлитель'),
    ('Ванильный сахар'),
    ('Какао-порошок'),
    ('Салат');

-- 5. Рецепты 
-- Несколько рецептов оставлены в статусе DRAFT для демонстрации
INSERT INTO `recipes` (`category_id`, `user_id`, `title`, `description`, `prep_time`, `status`, `created_at`) VALUES 
    (1, 1, 'Борщ', 'Наваристый борщ со свёклой и капустой', 90, 'PUBLISHED', NOW()),
    (2, 2, 'Оливье', 'Классический новогодний салат', 60, 'PUBLISHED', NOW()),
    (3, 3, 'Гречка с курицей', 'Рассыпчатая гречка с нежным куриным филе', 40, 'PUBLISHED', NOW()),
    (4, 4, 'Сырники', 'Воздушные сырники из творога на сковороде', 30, 'PUBLISHED', NOW()),
    (4, 1, 'Шарлотка яблочная', 'Пышная шарлотка с яблоками на кефире', 50, 'PUBLISHED', NOW()),
    (6, 2, 'Омлет', 'Пышный омлет с молоком на завтрак', 15, 'PUBLISHED', NOW()),
    (2, 3, 'Салат Цезарь', 'Цезарь с курицей и пармезаном', 25, 'PUBLISHED', NOW()),
    (1, 4, 'Куриный суп', 'Лёгкий куриный суп с лапшой и зеленью', 45, 'PUBLISHED', NOW()),
    (4, 1, 'Блины', 'Тонкие блины на молоке', 40, 'PUBLISHED', NOW()),
    (3, 2, 'Картофельное пюре с котлетой', 'Воздушное пюре и сочная куриная котлета', 50, 'PUBLISHED', NOW()),
    (5, 5, 'Торт Наполеон', 'Классический торт с заварным кремом', 180, 'DRAFT', NOW()),
    (6, 3, 'Каша овсяная', 'Полезный завтрак', 10, 'DRAFT', NOW());

-- 6. Состав рецептов — только для опубликованных рецептов

-- Борщ (recipe_id = 1)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (1, (SELECT id FROM `ingredients` WHERE `name` = 'Картофель'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 300),
    (1, (SELECT id FROM `ingredients` WHERE `name` = 'Свёкла'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 200),
    (1, (SELECT id FROM `ingredients` WHERE `name` = 'Морковь'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 1),
    (1, (SELECT id FROM `ingredients` WHERE `name` = 'Лук репчатый'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 1),
    (1, (SELECT id FROM `ingredients` WHERE `name` = 'Капуста белокочанная'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 150),
    (1, (SELECT id FROM `ingredients` WHERE `name` = 'Соль'), (SELECT id FROM `units` WHERE `short_name` = 'ч.л.'), 1);

-- Оливье (recipe_id = 2)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (2, (SELECT id FROM `ingredients` WHERE `name` = 'Картофель'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 400),
    (2, (SELECT id FROM `ingredients` WHERE `name` = 'Морковь'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 2),
    (2, (SELECT id FROM `ingredients` WHERE `name` = 'Яйца'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 4),
    (2, (SELECT id FROM `ingredients` WHERE `name` = 'Колбаса варёная'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 300),
    (2, (SELECT id FROM `ingredients` WHERE `name` = 'Соль'), (SELECT id FROM `units` WHERE `short_name` = 'ч.л.'), 0.5);

-- Гречка с курицей (recipe_id = 3)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (3, (SELECT id FROM `ingredients` WHERE `name` = 'Куриное филе'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 500),
    (3, (SELECT id FROM `ingredients` WHERE `name` = 'Гречка'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 200),
    (3, (SELECT id FROM `ingredients` WHERE `name` = 'Лук репчатый'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 1),
    (3, (SELECT id FROM `ingredients` WHERE `name` = 'Морковь'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 1),
    (3, (SELECT id FROM `ingredients` WHERE `name` = 'Соль'), (SELECT id FROM `units` WHERE `short_name` = 'ч.л.'), 1);

-- Сырники (recipe_id = 4)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (4, (SELECT id FROM `ingredients` WHERE `name` = 'Творог'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 400),
    (4, (SELECT id FROM `ingredients` WHERE `name` = 'Яйца'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 2),
    (4, (SELECT id FROM `ingredients` WHERE `name` = 'Сахар'), (SELECT id FROM `units` WHERE `short_name` = 'ст.л.'), 3),
    (4, (SELECT id FROM `ingredients` WHERE `name` = 'Мука пшеничная'), (SELECT id FROM `units` WHERE `short_name` = 'ст.л.'), 4);

-- Шарлотка яблочная (recipe_id = 5)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (5, (SELECT id FROM `ingredients` WHERE `name` = 'Яйца'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 3),
    (5, (SELECT id FROM `ingredients` WHERE `name` = 'Сахар'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 150),
    (5, (SELECT id FROM `ingredients` WHERE `name` = 'Мука пшеничная'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 150),
    (5, (SELECT id FROM `ingredients` WHERE `name` = 'Яблоки'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 3);

-- Омлет (recipe_id = 6)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (6, (SELECT id FROM `ingredients` WHERE `name` = 'Яйца'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 3),
    (6, (SELECT id FROM `ingredients` WHERE `name` = 'Молоко'), (SELECT id FROM `units` WHERE `short_name` = 'мл'), 100),
    (6, (SELECT id FROM `ingredients` WHERE `name` = 'Соль'), (SELECT id FROM `units` WHERE `short_name` = 'щеп.'), 1);

-- Салат Цезарь (recipe_id = 7)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (7, (SELECT id FROM `ingredients` WHERE `name` = 'Куриное филе'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 300),
    (7, (SELECT id FROM `ingredients` WHERE `name` = 'Салат'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 100),
    (7, (SELECT id FROM `ingredients` WHERE `name` = 'Сыр твёрдый'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 100),
    (7, (SELECT id FROM `ingredients` WHERE `name` = 'Яйца'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 2);

-- Куриный суп (recipe_id = 8)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (8, (SELECT id FROM `ingredients` WHERE `name` = 'Куриное филе'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 400),
    (8, (SELECT id FROM `ingredients` WHERE `name` = 'Картофель'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 300),
    (8, (SELECT id FROM `ingredients` WHERE `name` = 'Морковь'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 1),
    (8, (SELECT id FROM `ingredients` WHERE `name` = 'Лук репчатый'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 1);

-- Блины (recipe_id = 9)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (9, (SELECT id FROM `ingredients` WHERE `name` = 'Яйца'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 2),
    (9, (SELECT id FROM `ingredients` WHERE `name` = 'Молоко'), (SELECT id FROM `units` WHERE `short_name` = 'мл'), 500),
    (9, (SELECT id FROM `ingredients` WHERE `name` = 'Мука пшеничная'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 200),
    (9, (SELECT id FROM `ingredients` WHERE `name` = 'Сахар'), (SELECT id FROM `units` WHERE `short_name` = 'ст.л.'), 2);

-- Картофельное пюре с котлетой (recipe_id = 10)
INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `unit_id`, `amount`) VALUES 
    (10, (SELECT id FROM `ingredients` WHERE `name` = 'Картофель'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 800),
    (10, (SELECT id FROM `ingredients` WHERE `name` = 'Фарш куриный'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 500),
    (10, (SELECT id FROM `ingredients` WHERE `name` = 'Масло сливочное'), (SELECT id FROM `units` WHERE `short_name` = 'г'), 50),
    (10, (SELECT id FROM `ingredients` WHERE `name` = 'Молоко'), (SELECT id FROM `units` WHERE `short_name` = 'мл'), 100),
    (10, (SELECT id FROM `ingredients` WHERE `name` = 'Яйца'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 1),
    (10, (SELECT id FROM `ingredients` WHERE `name` = 'Лук репчатый'), (SELECT id FROM `units` WHERE `short_name` = 'шт'), 1);

-- 7. Комментарии 
INSERT INTO `comments` (`recipe_id`, `user_id`, `rating`, `text`, `created_at`) VALUES 
    (1, 2, 5, 'Очень вкусный борщ!', NOW()),
    (1, 3, 4, 'Хороший рецепт, но свёклы можно побольше', NOW()),
    (5, 4, 5, 'Шарлотка получилась пышной и воздушной', NOW()),
    (6, 3, 4, 'Хороший завтрак, готовлю часто', NOW()),
    (7, 2, 5, 'Цезарь как в ресторане!', NOW());

-- 8. Избранное 
INSERT INTO `favorites` (`user_id`, `recipe_id`, `created_at`) VALUES 
    (2, 1, NOW()),
    (2, 4, NOW()),
    (3, 1, NOW()),
    (3, 5, NOW()),
    (4, 2, NOW()),
    (4, 7, NOW()),
    (5, 3, NOW()),
    (5, 9, NOW());