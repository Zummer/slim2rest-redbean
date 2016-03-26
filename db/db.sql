-- phpMyAdmin SQL Dump
-- version 4.4.13.1deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Мар 21 2016 г., 03:28
-- Версия сервера: 5.6.28-0ubuntu0.15.10.1
-- Версия PHP: 5.6.11-1ubuntu3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `slim1`
--

-- --------------------------------------------------------

--
-- Структура таблицы `address`
--

CREATE TABLE IF NOT EXISTS `address` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `city` varchar(100) NOT NULL DEFAULT 'Город',
  `street` varchar(100) NOT NULL DEFAULT 'Улица',
  `street_number` int(11) NOT NULL DEFAULT '1',
  `office_number` int(11) NOT NULL DEFAULT '2'
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `address`
--

INSERT INTO `address` (`id`, `company_id`, `city`, `street`, `street_number`, `office_number`) VALUES
(2, 2, 'Ростов-на-Дону, Ростовская область, Россия', 'Вертковская', 31, 343),
(46, 36, 'Красноярск, Красноярский край, Россия', 'Улица', 1, 2),
(84, 74, 'Новосибирск, Новосибирская область, Россия', 'Улица', 1, 2),
(90, 80, 'Москва, город Москва, Россия', 'Улица', 1, 2),
(93, 83, 'Улан-Удэ, Республика Бурятия, Россия', 'Улица', 1, 2),
(94, 84, 'Зеленогорск, Красноярский край, Россия', 'Улица', 1, 2),
(103, 93, 'Черемушки, Новосибирская область, Россия', 'Улица', 1, 2),
(108, 98, 'Новосибирский Академгородок, Россия', 'Улица', 1, 2),
(111, 101, 'Калиновка, Новосибирская область, Россия', 'Улица', 1, 2),
(113, 103, 'Новосибирск, Новосибирская область, Россия', 'Улица', 1, 2),
(114, 104, 'Уренгой, Ямало-Ненецкий автономный округ, Россия', 'Улица', 1, 2),
(115, 105, 'Новый Васюган, Томская область, Россия', 'Улица', 1, 2),
(116, 106, 'Москва, город Москва, Россия', 'Улица', 1, 2),
(118, 108, 'Новосибирск, Новосибирская область, Россия', 'Улица', 1, 2),
(119, 109, '45', 'Улица', 1, 2),
(120, 110, '4545', 'Улица', 1, 2),
(122, 112, '45', 'Улица', 1, 2),
(124, 114, 'w', 'Улица', 1, 2),
(127, 117, 'w', 'Улица', 1, 2),
(135, 125, '3', 'Улица', 1, 2),
(136, 126, '3', 'Улица', 1, 2),
(144, 134, 's', 'Улица', 1, 2),
(146, 136, 'r', 'Улица', 1, 2),
(147, 137, 'sd', 'Улица', 1, 2),
(148, 138, 'sdf', 'Улица', 1, 2),
(149, 139, '456456', 'Улица', 1, 2),
(150, 140, '123', 'Улица', 1, 2),
(151, 141, 'hhh', 'Улица', 1, 2),
(152, 142, 'kj', 'Улица', 1, 2),
(153, 143, '234', 'Улица', 1, 2),
(156, 146, 'Уфа, Республика Башкортостан, Россия', 'Улица', 1, 2),
(157, 147, 'wer', 'Улица', 1, 2),
(158, 148, 'w', 'Улица', 1, 2),
(169, 159, 'werer', 'Улица', 1, 2),
(181, 171, 'fg', 'Улица', 1, 2),
(182, 172, 'rtyrt46456', 'Улица', 1, 2),
(183, 173, 'dfg', 'Улица', 1, 2),
(192, 182, 'rty', 'Улица', 1, 2),
(193, 183, 'wer', 'Улица', 1, 2),
(195, 185, 'ert3', 'Улица', 1, 2),
(206, 196, 'fgh', 'Улица', 1, 2),
(207, 197, '777', 'Улица', 1, 2),
(208, 198, 'rty', 'Улица', 1, 2),
(209, 199, 'tyu', 'Улица', 1, 2),
(210, 200, 'yui', 'Улица', 1, 2),
(211, 201, 'ouio', 'Улица', 1, 2),
(212, 202, 'wer', 'Улица', 1, 2),
(213, 203, 'tyu', 'Улица', 1, 2),
(214, 204, 'tyutyuty', 'Улица', 1, 2),
(215, 205, 'ty', 'Улица', 1, 2),
(216, 206, 'iouou', 'Улица', 1, 2),
(219, 209, 'gdfdgf', 'Улица', 1, 2),
(220, 210, 'Новый Уренгой, Ямало-Ненецкий автономный округ, Россия', 'Улица', 1, 2),
(221, 211, 'tyu', 'Улица', 1, 2),
(222, 212, 'Калининград, Калининградская область, Россия', 'Улица', 1, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `company`
--

INSERT INTO `company` (`id`, `name`) VALUES
(2, 'Производственное предприятие ООО'),
(36, 'Название предприятия №555'),
(74, 'Совершенно новое предприятие'),
(80, 'Транснациональная корпорация АО'),
(83, 'Охранное агентство ОА'),
(84, 'Рога и копыта ООО'),
(93, 'Предприятие №1'),
(98, 'Предприятие №2'),
(101, 'Предприятие №3'),
(103, 'Предприятие №4'),
(104, 'Предприятие №5'),
(105, 'Предприятие №6'),
(106, 'Фирма №1'),
(108, 'Завод низковольтной аппаратуры'),
(109, '45'),
(110, '45454'),
(112, '453'),
(114, 'w'),
(117, 'w'),
(125, '3'),
(126, '3'),
(134, 's'),
(136, 'r'),
(137, 'sd'),
(138, 'sdf'),
(139, '5546464564'),
(140, '456456'),
(141, 'gg'),
(142, 'kj'),
(143, '234'),
(146, 'уке'),
(147, 'ewr'),
(148, 'we4564'),
(159, 'ewr234234erttyutyu'),
(171, 'fgh'),
(172, 'rytrty'),
(173, 'dfg'),
(182, 'rty'),
(183, 'ewr'),
(185, 'ert'),
(196, 'fgh'),
(197, '777'),
(198, 'rytrty'),
(199, 'rtyrtyuty'),
(200, 'yuiyu'),
(201, 'uioui'),
(202, 'werwer'),
(203, 'tyutyuty'),
(204, 'tyutyu'),
(205, 'ty'),
(206, 'yiuyiuy'),
(209, 'dfgdfg'),
(210, 'Алюминиевый завод'),
(211, 'tyuty'),
(212, 'Предприятие №200');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `first_name`, `last_name`, `address`) VALUES
(1, 'lucentx123', 'Aron', 'Barbosa', 'Manila, Philippines'),
(2, 'ozzy', 'Ozzy', 'Osbourne', 'England'),
(3, 'tony', 'Tony333', 'Iommi', 'England'),
(4, 'wer', 'werwe', 'werwer', 'wer'),
(6, 'werwerwe', 'werwer', 'werwer', 'werwer'),
(7, '234', '234', '234234', '234234');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adresses_companies_id_fk` (`company_id`);

--
-- Индексы таблицы `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=223;
--
-- AUTO_INCREMENT для таблицы `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=213;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `adresses_companies_id_fk` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
