﻿#language: ru

@tree

Функционал: Проверка триггерных событий в конфигурациях фитнеса и стоматологии.

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения
	
Сценарий: Начальное заполнение ИБ.
	И я удаляю все переменные
	И я удаляю объекты "Справочники.ТриггерныеСобытия" без контроля ссылок
	И Я генерирую СлучайноеЧисло_Для триггеров стомы и фитнеса
	И Я создаю Тренера
	И Я создаю шаблон сообщения
	И Я создаю клиента
	И Я создаю Услуга_Персональная
	И Я создаю Помещение

Сценарий: Проверка созданных данных и наличие всех триггеров.
	И Остановка если была ошибка в прошлом сценарии
	Дано Я открываю основную форму справочника "ТриггерныеСобытия"
	И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Лицевые счета'
	И выпадающий список с именем "УсловиеСобытия" стал равен:
		| 'Взнос на лицевой счет'                                      |
		| 'Окончание срока действия лицевого счета'                    |
		| 'Остаток денежных средств на лицевом счете меньше или равен' |
		| 'Списание с лицевого счета'                                  |
	
Сценарий: Создание триггеров для фитнеса.
//Создание триггера - Взнос на лицевой счет.
	Дано Я открываю основную форму справочника "ТриггерныеСобытия"
	И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Лицевые счета'
	И из выпадающего списка с именем "УсловиеСобытия" я выбираю точное значение 'Взнос на лицевой счет'
	И в поле с именем 'Наименование' я ввожу текст 'Взнос на лицевой счет $$СлучайноеЧисло$$'
	И Я сохраняю триггер для фитнес клуба
//Создание триггера - Списание с лицевого счета.
	Дано Я открываю основную форму справочника "ТриггерныеСобытия"
	И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Лицевые счета'
	И из выпадающего списка с именем "УсловиеСобытия" я выбираю точное значение 'Списание с лицевого счета'
	И в поле с именем 'Наименование' я ввожу текст 'Списание с лицевого счета $$СлучайноеЧисло$$'
	И Я сохраняю триггер для фитнес клуба
//Создание триггера - Остаток денежных средств на лицевом счете меньше или равен.
	Дано Я открываю основную форму справочника "ТриггерныеСобытия"
	И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Лицевые счета'
	И из выпадающего списка с именем "УсловиеСобытия" я выбираю точное значение 'Остаток денежных средств на лицевом счете меньше или равен'
	И в поле с именем 'Наименование' я ввожу текст 'Остаток денежных средств на лицевом счете меньше или равен $$СлучайноеЧисло$$'
	И в поле с именем 'ПараметрСобытия' я ввожу текст '8000'
	И Я сохраняю триггер для фитнес клуба
//Создание триггера - Окончание срока действия лицевого счета (до события).
	Дано Я открываю основную форму справочника "ТриггерныеСобытия"
	И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Лицевые счета'
	И из выпадающего списка с именем "УсловиеСобытия" я выбираю точное значение 'Окончание срока действия лицевого счета'
	И в поле с именем 'Наименование' я ввожу текст 'Окончание срока действия лицевого счета $$СлучайноеЧисло$$'
	И из выпадающего списка с именем "МоментСобытия" я выбираю точное значение 'До события'
	И в поле с именем 'ПериодСобытия' я ввожу текст '1'
	И Я сохраняю триггер для фитнес клуба

Сценарий: Активация триггерных собитый фитнес.
//Активация триггера - Взнос на лицевой счет.
	И В командном интерфейсе я выбираю 'Главное' 'Рецепция'
	И в поле с именем 'ТекущийКлиент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем 'ТекущийКлиент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на гиперссылку с именем "ВнестиНаЛицевойСчет"
	И я нажимаю кнопку выбора у поля с именем "ВидЛицевогоСчета"
	И в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000001' | 'Основной'     |
	И в таблице "Список" я выбираю текущую строку
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст '5000'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я проверяю ЗакрытиеСмены
//Активация триггера - Остаток денежных средств на лицевом счете меньше или равен.
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "Контрагент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю "$$УслугаПерсональная$$"
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_1x0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_1x0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я проверяю ЗакрытиеСмены
//Активация триггера - Окончание срока действия лицевого счета (до события).
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()+86400, "ДЛФ=Д")' в переменную "Завтра"
	И В командном интерфейсе я выбираю 'Главное' 'Рецепция'
	И в поле с именем 'ТекущийКлиент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "ТекущийКлиент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на гиперссылку с именем "ВнестиНаЛицевойСчет"
	И я нажимаю на кнопку с именем 'НовыйЛицевойСчет'
	И я нажимаю на кнопку создать поля с именем "ВидЛицевогоСчета"
	И в поле с именем 'Наименование' я ввожу текст 'ЛицСчетПериод$$СлучайноеЧисло$$'
	И из выпадающего списка с именем "ОграничениеПоСрокуДействия" я выбираю точное значение 'Действует с'
	И в поле с именем 'СрокДействияДатойС' я ввожу текст '$Завтра$'
	И в поле с именем 'СрокДействияДатойПо' я ввожу текст '$Завтра$'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст '1 000,00'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я закрываю окно 'Исходные данные чека'
	И я нажимаю на гиперссылку с именем "Лицевой_Бонусный_Счет_Контрагента_1"
	И в поле с именем 'СрокДействияНачало' я ввожу текст '$Завтра$'
	И в поле с именем 'СрокДействияКонец' я ввожу текст '$Завтра$'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Активация триггера - Списание с лицевого счета.
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "Контрагент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю "$$УслугаПерсональная$$"
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_1x0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_1x0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И я закрываю окно "Исходные данные чека"

Сценарий: Запускаю регламента - Регистрация триггерных событий
	И Я запускаю регламент регистрации триггерных событий в Фитнесе.

Сценарий: Проверка журнала в фитнесе.
//Проверка журнала - Взнос на лицевой счет.
	Дано Я открываю основную форму списка справочника "ТриггерныеСобытия"
	И в таблице "Список" я перехожу к строке:
		| 'Наименование'                             |
		| 'Взнос на лицевой счет $$СлучайноеЧисло$$' |
	И в таблице "Список" я выбираю текущую строку
	И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
	И Я сношу дату за прошлый период в журнале регистрации триггерных событий.
	И таблица "Список" содержит строки по шаблону:
		| "Триггерное событие"                       | "Контрагент" | "Статус события"   | "Период" | "Часовой пояс" | "Источник события" | "Объект события"                                    | "Действие (описание)"         | "Структурная единица" | "Взаимодействие (задача)"   | "Сведения об ошибке или причине отклонения действия" |
		| "Взнос на лицевой счет $$СлучайноеЧисло$$" | "$$Клиент$$" | "Зарегистрировано" | "*"      | "*"            | ""                 | "Взнос на лицевой счет наличными средствами * от *" | "Поставить задачу сотруднику" | "*"                   | "$$Шаблон$$ (не выполнена)" | ""                                                   |
	И Я деактивировал триггер
	И я закрываю текущее окно
//Проверка журнала - Списание с лицевого счета.
	Дано Я открываю основную форму списка справочника "ТриггерныеСобытия"
	И в таблице "Список" я перехожу к строке:
		| 'Наименование'                                 |
		| 'Списание с лицевого счета $$СлучайноеЧисло$$' |
	И в таблице "Список" я выбираю текущую строку
	И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
	И Я сношу дату за прошлый период в журнале регистрации триггерных событий.
	И таблица "Список" содержит строки по шаблону:
		| 'Триггерное событие'                           | 'Контрагент' | 'Статус события'   | 'Часовой пояс' | 'Источник события' | 'Действие (описание)'         | 'Структурная единица' | 'Взаимодействие (задача)'   | 'Сведения об ошибке или причине отклонения действия' |
		| 'Списание с лицевого счета $$СлучайноеЧисло$$' | '$$Клиент$$' | 'Зарегистрировано' | '*'            | ''                 | 'Поставить задачу сотруднику' | '*'                   | '$$Шаблон$$ (не выполнена)' | ''                                                   |
	И Я деактивировал триггер
	И я закрываю текущее окно	
//Проверка журнала - Остаток денежных средств на лицевом счете меньше или равен.
	И В командном интерфейсе я выбираю 'CRM' 'Триггерные события'
	И в таблице "Список" я перехожу к строке:
		| 'Наименование'                                                                  |
		| 'Остаток денежных средств на лицевом счете меньше или равен $$СлучайноеЧисло$$' |
	И в таблице "Список" я выбираю текущую строку
	И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
	И Я сношу дату за прошлый период в журнале регистрации триггерных событий.
	И таблица "Список" содержит строки по шаблону:
		| "Триггерное событие"                                                            | "Контрагент" | "Статус события"   | "Период" | "Часовой пояс" | "Источник события" | "Объект события" | "Действие (описание)"         | "Структурная единица" | "Взаимодействие (задача)"   | "Сведения об ошибке или причине отклонения действия" |
		| "Остаток денежных средств на лицевом счете меньше или равен $$СлучайноеЧисло$$" | "$$Клиент$$" | "Зарегистрировано" | "*"      | "*"            | ""                 | "*"              | "Поставить задачу сотруднику" | "*"                   | "$$Шаблон$$ (не выполнена)" | ""                                                   |
	И Я деактивировал триггер
//Проверка журнала - Окончание срока действия лицевого счета (до события).
	И я выполняю код встроенного языка на сервере
	"""bsl
		ТриггерныеСобытия_КОРП.Регламент_ВыполнитьРегистрациюТриггерныхСобытий2();
	"""
	И В командном интерфейсе я выбираю 'CRM' 'Триггерные события'
	И в таблице "Список" я перехожу к строке:
		| 'Наименование'                                               |
		| 'Окончание срока действия лицевого счета $$СлучайноеЧисло$$' |
	И в таблице "Список" я выбираю текущую строку
	И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
	И Я сношу дату за прошлый период в журнале регистрации триггерных событий.
	И таблица "Список" содержит строки по шаблону:
		| "Триггерное событие"                                         | "Контрагент" | "Статус события"   | "Период" | "Часовой пояс" | "Источник события" | "Объект события"                               | "Действие (описание)"         | "Структурная единица" | "Взаимодействие (задача)"   | "Сведения об ошибке или причине отклонения действия" |
		| "Окончание срока действия лицевого счета $$СлучайноеЧисло$$" | "$$Клиент$$" | "Зарегистрировано" | "*"      | "*"            | ""                 | "ЛицСчетПериод$$СлучайноеЧисло$$ * $$Клиент$$" | "Поставить задачу сотруднику" | "*"                   | "$$Шаблон$$ (не выполнена)" | ""                                                   |
	И Я деактивировал триггер