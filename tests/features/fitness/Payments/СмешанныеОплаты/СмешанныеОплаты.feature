﻿#language: ru

@tree

Функционал: Проверка смешанных оплат 	

Сценарий: 01. Создание сотрудника/клиента/номенклатур
	Дано я подключаю TestClient "Этот клиент" логин "Админ" пароль ""
	И я закрываю все окна клиентского приложения
	И я удаляю все переменные
	// Проверка на наличие сотрудника
	И В командном интерфейсе я выбираю "Персонал" "Сотрудники"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "МенеджерОП_Тест"
	И Пауза 1
	Если в таблице "Список" 0 строк Тогда
		// Создание сотрудника
		И СО_Я создаю менеджера
		// Настройки менеджера 
		И Я открываю навигационную ссылку "$$СсылкаМенеджер$$"
		И я изменяю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "$$Менеджер$$"	
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Менеджер отдела продаж"
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		
	// Создание клиента
	И Я создаю клиента

	// Настройка клиента
	// Взнос на ЛС
	И В командном интерфейсе я выбираю "Главное" "Рецепция"
	И из выпадающего списка с именем 'ТекущийКлиент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на гиперссылку с именем 'ВнестиНаЛицевойСчет'
	И я нажимаю кнопку выбора у поля с именем 'ВидЛицевогоСчета'
	И в таблице 'Список' я перехожу к строке по шаблону:
		| "Код" | "Наименование" | "Организация" |
		| "*"   | "Основной"     | "*"           |
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "15 000,00"
	И я нажимаю на кнопку с именем 'Оплатить'
	И я проверяю закрытие смены
	// Создание бонусного счета
	И Я запоминаю случайное число в переменную "НомерСчета"
	И Я запоминаю значение выражения '"Бонусный" + Формат($НомерСчета$, "ЧГ=0")' в переменную "$$БонусныйСчет$$"
	И я открываю основную форму списка справочника "ВидыБонусныхСчетов"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "$$БонусныйСчет$$"
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И я меняю значение переключателя с именем 'Именной' на "Именной"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	И я открываю основную форму списка справочника "БонусныеСчета"
	И я нажимаю на кнопку с именем 'Создать'
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'ВидБонусногоСчета'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$БонусныйСчет$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю кнопку выбора у поля с именем 'Владелец'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	
	// Начисление на бонусный счет
	И В командном интерфейсе я выбираю "Продажи" "Операции по бонусным счетам"
	И я нажимаю на кнопку с именем 'Создать'
	И из выпадающего списка с именем 'ВидОперации' я выбираю точное значение "Начисление"
	И в поле с именем 'Сумма' я ввожу текст "10 000,00"
	И я нажимаю кнопку выбора у поля с именем 'ВладелецБонусногоСчета'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'	
	И я нажимаю кнопку выбора у поля с именем 'БонусныйСчет'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$БонусныйСчет$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'

	// Создание шаблона рассрочки
	Дано я запоминаю случайное число в переменную "Шаблон"	
	Дано я запоминаю значение выражения '"Шаблон" + Формат($Шаблон$, "ЧГ=0")' в переменную "$$ШаблонРассрочки$$"
	И В командном интерфейсе я выбираю "Продажи" "Шаблоны рассрочек"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "$$ШаблонРассрочки$$"
	И из выпадающего списка с именем 'СхемаПлатежа' я выбираю точное значение "Рассрочка 50 / 50"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	// Создание номенклатур
	И я закрываю все окна клиентского приложения
	И Я создаю членство
	И Я создаю ПакетУслуг
	И СО_Я создаю пробный пакет услуг
	И СО_Я создаю пробное членство
	И СО_Я создаю секцию
	И СО_Я создаю секционный пакет
	И СО_Я создаю рекуррентное членство
	И СО_Я создаю дорогую услугу
	И СО_Я создаю модификатор
Сценарий: 02. Продажи/оплаты
	// Вход под пользователем ИБ "МенеджерОП_Тест"
//	И я закрываю сеанс текущего клиента тестирования
	И я подключаю TestClient "Этот клиент" логин "МенеджерОП_Тест" пароль ""

	* Проверка оплат с лицевого счета

		// Услуга персональная
		И я запоминаю строку "250" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$УслугаПерсональная$$"

		// Услуга групповая
		И я запоминаю строку "250" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$УслугаГрупповая$$"

		// Пакет услуг
		И я запоминаю строку "2000" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$ПакетУслуг$$"

		// Пробный пакет усулуг
		И я запоминаю строку "500" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$ПробныйПакет$$"

		// Проверка на приобретение пробного пакета 2-й раз
		И Я открываю основную форму документа "Реализация"
		И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
		И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
		И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
		И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$ПробныйПакет$$"
		И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$ПробныйПакет$$"
		И в таблице 'Запасы' я завершаю редактирование строки
		И я жду, что в сообщениях пользователю будет строка "Данный пакет услуг ранее уже продавался клиенту. Пробный пакет услуг можно продать клиенту только один раз!" по шаблону в течение 5 секунд

		// Членство
		И я запоминаю строку "555" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$Членство$$"

		// Пробное Членство
		И я запоминаю строку "555" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$ПробноеЧленство$$"

		// Проверка на приобретение пробного членства 2-й раз
		И Я открываю основную форму документа "Реализация"
		И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
		И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
		И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
		И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$ПробноеЧленство$$"
		И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$ПробноеЧленство$$"
		И в таблице 'Запасы' я завершаю редактирование строки
		И я жду, что в сообщениях пользователю будет строка "Данный пакет услуг ранее уже продавался клиенту. Пробный пакет услуг можно продать клиенту только один раз!" по шаблону в течение 5 секунд

		// Модификатор
		И я запоминаю строку "200" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$Модификатор$$"

		// Секционный пакет
		И я запоминаю строку "2000" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$СекционныйПакет$$"

		// Рекуррентное членство
		И я запоминаю строку "555" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$РекуррентноеЧленство$$"
				
	
	* Проверка оплаты с бонусного счета
		И я закрываю все окна клиентского приложения
		И я запоминаю строку "2000" в переменную "Цена"
		И Я открываю основную форму документа "Реализация"
		И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
		И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
		И я активизирую дополнение формы с именем 'ДополнениеСтрокаПоиска'
		И в дополнение формы с именем 'ДополнениеСтрокаПоиска' я ввожу текст "$$СекционныйПакет$$"
		И я жду, что в таблице "_ПодборНоменклатур" количество строк будет "больше" 0 в течение 5 секунд
		И в таблице '_ПодборНоменклатур' я выбираю текущую строку
		И я меняю значение переключателя с именем 'ФильтрГруппПоКлиенту' на "Все"
		И в таблице 'СписокГруппыКлиентов' я выбираю текущую строку
		И я нажимаю на кнопку с именем 'ФормаВыбрать'
		И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
		И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_2x0'
		И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_2x0'
		И я нажимаю на кнопку с именем 'Оплатить'
		И я проверяю закрытие смены

	* Проверка смешанных оплат (наличные и ЛС)
		// Услуга персональная
		И я запоминаю строку "150" в переменную "Наличные"
		И я запоминаю строку "100" в переменную "ЛС"
		И СО_Я проверяю xml реализации услуги "$$УслугаПерсональная$$" (оплата нал и лс)

		// Услуга групповая
		И я запоминаю строку "150" в переменную "Наличные"
		И я запоминаю строку "100" в переменную "ЛС"
		И СО_Я проверяю xml реализации услуги "$$УслугаГрупповая$$" (оплата нал и лс)

		// Пакет услуг
		И я запоминаю строку "1900" в переменную "Наличные"
		И я запоминаю строку "100" в переменную "ЛС"
		И СО_Я проверяю xml реализации услуги "$$ПакетУслуг$$" (оплата нал и лс)

		// Членство
		И я запоминаю строку "455" в переменную "Наличные"
		И я запоминаю строку "100" в переменную "ЛС"
		И СО_Я проверяю xml реализации услуги "$$Членство$$" (оплата нал и лс)

		// Модификатор
		И я запоминаю строку "100" в переменную "Наличные"
		И я запоминаю строку "100" в переменную "ЛС"
		И СО_Я проверяю xml реализации услуги "$$Модификатор$$" (оплата нал и лс)

		// Секционный пакет
		И я запоминаю строку "1900" в переменную "Наличные"
		И я запоминаю строку "100" в переменную "ЛС"
		И СО_Я проверяю xml реализации услуги "$$СекционныйПакет$$" (оплата нал и лс)

		// Рекуррентное членство
		И я запоминаю строку "455" в переменную "Наличные"
		И я запоминаю строку "100" в переменную "ЛС"
		И СО_Я проверяю xml реализации услуги "$$РекуррентноеЧленство$$" (оплата нал и лс)

		// Проверка "Если остаток лицевого счета меньше суммы оплаты документа задолженности" - тикет 589139
		И Я открываю основную форму документа "Реализация"
		И я активизирую окно "Продажа (создание)"
		И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
		И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"
		И я активизирую дополнение формы с именем 'ДополнениеСтрокаПоиска'
		И в дополнение формы с именем 'ДополнениеСтрокаПоиска' я ввожу текст "$$УслугаДорогая$$"	
		И я жду, что в таблице "_ПодборНоменклатур" количество строк будет "больше" 0 в течение 5 секунд
		И в таблице '_ПодборНоменклатур' я выбираю текущую строку
		И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
		И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_1x0'
		И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_1x0'
		И элемент формы с именем 'Внесено' стал равен "7 435,00"
		И элемент формы с именем 'ПолеВидыОплатВводСуммыСтрока_1x0' стал равен "7 435"
		И у элемента формы с именем 'СуммаОплаты' текст редактирования стал равен "15 000,00"	
		И я нажимаю на кнопку с именем 'Оплатить'
		Тогда открылось окно "1С:Предприятие"
		И я нажимаю на кнопку с именем 'Button0'
		И Я открываю навигационную ссылку "$$СсылкаКлиента$$"
		И элемент формы с именем 'ДекорацияФормы_Представление_Остатка_0' стал равен "0,00 ₽"
		// пополнение лицевого счета
		И я нажимаю на кнопку с именем 'КнопкаДобавитьЛицевыеБонусныеСчета'
		И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
		И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "5 000,00"
		И я нажимаю на кнопку с именем 'Оплатить'
				

				
	* Проверка смешанных оплат (наличные и бонусный счет)
		// Услуга персональная
		И я запоминаю строку "250" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$УслугаПерсональная$$" (оплата нал и бонусы)

		// Услуга групповая
		И я запоминаю строку "250" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$УслугаГрупповая$$" (оплата нал и бонусы)

		// Пакет услуг
		И я запоминаю строку "2000" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$ПакетУслуг$$" (оплата нал и бонусы)

		// Членство
		И я запоминаю строку "555" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$Членство$$" (оплата нал и бонусы)

		// Модификатор
		И я запоминаю строку "200" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$Модификатор$$" (оплата нал и бонусы)

		// Секционный пакет
		И я запоминаю строку "2000" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$СекционныйПакет$$" (оплата нал и бонусы)

		// Рекуррентное членство
		И я запоминаю строку "555" в переменную "Цена"
		И СО_Я проверяю xml реализации услуги "$$РекуррентноеЧленство$$" (оплата нал и бонусы)

	* Проверка оплат с рассрочкой
		И СО_Я проверяю оплату с рассрочкой

Сценарий: 03. Возврат к исходному состоянию
	* Возврат к прошлому клиенту тестирования
		И я закрываю сеанс текущего клиента тестирования
		И я подключаю TestClient "Этот клиент" логин "Админ" пароль ""
		
				
				