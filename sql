USE PetStore;
GO

-- Вставка данных в таблицу "Товары"
INSERT INTO Товары (Артикул, Название, Категория, Бренд, Животное, Описание, Состав, Единица, Стоимость, Количество_на_складе)
VALUES
(1001, 'Корм для собак', 'Корма', 'Pedigree', 'Собаки', 'Сухой корм', 'Мясо, овощи', 'кг', 150.00, 100),
(1002, 'Корм для кошек', 'Корма', 'Whiskas', 'Кошки', 'Мокрый корм', 'Рыба, мясо', 'г', 80.00, 200);

-- Вставка данных в таблицу "Клиенты"
INSERT INTO Клиенты (Имя, Телефон, Адрес_доставки, Логин, Пароль)
VALUES
('Иван Иванов', '89991234567', 'г. Москва, ул. Ленина, д. 10', 'ivanivanov', 'ivanpass123'),
('Анна Смирнова', '89991112233', 'г. Санкт-Петербург, пр. Невский, д. 20', 'annasmirnova', 'annapass456');

-- Вставка данных в таблицу "Избранные товары"
INSERT INTO Избранные_товары (Клиент_id, Товар_Артикул)
VALUES
(1, 1001),
(2, 1002);

-- Вставка данных в таблицу "Заказы"
INSERT INTO Заказы (Клиент_id, Дата_заказа, Дата_доставки)
VALUES
(1, '2024-10-01', '2024-10-05'),
(2, '2024-10-02', '2024-10-06');

-- Вставка данных в таблицу "Состав заказа"
INSERT INTO Состав_заказа (Заказ_id, Товар_Артикул, Количество)
VALUES
(1, 1001, 2),
(2, 1002, 3);

-- Вставка данных в таблицу "Поставщики"
INSERT INTO Поставщики (Название, Контактное_лицо, Телефон, Адрес, Email)
VALUES
('ООО ПоставкаКорма', 'Петр Петров', '89993456789', 'г. Казань, ул. Кирова, д. 30', 'supply@food.ru'),
('ИП ДоставкаЗоотоваров', 'Светлана Павлова', '89993214567', 'г. Екатеринбург, ул. Карла Маркса, д. 5', 'contact@zoo.com');

-- Вставка данных в таблицу "Поставки"
INSERT INTO Поставки (Поставщик_id, Дата_поставки, Номер_накладной)
VALUES
(1, '2024-09-01', 'NK12345'),
(2, '2024-09-02', 'NK67890');

-- Вставка данных в таблицу "Состав поставки"
INSERT INTO Состав_поставки (Поставка_id, Товар_Артикул, Количество, Стоимость)
VALUES
(1, 1001, 50, 140.00),
(2, 1002, 100, 75.00);

-- Вставка данных в таблицу "Запасы"
INSERT INTO Запасы (Товар_Артикул, Количество, Дата_обновления)
VALUES
(1001, 150, '2024-09-01'),
(1002, 300, '2024-09-02');
USE PetStore;
GO
-- Таблица "Роли"
CREATE TABLE Роли (
    Код INT PRIMARY KEY IDENTITY,
    Название NVARCHAR(50) NOT NULL UNIQUE
);

-- Добавление записей в таблицу "Роли"
INSERT INTO Роли (Название)
VALUES ('Продавец'), ('Администратор'), ('Покупатель');

-- Таблица "Аккаунты"
CREATE TABLE Аккаунты (
    Логин NVARCHAR(50) PRIMARY KEY,
    Пароль NVARCHAR(100) NOT NULL,
    Код_роли INT FOREIGN KEY REFERENCES Роли(Код) NOT NULL
);
-- Заполнение таблицы "Аккаунты"
INSERT INTO Аккаунты (Логин, Пароль, Код_роли)
VALUES 
('seller1', 'password123', (SELECT Код FROM Роли WHERE Название = 'Продавец')),
('admin1', 'adminpass456', (SELECT Код FROM Роли WHERE Название = 'Администратор')),
('customer1', 'customerpass789', (SELECT Код FROM Роли WHERE Название = 'Покупатель')),
('seller2', 'password321', (SELECT Код FROM Роли WHERE Название = 'Продавец')),
('admin2', 'adminpass654', (SELECT Код FROM Роли WHERE Название = 'Администратор')),
('customer2', 'customerpass987', (SELECT Код FROM Роли WHERE Название = 'Покупатель'));

-- Таблица "Товары"
CREATE TABLE Товары (
    Артикул INT PRIMARY KEY,
    Название NVARCHAR(100) NOT NULL,
    Категория NVARCHAR(50) NOT NULL,
    Бренд NVARCHAR(50),
    Животное NVARCHAR(50),
    Описание NVARCHAR(MAX),
    Состав NVARCHAR(MAX),
    Единица NVARCHAR(20),
    Стоимость DECIMAL(10, 2) NOT NULL,
    Количество_на_складе INT NOT NULL DEFAULT 0
);

-- Таблица "Клиенты"
CREATE TABLE Клиенты (
    Id INT PRIMARY KEY IDENTITY,
    Имя NVARCHAR(100) NOT NULL,
    Телефон NVARCHAR(20) NOT NULL,
    Адрес_доставки NVARCHAR(255),
    Логин NVARCHAR(50) UNIQUE NOT NULL,
    Пароль NVARCHAR(100) NOT NULL
);

-- Таблица "Избранные товары"
CREATE TABLE Избранные_товары (
    Id INT PRIMARY KEY IDENTITY,
    Клиент_id INT FOREIGN KEY REFERENCES Клиенты(Id),
    Товар_Артикул INT FOREIGN KEY REFERENCES Товары(Артикул)
);

-- Таблица "Заказы"
CREATE TABLE Заказы (
    Id INT PRIMARY KEY IDENTITY,
    Клиент_id INT FOREIGN KEY REFERENCES Клиенты(Id),
    Дата_заказа DATE NOT NULL,
    Дата_доставки DATE
);

-- Таблица "Состав заказа"
CREATE TABLE Состав_заказа (
    Id INT PRIMARY KEY IDENTITY,
    Заказ_id INT FOREIGN KEY REFERENCES Заказы(Id),
    Товар_Артикул INT FOREIGN KEY REFERENCES Товары(Артикул),
    Количество INT NOT NULL
);

-- Таблица "Поставщики"
CREATE TABLE Поставщики (
    Id INT PRIMARY KEY IDENTITY,
    Название NVARCHAR(100) NOT NULL,
    Контактное_лицо NVARCHAR(100),
    Телефон NVARCHAR(20),
    Адрес NVARCHAR(255),
    Email NVARCHAR(50)
);

-- Таблица "Поставки"
CREATE TABLE Поставки (
    Id INT PRIMARY KEY IDENTITY,
    Поставщик_id INT FOREIGN KEY REFERENCES Поставщики(Id),
    Дата_поставки DATE NOT NULL,
    Номер_накладной NVARCHAR(50) NOT NULL
);

-- Таблица "Состав поставки"
CREATE TABLE Состав_поставки (
    Id INT PRIMARY KEY IDENTITY,
    Поставка_id INT FOREIGN KEY REFERENCES Поставки(Id),
    Товар_Артикул INT FOREIGN KEY REFERENCES Товары(Артикул),
    Количество INT NOT NULL,
    Стоимость DECIMAL(10, 2) NOT NULL
);

-- Таблица "Запасы"
CREATE TABLE Запасы (
    Id INT PRIMARY KEY IDENTITY,
    Товар_Артикул INT FOREIGN KEY REFERENCES Товары(Артикул),
    Количество INT NOT NULL,
    Дата_обновления DATE NOT NULL DEFAULT GETDATE()
);
-- Создание базы данных PetStore
CREATE DATABASE PetStore;
GO



