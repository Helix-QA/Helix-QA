﻿#language: ru

@tree

Функционал: Проверка модификатора ЧПУ - Смена владельца.

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Создание данных для тестирования модификатра - Смена владельца.
	И я удаляю все переменные
	И Я создаю Услуга_Персональная
	И Я создаю членство для проверки модификаторов.
	И Я создаю пакет услуг для проверки модификаторов.
	И Я создаю клиента
	И Я создаю гостя.
	И Я создаю модификатор для ЧПУ - Смена владельца.

Сценарий: Проверка данных.
	И Остановка если была ошибка в прошлом сценарии

Сценарий: Проверка модификатора "Смена владельца" с членством.
//Создание продажи членства.
	И Я запоминаю значение выражения 'Формат(ТекущаяДата()-172800, "ДФ=\'дд.ММ.гггг\'")' в переменную "$$ДатаАктЧПУ$$"
	И Я запоминаю значение выражения 'Формат(ТекущаяДата()+259200, "ДФ=\'дд.ММ.гггг\'")' в переменную "$$ЗамороженДО$$"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=\'дд.ММ.гггг\'")' в переменную "$$Сегодня$$"
	Дано я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"	
	И в таблице '_ПодборНоменклатур' я перехожу к строке:
		| "Номенклатура"  |
		| "$$ЧленствоМ$$" |
	И в таблице '_ПодборНоменклатур' я выбираю текущую строку
	И я жду, что в таблице "Запасы" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации'
	И я выбираю пункт контекстного меню с именем 'ЗапасыКнопкаИзменить1' на элементе формы с именем 'Запасы'
	И в таблице 'Запасы' в поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации' я ввожу текст "$$ДатаАктЧПУ$$"
	И Я Оплатил документ
//Открытие ЧПУ и смена владельца
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Членства"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура"  |
		| "$$ЧленствоМ$$" |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'СписокДокументЧленстваПакетыУслугДействияСменаВладельца'
	И из выпадающего списка с именем 'Модификатор' я выбираю точное значение "$$СменаВЛД$$ (Цена: 1 000 руб.)"
	И в поле с именем 'НовыйВладелец' я ввожу текст "$$Гость$$"
	И из выпадающего списка с именем 'НовыйВладелец' я выбираю"$$Гость$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И элемент формы с именем 'Контрагент' стал равен "$$Гость$$"
//Подажа пакета.
	Дано я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"	
	И в таблице '_ПодборНоменклатур' я перехожу к строке:
		| "Номенклатура"  |
		| "$$ПакетУМ$$" |
	И в таблице '_ПодборНоменклатур' я выбираю текущую строку
	И я жду, что в таблице "Запасы" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации'
	И я выбираю пункт контекстного меню с именем 'ЗапасыКнопкаИзменить1' на элементе формы с именем 'Запасы'
	И в таблице 'Запасы' в поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации' я ввожу текст "$$ДатаАктЧПУ$$"
	И Я Оплатил документ
//Смена владельца.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Пакеты"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура" |
		| "$$ПакетУМ$$"  |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'СписокДокументЧленстваПакетыУслугДействияСменаВладельца'
	И из выпадающего списка с именем 'Модификатор' я выбираю точное значение "$$СменаВЛД$$ (Цена: 1 000 руб.)"
	И в поле с именем 'НовыйВладелец' я ввожу текст "$$Гость$$"
	И из выпадающего списка с именем 'НовыйВладелец' я выбираю точное значение "$$Гость$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И элемент формы с именем 'Контрагент' стал равен "$$Гость$$"				

Сценарий: Проверка модификатора "Смена владельца" с указанным сегментом клиентов.
//По тикету 610158
//Добавление сегмента членству.
	И Я запоминаю случайное число в переменную "СегментСменыВладельца"
    Дано я запоминаю значение выражения '"СегментСменыВладельца" + Формат($СегментСменыВладельца$, "ЧГ=0")' в переменную "СегментСменыВладельца"
	Дано Я открываю навигационную ссылку "$$СсылкаЧленствоМ$$"
	И я нажимаю кнопку выбора у поля с именем 'ПродажаДоступнаСегментКлиентов'
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "$СегментСменыВладельца$"
	И из выпадающего списка с именем 'СпособФормирования' я выбираю "Формируется вручную"
	И я нажимаю на кнопку с именем 'ДобавитьВСегмент'
	И я нажимаю на кнопку с именем 'Button0'
	И в таблице 'Список' я перехожу к строке:
		| "ФИО"        |
		| "$$Клиент$$" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ДобавитьВСегмент'	
	И в таблице 'Список' я перехожу к строке:
		| "ФИО"       |
		| "$$Гость$$" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
//Добавление сегмента пакету услуг.
	Дано Я открываю навигационную ссылку "$$СсылкаПакетУМ$$"
	И я нажимаю кнопку выбора у поля с именем 'ПродажаДоступнаСегментКлиентов'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование"            | "Способ формирования" |
		| "$СегментСменыВладельца$" | "Формируется вручную" |
	И в таблице 'Список' я выбираю текущую строку			
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
//Проверка ограничения по сегменту в ЧПУ.
	Дано Я открываю навигационную ссылку "$$СсылкаГость$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Членства"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура"  |
		| "$$ЧленствоМ$$" |
	И в таблице 'Список' я выбираю текущую строку		
	И я нажимаю на кнопку с именем 'СписокДокументЧленстваПакетыУслугДействияСменаВладельца'
	И я нажимаю кнопку выбора у поля с именем 'НовыйВладелец'
	Попытка
		И таблица "Список" содержит только указанные строки:
			| 'ФИО'        |
			| '$$Гость$$'  |
			| '$$Клиент$$' |
	Исключение
		И я регистрирую ошибку "Кол-во клиентов для смены владельца не соответствует кол-ву клиентов сегмента" по данным исключения	
	И в таблице 'Список' я перехожу к строке:
		| "ФИО"        |
		| "$$Клиент$$" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И элемент формы с именем 'Контрагент' стал равен "$$Клиент$$"
	И элемент формы с именем 'Покупатель' стал равен "$$Клиент$$"
	И я закрываю текущее окно
	И В текущем окне я нажимаю кнопку командного интерфейса "Пакеты"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура" |
		| "$$ПакетУМ$$"  |
	И в таблице 'Список' я выбираю текущую строку		
	И я нажимаю на кнопку с именем 'СписокДокументЧленстваПакетыУслугДействияСменаВладельца'
	И я нажимаю кнопку выбора у поля с именем 'НовыйВладелец'
	Попытка
		И таблица "Список" содержит только указанные строки:
			| 'ФИО'        |
			| '$$Гость$$'  |
			| '$$Клиент$$' |
	Исключение
		И я регистрирую ошибку "Кол-во клиентов для смены владельца не соответствует кол-ву клиентов сегмента" по данным исключения	
	И в таблице 'Список' я перехожу к строке:
		| "ФИО"        |
		| "$$Клиент$$" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И элемент формы с именем 'Контрагент' стал равен "$$Клиент$$"
	И элемент формы с именем 'Покупатель' стал равен "$$Клиент$$"
