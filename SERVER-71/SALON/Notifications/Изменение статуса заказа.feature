﻿#language: ru

@tree

Функционал: Изменение статуса заказа

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Изменение статуса заказа

	И я удаляю все переменные
	И я удаляю объекты "ЖурналыДокументов.ЖурналСообщений" без контроля ссылок
	И я удаляю объекты "Справочники.ШаблоныСообщений" без контроля ссылок
	И я удаляю объекты "Справочники.Уведомления" без контроля ссылок
	И я удаляю объекты "Справочники.СегментыКонтрагентов" без контроля ссылок

	И Создание клиента
	И Создание услуги
	И Создание сотрудника
	И Проверка на мессенджер

*Проверяем статус - Открыт	
	
	// Создание уведомления
	И В командном интерфейсе я выбираю "Настройки" "Настройка уведомлений"
	И я нажимаю на кнопку с именем 'Добавить'
	И из выпадающего списка с именем 'Тип' я выбираю точное значение "Изменение статуса заказа"
	И я нажимаю на кнопку с именем 'ИнформироватьПоМессенджеру'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'ЗадачаСотруднику'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю кнопку выбора у поля с именем 'ИсполнительЗадачи'
	И в таблице 'ТаблицаСотрудников' я активизирую дополнение формы с именем 'ТаблицаСотрудниковСтрокаПоиска'
	И в таблице 'ТаблицаСотрудников' в дополнение формы с именем 'ТаблицаСотрудниковСтрокаПоиска' я ввожу текст "$$Сотрудник$$"
	И я жду, что в таблице "ТаблицаСотрудников" количество строк будет "больше" 0 в течение 60 секунд
	И Пауза 1
	И я нажимаю на кнопку с именем 'Выбрать'				
	И я нажимаю на кнопку с именем 'Дополнительно'
	И из выпадающего списка с именем 'ВнешняяСистемаМессенджера' я выбираю по строке "WhatsApp"
	И я нажимаю на кнопку создать поля с именем 'Шаблон'
	И Пауза 1
	И в поле с именем 'Наименование' я ввожу текст "Заказ был изменен"
	И в таблице 'ДеревоРеквизитов' я разворачиваю строку:
		| "Представление"    |
		| "Заказ покупателя" |
	И в таблице 'ДеревоРеквизитов' я перехожу к строке:
		| "Представление" |
		| "Статус"        |
	И в таблице 'ДеревоРеквизитов' я выбираю текущую строку
	И в таблице 'ДеревоРеквизитов' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	// И Добавление сегмента клиентов
	И из выпадающего списка с именем 'СтатусЗаказа' я выбираю точное значение "Открыт"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранить'
	И я сохраняю навигационную ссылку текущего окна в переменную "Уведомление"	
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	

	// Создание заказа
	Дано Я открываю основную форму документа "ЗаказПокупателя"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыНоменклатура'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$Услуга1$$"
	И в таблице 'Запасы' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'ФормаПровести'
	И я сохраняю навигационную ссылку текущего окна в переменную "Заказ"		
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	
	// Выполняю регламент
	И Регламент отправки уведомлений

	// Проверем в журнале сообщений
	Дано Я открываю основную форму журнала документов "ЖурналСообщений"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И в таблице "Список" я перехожу к строке содержащей подстроки 
				| 'Получатель' |
				| '$$Клиент$$' |
	И я закрываю текущее окно
	И я удаляю объекты "ЖурналыДокументов.ЖурналСообщений" без контроля ссылок
	
* Проверяем статус  - В работе 
	И Я открываю навигационную ссылку "$Уведомление$"
	И из выпадающего списка с именем 'СтатусЗаказа' я выбираю точное значение "В работе"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'		
	И Я открываю навигационную ссылку "$Заказ$"
	И из выпадающего списка с именем 'СостояниеЗаказа' я выбираю точное значение "В работе"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'		
	
	// Выполняю регламент
	И Регламент отправки уведомлений

	// Проверем в журнале сообщений
	Дано Я открываю основную форму журнала документов "ЖурналСообщений"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И в таблице "Список" я перехожу к строке содержащей подстроки 	 
				| 'Получатель' |
				| '$$Клиент$$' |
	И я закрываю текущее окно
	И я удаляю объекты "ЖурналыДокументов.ЖурналСообщений" без контроля ссылок

* Проверяем статус  - Выполнен

	И Я открываю навигационную ссылку "$Уведомление$"
	И из выпадающего списка с именем 'СтатусЗаказа' я выбираю точное значение "Выполнен"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я открываю навигационную ссылку "$Заказ$"
	И из выпадающего списка с именем 'СостояниеЗаказа' я выбираю точное значение "Выполнен"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	
	// Выполняю регламент
	И Регламент отправки уведомлений

	// Проверем в журнале сообщений
	Дано Я открываю основную форму журнала документов "ЖурналСообщений"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И в таблице "Список" я перехожу к строке содержащей подстроки 	 
				| 'Получатель' |
				| '$$Клиент$$' |
	И я закрываю текущее окно
	И я удаляю объекты "ЖурналыДокументов.ЖурналСообщений" без контроля ссылок

* Проверяем статус  - Завершен
	
	И Я открываю навигационную ссылку "$Уведомление$"
	И из выпадающего списка с именем 'СтатусЗаказа' я выбираю точное значение "Завершен"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	
	И Я открываю навигационную ссылку "$Заказ$"
	И из выпадающего списка с именем 'СостояниеЗаказа' я выбираю точное значение "Завершен"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'

	// Выполняю регламент
	И Регламент отправки уведомлений

	// Проверем в журнале сообщений
	Дано Я открываю основную форму журнала документов "ЖурналСообщений"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И в таблице "Список" я перехожу к строке содержащей подстроки 
				| 'Получатель' |
				| '$$Клиент$$' |
	И я закрываю текущее окно
	И я удаляю объекты "ЖурналыДокументов.ЖурналСообщений" без контроля ссылок

* Проверяем статус  - Отменен 

	И Я открываю навигационную ссылку "$Уведомление$"
	И из выпадающего списка с именем 'СтатусЗаказа' я выбираю точное значение "Отменен"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	
	И Я открываю навигационную ссылку "$Заказ$"
	И из выпадающего списка с именем 'СостояниеЗаказа' я выбираю точное значение "Отменен"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'

	// Выполняю регламент
	И Регламент отправки уведомлений

	// Проверем в журнале сообщений
	Дано Я открываю основную форму журнала документов "ЖурналСообщений"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И в таблице "Список" я перехожу к строке содержащей подстроки  
				| 'Получатель' |
				| '$$Клиент$$' |
	И я закрываю текущее окно
