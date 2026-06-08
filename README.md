# Проект: Кулинарная книга

## Описание 

**Кулинарная книга** — это система для хранения, систематизации и обмена рецептами. Проект автоматизирует деятельность по управлению рецептами: пользователи могут создавать рецепты, добавлять их в избранное, оставлять комментарии и оценки, а также управлять статусом публикации.

### Основные функции системы:

- Регистрация пользователей (обычные пользователи и администраторы)
- Создание, просмотр, редактирование и удаление рецептов
- Категоризация рецептов (супы, салаты, выпечка и т.д.)
- Добавление рецептов в избранное
- Комментирование и оценка рецептов
- Управление статусом рецепта (черновик / опубликован)
- Поиск рецептов по различным критериям

---

## Схема

Ниже представлена схема, на ней отображены все таблицы, их поля и связи между ними.

<img width="1703" height="601" alt="image" src="https://github.com/user-attachments/assets/2af6e9c4-9408-4a33-a076-1f6049835eb6" />


*Рисунок 1 — Схема базы данных «Кулинарная книга»*

---

## Описание таблиц и связей

### 1. Таблица `users` (пользователи)

| Поле | Тип | Описание |
|------|-----|----------|
| `id` | INT(10) UNSIGNED | Уникальный идентификатор пользователя |
| `login` | VARCHAR(255) | Логин пользователя |
| `type` | ENUM('ADMIN', 'USER') | Роль пользователя |
| `created_at` | TIMESTAMP | Дата и время регистрации |

---

### 2. Таблица `categories` (категории рецептов)

| Поле | Тип | Описание |
|------|-----|----------|
| `id` | INT(10) UNSIGNED | Уникальный идентификатор категории |
| `name` | VARCHAR(255) | Название категории |

---

### 3. Таблица `recipes` (рецепты)

| Поле | Тип | Описание |
|------|-----|----------|
| `id` | INT(10) UNSIGNED | Уникальный идентификатор рецепта |
| `category_id` | INT(10) UNSIGNED | Категория рецепта |
| `user_id` | INT(10) UNSIGNED | Автор рецепта |
| `title` | VARCHAR(255) | Название блюда |
| `description` | TEXT | Описание приготовления |
| `prep_time` | TINYINT(3) UNSIGNED | Время приготовления (минуты) |
| `status` | ENUM('DRAFT','PUBLISHED') | Статус публикации |
| `created_at` | TIMESTAMP | Дата добавления |

---

### 4. Таблица `ingredients` (ингредиенты)

| Поле | Тип | Описание |
|------|-----|----------|
| `id` | INT(10) UNSIGNED | Уникальный идентификатор ингредиента |
| `name` | VARCHAR(255) | Название ингредиента |

---

### 5. Таблица `units` (единицы измерения)

| Поле | Тип | Описание |
|------|-----|----------|
| `id` | INT(10) UNSIGNED | Уникальный идентификатор единицы |
| `name` | VARCHAR(50) | Полное название (грамм, миллилитр...) |
| `short_name` | VARCHAR(10) | Сокращение (г, мл, шт...) |

---

### 6. Таблица `recipe_ingredients` (состав рецепта)

| Поле | Тип | Описание |
|------|-----|----------|
| `recipe_id` | INT(10) UNSIGNED | Ссылка на рецепт |
| `ingredient_id` | INT(10) UNSIGNED | Ссылка на ингредиент |
| `unit_id` | INT(10) UNSIGNED | Единица измерения |
| `amount` | DECIMAL(8,2) | Количество |

---

### 7. Таблица `comments` (комментарии и оценки)

| Поле | Тип | Описание |
|------|-----|----------|
| `id` | INT(10) UNSIGNED | Уникальный идентификатор комментария |
| `recipe_id` | INT(10) UNSIGNED | Рецепт, к которому оставлен комментарий |
| `user_id` | INT(10) UNSIGNED | Автор комментария |
| `rating` | TINYINT(3) UNSIGNED | Оценка (1–5) |
| `text` | TEXT | Текст комментария |
| `created_at` | TIMESTAMP | Дата и время комментария |

---

### 8. Таблица `favorites` (избранное)

| Поле | Тип | Описание |
|------|-----|----------|
| `user_id` | INT(10) UNSIGNED | Пользователь |
| `recipe_id` | INT(10) UNSIGNED | Рецепт в избранном |
| `created_at` | TIMESTAMP | Дата добавления |

---

База данных наполнена тестовыми данными: пользователи, категории, рецепты, ингредиенты, комментарии и избранное — всё это позволяет наглядно продемонстрировать работу всех типовых операций.

---
## Представления (VIEW)
В проекте (файл 03_views_triggers_procedures.sql) созданы 3 представления для упрощения работы с данными.

### 1. `recipes_full` — рецепты с авторами и категориями
Назначение: объединяет таблицы `recipes`, `users`, `categories`, чтобы показывать рецепты с читаемыми названиями категорий и логинами авторов.

Поля: `id`, `title`, `category`, `author`, `prep_time`, `description`, `created_at`

Демонстрация:
```sql
SELECT * FROM `recipes_full` LIMIT 5;
```

<img width="1000" height="212" alt="image" src="https://github.com/user-attachments/assets/0f2932e0-f542-46a3-adcd-8a8da2a1e924" />

### 2. `recipe_details` — рецепт со списком ингредиентов
Назначение: показывает полную информацию о рецепте: название блюда, все ингредиенты с количествами и единицами измерения.

Поля: `recipe_id, title`, `ingredient`, `amount`, `unit`

Демонстрация (ингредиенты для борща):

```sql
SELECT * FROM `recipe_details` WHERE `title` = 'Борщ';
```
<img width="463" height="233" alt="image" src="https://github.com/user-attachments/assets/b6b69437-022d-4ad8-8c2d-86dedc8d1614" />

### 3. `user_favorites` — избранное пользователей
Назначение: показывает, какие рецепты добавил в избранное каждый пользователь.

Поля: `login`, `favorite_recipe`, `created_at`

Демонстрация:

```sql
SELECT * FROM `user_favorites`;
```

<img width="392" height="304" alt="image" src="https://github.com/user-attachments/assets/57aafd81-403d-4546-9153-2404ee3d8837" />

## Процедура (PROCEDURE)
`GetUserRecipes` — получение рецептов пользователя по логину

Назначение: возвращает все рецепты (название, время приготовления, статус) для указанного пользователя.

Параметры: user_login (VARCHAR) — логин пользователя

Демонстрация:

```sql
CALL `GetUserRecipes`('maria');
```

<img width="474" height="117" alt="image" src="https://github.com/user-attachments/assets/b8176d55-7506-41c7-b04e-eac0850e1153" />

## Триггер (TRIGGER)
`check_rating_before_insert` — проверка рейтинга

Назначение: автоматически корректирует оценку при добавлении комментария. Если пользователь пытается поставить оценку ниже 1 или выше 5, триггер исправляет её на 1 или 5 соответственно.

Демонстрация:

Попробуем вставить комментарий с некорректной оценкой 10:

```sql
INSERT INTO `comments` (`recipe_id`, `user_id`, `rating`, `text`, `created_at`) 
VALUES (1, 5, 10, 'Тестовый комментарий', NOW());

SELECT `rating` FROM `comments` WHERE `text` = 'Тестовый комментарий';
```

<img width="93" height="60" alt="image" src="https://github.com/user-attachments/assets/5030b8ec-b98c-4ac7-ae98-a68a73e079c7" />

Триггер автоматически исправил оценку 10 на 5.

<img width="772" height="205" alt="image" src="https://github.com/user-attachments/assets/2d938ad4-f3bf-4a06-9f93-b9fff3ea02e3" />

## Типовые операции (примеры с результатами)

### 1. SELECT с сортировкой (самые быстрые рецепты)
```sql
SELECT `title`, `prep_time` 
FROM `recipes` 
WHERE `status` = 'PUBLISHED'
ORDER BY `prep_time` ASC 
LIMIT 5;
```
<img width="289" height="180" alt="image" src="https://github.com/user-attachments/assets/807c0003-a539-4898-b91d-65c93f45e8b3" />

### 2. SELECT с JOIN (рецепты с авторами)
```sql
SELECT 
    `r`.`title`,
    `u`.`login` AS `author`
FROM `recipes` `r`
JOIN `users` `u` ON `r`.`user_id` = `u`.`id`
WHERE `r`.`status` = 'PUBLISHED';
```
<img width="328" height="311" alt="image" src="https://github.com/user-attachments/assets/96bca5a9-8593-4dbd-94ba-ba3917dec788" />

### 3. Агрегация с GROUP BY (количество рецептов по категориям)
```sql
SELECT 
    `c`.`name` AS `category`,
    COUNT(`r`.`id`) AS `recipes_count`
FROM `categories` `c`
LEFT JOIN `recipes` `r` ON `c`.`id` = `r`.`category_id` AND `r`.`status` = 'PUBLISHED'
GROUP BY `c`.`id`, `c`.`name`; 
```
<img width="236" height="200" alt="image" src="https://github.com/user-attachments/assets/f6bd3b30-308e-48a3-a774-3d1e363a8d28" />

### 4. SELECT с подзапросом (рецепты быстрее среднего времени)
```sql
SELECT `title`, `prep_time`
FROM `recipes`
WHERE `prep_time` < (SELECT AVG(`prep_time`) FROM `recipes` WHERE `status` = 'PUBLISHED')
AND `status` = 'PUBLISHED';
```
<img width="258" height="177" alt="image" src="https://github.com/user-attachments/assets/cd0c5894-65f9-42a9-8e36-383676a7621d" />

### 5. INSERT (добавление нового рецепта в черновик)
```sql
INSERT INTO `recipes` (`category_id`, `user_id`, `title`, `description`, `prep_time`, `status`, `created_at`) 
VALUES (5, 2, 'Экспериментальный торт', 'Пока в разработке', 120, 'DRAFT', NOW());
```
<img width="1185" height="31" alt="image" src="https://github.com/user-attachments/assets/22ab8615-99fc-4dda-9bfe-eaaa57402bad" />

### 6. UPDATE (смена статуса: опубликовать рецепт)
```sql
UPDATE `recipes` 
SET `status` = 'PUBLISHED' 
WHERE `status` = 'DRAFT'
ORDER BY `id` DESC
LIMIT 1;
```
<img width="1187" height="37" alt="image" src="https://github.com/user-attachments/assets/84b26b29-eb03-4fdc-bc8d-cd89a5bfe3c0" />

### 7. DELETE (удалить комментарий)
```sql
DELETE FROM `comments` WHERE `id` = 8 LIMIT 1;
```
До запроса:

<img width="807" height="206" alt="image" src="https://github.com/user-attachments/assets/c5eb9189-4c5d-48da-a76a-c011461554cc" />

После:

<img width="807" height="174" alt="image" src="https://github.com/user-attachments/assets/cef6c1e2-1d6b-472a-b55a-2463f33e45eb" />


## Заключение
В ходе выполнения проекта была спроектирована и реализована база данных «Кулинарная книга».

В результате работы создано 8 таблиц, связанных между собой внешними ключами, 3 представления для частых выборок, одна хранимая процедура и один триггер.

Отдельное внимание уделено типовым операциям. Каждый запрос протестирован в phpMyAdmin и подтверждён скриншотами результатов.
