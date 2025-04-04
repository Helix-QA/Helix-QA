﻿#language: ru

@tree

Функционал: Проверка триггеров по стоме - Сотрудники.
  

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения
	И я запоминаю имя конфигурации как "ИмяКонфигурации"
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
		Тогда я останавливаю выполнение сценариев данной фичи.

Сценарий: Начальное заполнение ИБ.
	И я удаляю все переменные
	И я удаляю объекты "Справочники.ТриггерныеСобытия" без контроля ссылок
	И я удаляю все переменные
	И я удаляю объекты "Справочники.ТриггерныеСобытия" без контроля ссылок
	И Я генерирую СлучайноеЧисло_Для триггеров стомы и фитнеса
	И Я создаю шаблон сообщения
	И Я создаю врача
	И я создаю даты

Сценарий: Проверка количество и порядок триггеров
	И Остановка если была ошибка в прошлом сценарии
	Дано Я открываю основную форму справочника "ТриггерныеСобытия"
	И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сотрудники"
	И выпадающий список с именем "УсловиеСобытия" стал равен:
		| 'День рождения сотрудника'                   |
		| 'Окончание срока действия сертификата врача' |

Сценарий: Создание триггерных событий для стоматологии.
//Создание триггера - День рождения сотрудника.
	Дано Я открываю основную форму справочника "ТриггерныеСобытия"
	И в поле с именем "Наименование" я ввожу значение выражения "День рождения сотрудника $$СлучайноеЧисло$$"
	И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сотрудники"
	И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "День рождения сотрудника"
	И Я сохраняю триггер для стоматологии	
//Создание триггера - Окончание срока действия сертификата врача.
//	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=\'ЧЧ\'")' в переменную "$ЧасДляТриггера$"
//	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()+300, "ДФ=\'мм\'")' в переменную "$МинутыДляТриггера$"
//	Дано Я открываю основную форму справочника "ТриггерныеСобытия"
//	И в поле с именем "Наименование" я ввожу значение выражения "Окончание срока действия сертификата врача $$СлучайноеЧисло$$"
//	И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сотрудники"
//	И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Окончание срока действия сертификата врача"
//	И я нажимаю на кнопку с именем 'ВыборВремениСтарта'
//	И в поле с именем 'ВремяНачалоЧас' я ввожу текст "$ЧасДляТриггера$"
//	И в поле с именем 'ВремяНачалоМинута' я ввожу текст "$МинутыДляТриггера$"	
//	И я нажимаю на кнопку с именем 'ПрименитьВремя'	
//	И Я сохраняю триггер для стоматологии


Сценарий: Активация триггерных событий для стоматологии.
//Активация триггера - День рождения сотрудника и Окончание срока действия сертификата врача.
	Дано Я открываю навигационную ссылку "$$СсылкаВрача$$"
	И в поле с именем 'ДатаРождения' я ввожу текст "$$Сегодня$$"
	И я нажимаю на кнопку с именем 'ЗаписатьИЗакрытьПлоская'	
//Добавление сертификата врача.	
//	Дано Я открываю навигационную ссылку "$$СсылкаВрача$$"
//	И я нажимаю на кнопку с именем 'КнопкаДобавитьУдостоверениеЛичности'
//	И из выпадающего списка с именем 'ВидДокументаПостоянная' я выбираю точное значение "Сертификат врача"
//	И я нажимаю кнопку выбора у поля с именем 'Специальность'
//	И в таблице 'Список' я перехожу к строке:
//		| "Наименование" |
//		| "Хирургия"     |
//	И в таблице 'Список' я выбираю текущую строку
//	И я нажимаю кнопку выбора у поля с именем 'ДатаВыдачиПостоянная'
//	И в поле с именем 'ДатаВыдачиПостоянная' я ввожу значение выражения "$$Вчера$$"
//	И в поле с именем 'СрокДействия' я ввожу значение выражения "$$Сегодня$$"
//	И я нажимаю на кнопку с именем 'СохранитьДокументПостоянная'
//	И я нажимаю на кнопку с именем 'ЗаписатьИЗакрытьПлоская'

Сценарий: Запуск регламента.
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
		И я выполняю код встроенного языка на сервере
			"""bsl
				ТриггерныеСобытия_КОРП.Регламент_ВыполнитьРегистрациюТриггерныхСобытий2();
			"""
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
		Тогда я выполняю код встроенного языка на сервере
			"""bsl
				ТриггерныеСобытия.Регламент_ВыполнитьРегистрациюТриггерныхСобытий();
			"""				

Сценарий: Проверка журнала регистрации.
//Проверка журнала - День рождения сотрудника.
	Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
	И в таблице 'Список' я перехожу к строке по шаблону:
		| "Наименование"                                |
		| "День рождения сотрудника $$СлучайноеЧисло$$" |
	И в таблице "Список" я выбираю текущую строку
	И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
	И таблица 'Список' содержит строки по шаблону:
		| 'Триггерное событие'                          | 'Действие (описание)'         | 'Статус события'   | 'Контрагент'    | 'Взаимодействие (задача)'   | 'Объект события' |
		| 'День рождения сотрудника $$СлучайноеЧисло$$' | 'Поставить задачу сотруднику' | 'Зарегистрировано' | '$$Сотрудник$$' | '$$Шаблон$$ (не выполнена)' | '$$Сотрудник$$'  |
	И Я деактивировал триггер
	И я закрываю текущее окно		
//Проверка журнала - Окончание срока действия сертификата врача.
//	Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
//	И в таблице 'Список' я перехожу к строке по шаблону:
//		| "Наименование"                                                  |
//		| "Окончание срока действия сертификата врача $$СлучайноеЧисло$$" |
//	И в таблице "Список" я выбираю текущую строку
//	И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
//	Если в таблице "Список" количество строк "равно" 0 Тогда
//		Тогда в течение 300 секунд я выполняю
//			И я выполняю код встроенного языка на сервере
//			"""bsl
//				ТриггерныеСобытия.Регламент_ВыполнитьРегистрациюТриггерныхСобытий();
//			"""	
//			И я нажимаю сочетание клавиш "F5"
//			Если в таблице "Список" количество строк "равно" 1 Тогда
//				Тогда я прерываю цикл
					




























