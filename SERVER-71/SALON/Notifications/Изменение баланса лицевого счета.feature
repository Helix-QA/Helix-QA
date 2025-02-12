﻿#language: ru

@tree

Функционал: Изменение баланса лицевого счета

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Изменение баланса лицевого счета


	И я удаляю все переменные
	И я удаляю объекты "ЖурналыДокументов.ЖурналСообщений" без контроля ссылок
	И я удаляю объекты "Справочники.ШаблоныСообщений" без контроля ссылок
	И я удаляю объекты "Справочники.Уведомления" без контроля ссылок
	И я удаляю объекты "Справочники.СегментыКонтрагентов" без контроля ссылок
	
	И Создание клиента
	И Создание второго клиента 
	И Создание лицевого счёта
	И Проверка на мессенджер

	//Создание уведомления
	И В командном интерфейсе я выбираю "Настройки" "Настройка уведомлений"
	И я нажимаю на кнопку с именем 'Добавить'
	И из выпадающего списка с именем 'Тип' я выбираю точное значение "Изменение баланса лицевого счета"
	И я нажимаю на кнопку с именем 'ИнформироватьПоМессенджеру'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Дополнительно'
	И из выпадающего списка с именем 'ВнешняяСистемаМессенджера' я выбираю по строке "WhatsApp"
	И я нажимаю на кнопку создать поля с именем 'Шаблон'
	И Пауза 1
	И в поле с именем 'Наименование' я ввожу текст "Лицевой счет"
	И в таблице 'ДеревоРеквизитов' я разворачиваю строку:
		| "Представление" |
		| "Лицевой счет"  |
	И в таблице 'ДеревоРеквизитов' я перехожу к строке:
		| "Представление"            |
		| "Состояние лицевого счета" |
	И в таблице 'ДеревоРеквизитов' я выбираю текущую строку
	И в таблице 'ДеревоРеквизитов' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Добавление сегмента клиентов
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

		
	//Начисляю на ЛС клиенту 1
	Дано Я открываю основную форму документа "ПоступлениеДенежныхСредств"
	И из выпадающего списка с именем 'ВидОперации' я выбираю точное значение "Взнос на лицевой счет"
	И в поле с именем 'СуммаДокумента' я ввожу текст "100,00"
	И в поле с именем 'Контрагент' я ввожу текст ""
	И я нажимаю кнопку выбора у поля с именем 'Контрагент'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$Клиент$$"
	И Пауза 1
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю кнопку выбора у поля с именем 'ВидЛицевогоСчета'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ЛС1$$"
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'

	//Начисляю на ЛС клиенту 2	
	Дано Я открываю основную форму документа "ПоступлениеДенежныхСредств"
	И из выпадающего списка с именем 'ВидОперации' я выбираю точное значение "Взнос на лицевой счет"
	И в поле с именем 'СуммаДокумента' я ввожу текст "100,00"
	И в поле с именем 'Контрагент' я ввожу текст ""
	И я нажимаю кнопку выбора у поля с именем 'Контрагент'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$Клиент2$$"
	И пауза 2
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю кнопку выбора у поля с именем 'ВидЛицевогоСчета'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ЛС1$$"
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	
	//Выполняю регламент
	И Регламент отправки уведомлений	

	// Проверям сообщение в журнале
	Дано Я открываю основную форму журнала документов "ЖурналСообщений"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	Если таблица "Список" содержит строки: Тогда
			| 'Получатель' |
			| '$$Клиент$$' |
		И в таблице "Список" я перехожу к строке содержащей подстроки 
		 //Если тест тут ломается значит проблема с сегментом сотрудников в уведомлении. 
				| 'Получатель'  |
				| '$$Клиент3$$' |
	Иначе в таблице "Список" я перехожу к строке содержащей подстроки
				| 'Получатель'  |
				| '$$Клиент2$$' |
	И я закрываю текущее окно
	

