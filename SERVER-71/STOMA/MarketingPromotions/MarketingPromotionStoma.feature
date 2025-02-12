﻿#language: ru

@tree

Функционал: Проверка фукнционала маркетинговых акций.

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Создание первоначальных данных для тестирования МА.
	И Я создаю двух клиентов для тестирования МА.
	И Я создаю номенклатуру с типом - Услуга для МА.
	И Я создаю врача для МА.
	И Я создаю МА с условием применения - Всегда,способы - все.Ограничено списком пациентов.

Сценарий: Проверка созданных данных.
	И Я проверяю первоначальные данные для МА.

Сценарий: Проверка МА с условием применения - Всегда,способы - все.Ограничено списком пациентов.
	И Я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (1 из 1)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (3 из 3)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '7 000,00' | '10 000,00' | '30,00'    | '3 000,00'      | '7 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием применения - Всегда,способы - все.Ограничено сегментом пациентов.
	И Я меняю условие ограничения на сегмент пациентов.
	И Я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (1 из 1)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (3 из 3)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '7 000,00' | '10 000,00' | '30,00'    | '3 000,00'      | '7 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием применения - Всегда, способы - все. Ограничено видом карт.
	И Я запоминаю случайное число в переменную "Карта"
    И я запоминаю значение выражения '"Карта" + Формат($Карта$, "ЧГ=0")' в переменную "$$Карта$$"
	Дано я открываю основную форму справочника 'ВидыКарт'
	И в поле с именем 'Наименование' я ввожу текст "$$Карта$$"
	И я нажимаю на кнопку с именем 'КнопкаИменная'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	Дано Я открываю навигационную ссылку '$$СсылкаПациент1$$'
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКарту'
	И из выпадающего списка с именем 'КартаВидКарты' я выбираю точное значение "$$Карта$$"
	И я нажимаю на кнопку с именем 'КартаДобавить'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я меняю условие ограничения по видам дисконтных карт.
	И Я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (1 из 1)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (3 из 3)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '7 000,00' | '10 000,00' | '30,00'    | '3 000,00'      | '7 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием применения - Всегда. Ограничено пациент рекламный источник.
	Дано Я открываю навигационную ссылку '$$СсылкаПациент1$$'
	И я нажимаю кнопку выбора у поля с именем 'ИсточникИнформации'
	И в таблице 'Список' я перехожу к строке:
		| 'Наименование'                |
		| 'Другой пациент стоматологии' |
	И в таблице 'Список' я выбираю текущую строку	
	И в поле с именем 'КлиентИсточникИнформации' я ввожу значение выражения "$$Пациент2$$"
	И из выпадающего списка с именем 'КлиентИсточникИнформации' я выбираю "$$Пациент2$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я меняю условие ограничения на пациент рекламный источник.
	И Я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (2 из 2)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '8 000,00' | '10 000,00' | '20,00'    | '2 000,00'      | '8 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка ограничения по клиенту в МА.
	Дано я открываю основную форму списка справочника 'СкидкиНаценки'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование"    |
		| "$$ВсегдаСумма$$" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем '_ГруппаСтруктурныеЕдиницы'
	И в таблице 'ТаблицаСтруктурныеЕдиницыСкидки' я активизирую поле с именем 'ТаблицаСтруктурныеЕдиницыСкидкиКоличествоПримененийПоКлиенту'
	И в таблице 'ТаблицаСтруктурныеЕдиницыСкидки' я выбираю текущую строку
	И в таблице 'ТаблицаСтруктурныеЕдиницыСкидки' из выпадающего списка с именем 'ТаблицаСтруктурныеЕдиницыСкидкиКоличествоПримененийПоКлиенту' я выбираю точное значение "По пациенту"
	И в таблице 'ТаблицаСтруктурныеЕдиницыСкидки' я активизирую поле с именем 'ТаблицаСтруктурныеЕдиницыСкидкиКоличествоПрименений'
	И в таблице 'ТаблицаСтруктурныеЕдиницыСкидки' в поле с именем 'ТаблицаСтруктурныеЕдиницыСкидкиКоличествоПрименений' я ввожу текст "1"
	И в таблице 'ТаблицаСтруктурныеЕдиницыСкидки' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	//Создание первой продажи.
	И я создаю продажу МА Пациенту1
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (2 из 2)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка и создание условия видом цен.
 	И Я создаю МА с условием применения - Всегда,способы - Видом цен.	
	И я создаю продажу МА Пациенту1
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'     | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '7 000,00' | '7 000,00' | ''         | ''              | '7 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием - День рождения.
	И  Я создаю МА с условием применения - День рождения.
	И я создаю продажу МА Пациенту1
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'     |
		| '$$Услуга$$'   | '1,000'      | '9 000,00' | '10 000,00' | '10,00'    | '1 000,00'      | '9 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'
	И Я создаю продажу МА Пациенту2.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '9 000,00' | '10 000,00' | '10,00'    | '1 000,00'      | '9 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием - Количество в документе Приём.
	И Я создаю МА с условием применения - Количество в документе приём.
	И Я создаю документ Приём для МА.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Маркетинговые акции (2 из 2)"
	И таблица 'ТаблицаЛечение' стала равной по шаблону:
		| 'Зуб'         | 'Услуга'     | 'Кол-во' | 'Цена'      | 'Скидка %' | 'Σ авто'   | 'Сумма'    |
		| 'вся полость' | '$$Услуга$$' | '1,00'   | '10 000,00' | '20,00'    | '2 000,00' | '8 000,00' |
	И Я оплатил документ Приём с МА.
		
Сценарий: Проверка МА с условием - Количество продаж по пациенту.
	И Я создаю МА с условием применения - Количество продаж по пациенту.
	И я создаю продажу МА Пациенту1.
	И Я оплатил документ реализации с МА.
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '8 000,00' | '10 000,00' | '20,00'    | '2 000,00'      | '8 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием - Количество продаж по карте.
	И Я создаю МА с условием применения - Количество продаж по карте.
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '8 000,00' | '10 000,00' | '20,00'    | '2 000,00'      | '8 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием - Когда предыдущий прием содержит номенклатуру.
	И Я создаю МА с условием применения - Когда предыдущий прием содержит номенклатуру.
	И Я создаю документ Приём для МА.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Маркетинговые акции (1 из 1)"
	И таблица 'ТаблицаЛечение' стала равной по шаблону:
		| 'Зуб'         | 'Услуга'     | 'Кол-во' | 'Цена'      | 'Скидка %' | 'Σ авто'   | 'Сумма'    |
		| 'вся полость' | '$$Услуга$$' | '1,00'   | '10 000,00' | '10,00'    | '1 000,00' | '9 000,00' |
	И Я закрываю окно "Прием начат (Центр Стоматологической Имплантологии) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием - Каждая вторая покупка по пациенту/карте.
	И Я создаю МА с условием применения - Каждая третья покупка по пациенту/карте.	
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '8 000,00' | '10 000,00' | '20,00'    | '2 000,00'      | '8 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием применения - Остаток на лицевом счете.
	И Я создаю МА с условием применения - Остаток на лицевом счете.
	Дано Я открываю навигационную ссылку "$$СсылкаПациент1$$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЛицевыеБонусныеСчета'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "2 000,00"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'Внести'
	Дано Я открываю навигационную ссылку "$$СсылкаПациент1$$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьРодственника'
	И я устанавливаю флаг с именем 'СуществующийРодственник'
	И в поле с именем 'Родственник' я ввожу значение выражения "$$Пациент2$$"
	И из выпадающего списка с именем 'Родственник' я выбираю "$$Пациент2$$"
	И я нажимаю кнопку выбора у поля с именем 'СтепеньРодства'
	И я выбираю из списка 'Сын'
	И я устанавливаю флаг с именем 'ОбщийЛицевойСчет'
	И я нажимаю на кнопку с именем 'СохранитьДокументПостоянная'
	Дано Я открываю навигационную ссылку "$$СсылкаПациент2$$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЛицевыеБонусныеСчета'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "6 000,00"
	И я перехожу к следующему реквизиту			
	И я нажимаю на кнопку с именем 'Внести'
	И Я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '8 500,00' | '10 000,00' | '15,00'    | '1 500,00'      | '8 500,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'
	И Я создаю продажу МА Пациенту2.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '7 500,00' | '10 000,00' | '25,00'    | '2 500,00'      | '7 500,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием применения - Промокод.
	И Я создаю МА с условием применения - Промокод.
	Дано Я открываю основную форму списка регистра сведений "СтатусыКонтрагентов"
	И я нажимаю на кнопку с именем 'ФормаКомандаСоздать'
	И из выпадающего списка с именем 'Статус' я выбираю точное значение "Постоянный"
	И я нажимаю кнопку выбора у поля с именем 'Контрагент'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование"  |
		| "$$Пациент1$$ " |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаКнопкаЗаписатьИЗакрыть'
	Дано я открываю основную форму списка справочника "Промокоды"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ПромокодРеф$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд	
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'КнопкаПромокоды'
	И я активизирую дополнение формы с именем 'СтрокаПоискаСписка'
	И в дополнение формы с именем 'СтрокаПоискаСписка' я ввожу текст "$$Пациент1$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я активизирую поле с именем 'Промокод'
	И я запоминаю значение поля с именем 'Промокод' таблицы 'Список' как '$$ПромокодПациента$$'
	И я закрываю все окна клиентского приложения
	И Я создаю продажу МА Пациенту2.
	И я нажимаю на кнопку с именем '_Запасы'
	И я нажимаю на кнопку с именем 'Промокод'
	И в поле с именем 'InputFld' я ввожу значение выражения "$$ПромокодПациента$$"
	И я нажимаю на кнопку с именем 'OK'
	И я нажимаю на кнопку с именем '_Услуги'
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '9 000,00' | '10 000,00' | '10,00'    | '1 000,00'      | '9 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием применения - Сумма в приёме не более/не менее.
	И Я создаю МА с условием применения - Сумма.
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '8 000,00' | '10 000,00' | '20,00'    | '2 000,00'      | '8 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием применения - Сумма продаж по пациенту/карте не более/не менее.
	Дано Я открываю основную форму списка справочника 'СкидкиНаценки'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "$$СуммаНМ$$"  |
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'ОбъектСкидки' я выбираю точное значение "Продаж"
	И из выпадающего списка с именем 'ОбъектНакопления' я выбираю точное значение "пациенту"
	И в поле с именем 'ПериодНакопления' я ввожу текст "1"
	И из выпадающего списка с именем 'ВидСравненияУсловия' я выбираю точное значение "Не менее"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "$$СуммаНБ$$"  |
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'ОбъектСкидки' я выбираю точное значение "Продаж"
	И из выпадающего списка с именем 'ОбъектНакопления' я выбираю точное значение "пациенту"
	И в поле с именем 'ПериодНакопления' я ввожу текст "1"
	И из выпадающего списка с именем 'ВидСравненияУсловия' я выбираю точное значение "Не менее"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '8 000,00' | '10 000,00' | '20,00'    | '2 000,00'      | '8 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "$$СуммаНМ$$"  |
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'ОбъектСкидки' я выбираю точное значение "Продаж"
	И из выпадающего списка с именем 'ОбъектНакопления' я выбираю точное значение "карте"
	И в поле с именем 'ПериодНакопления' я ввожу текст "1"
	И из выпадающего списка с именем 'ВидСравненияУсловия' я выбираю точное значение "Не менее"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "$$СуммаНБ$$"  |
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'ОбъектСкидки' я выбираю точное значение "Продаж"
	И из выпадающего списка с именем 'ОбъектНакопления' я выбираю точное значение "карте"
	И в поле с именем 'ПериодНакопления' я ввожу текст "1"
	И из выпадающего списка с именем 'ВидСравненияУсловия' я выбираю точное значение "Не более"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '9 000,00' | '10 000,00' | '10,00'    | '1 000,00'      | '9 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка МА с условием применения - Бонус рефералу (промокод).
	И Я создаю МА с условием применения - Бонус рефералу (промокод).
	И я создаю продажу МА Пациенту2.
	И я нажимаю на кнопку с именем '_Запасы'
	И я нажимаю на кнопку с именем 'Промокод'
	И в поле с именем 'InputFld' я ввожу значение выражения "$$ПромокодПациента$$"
	И я нажимаю на кнопку с именем 'OK'
	И я нажимаю на кнопку с именем '_Услуги'
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'     | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'     |
		| '$$Услуга$$'   | '1,000'      | '10 000,00' | '10 000,00' | ''         | ''              | '10 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'

Сценарий: Проверка групп МА - Максимум, Минимум, Сложение, Умножение.
	И я закрываю все окна клиентского приложения
	И я удаляю объекты "Справочники.СкидкиНаценки" без контроля ссылок
	И Я запоминаю случайное число в переменную "ГруппаМА"
    И я запоминаю значение выражения '"ГруппаМА" + Формат($ГруппаМА$, "ЧГ=0")' в переменную "$$ГруппаМА$$"
//Проверка минимума.	
	Дано Я открываю основную форму списка справочника 'СкидкиНаценки'
	И в таблице  'Список' я перехожу на один уровень вниз
	И я нажимаю на кнопку с именем 'СоздатьГруппу'
	И в поле с именем 'Наименование' я ввожу значение выражения "$$ГруппаМА$$"
	И я меняю значение переключателя с именем 'ВариантСовместногоПримененияСкидокНаценок' на "Минимум"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	//Первая МА для группы.
	И я нажимаю на кнопку с именем 'ФормаСоздать'		
	И в поле с именем 'Наименование' я ввожу значение выражения "$$ВсегдаСумма$$"
	И из выпадающего списка с именем 'УсловиеПредоставленияСкидки' я выбираю точное значение "Всегда"
	И из выпадающего списка с именем 'СпособПредоставленияСкидки' я выбираю точное значение "Суммой"
	И в поле с именем 'ЗначениеСкидкиНаценки' я ввожу текст "1 000,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	//Вторая МА для группы.
	И я нажимаю на кнопку с именем 'ФормаСоздать'		
	И в поле с именем 'Наименование' я ввожу значение выражения "$$ВсегдаПроцентом$$"
	И из выпадающего списка с именем 'УсловиеПредоставленияСкидки' я выбираю точное значение "Всегда"
	И из выпадающего списка с именем 'СпособПредоставленияСкидки' я выбираю точное значение "Суммой"
	И в поле с именем 'ЗначениеСкидкиНаценки' я ввожу текст "3 000,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '9 000,00' | '10 000,00' | '10,00'    | '1 000,00'      | '9 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'
//Проверка максимума.
	И в таблице 'Список' я перехожу к строке:
		| 'Наименование' |
		| '$$ГруппаМА$$' |
	И в таблице 'Список' я выбираю текущую строку
	И я меняю значение переключателя с именем 'ВариантСовместногоПримененияСкидокНаценок' на "Максимум"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (1 из 1)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '7 000,00' | '10 000,00' | '30,00'    | '3 000,00'      | '7 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'	
//Проверка сложения.
	И в таблице 'Список' я перехожу к строке:
		| 'Наименование' |
		| '$$ГруппаМА$$' |
	И в таблице 'Список' я выбираю текущую строку
	И я меняю значение переключателя с именем 'ВариантСовместногоПримененияСкидокНаценок' на "Сложение"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '6 000,00' | '10 000,00' | '40,00'    | '4 000,00'      | '6 000,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'	
//Проверка умножения.
	И в таблице 'Список' я перехожу к строке:
		| 'Наименование' |
		| '$$ГруппаМА$$' |
	И в таблице 'Список' я выбираю текущую строку
	И я меняю значение переключателя с именем 'ВариантСовместногоПримененияСкидокНаценок' на "Умножение"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И в таблице 'Список' я перехожу к строке:
		| 'Наименование'    |
		| '$$ВсегдаСумма$$' |
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'СпособПредоставленияСкидки' я выбираю точное значение "Процентом"
	И в поле с именем 'ЗначениеСкидкиНаценки' я ввожу текст "10,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И в таблице 'Список' я перехожу к строке:
		| 'Наименование'        |
		| '$$ВсегдаПроцентом$$' |
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'СпособПредоставленияСкидки' я выбираю точное значение "Процентом"
	И в поле с именем 'ЗначениеСкидкиНаценки' я ввожу текст "10,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я создаю продажу МА Пациенту1.
	И элемент формы с именем 'Дек_Подарки' стал равен "Подарки (0 из 0)"
	И элемент формы с именем 'Дек_СкидкиНаценки' стал равен "Скидки и наценки (2 из 2)"
	И таблица 'Услуги' стала равной:
		| 'Номенклатура' | 'Количество' | 'Всего'    | 'Цена'      | '% скидки' | 'Σ авт. скидки' | 'Сумма'    |
		| '$$Услуга$$'   | '1,000'      | '8 100,00' | '10 000,00' | '19,00'    | '1 900,00'      | '8 100,00' |
	И Я закрываю окно "Реализация (создание) *"
	И я нажимаю на кнопку с именем 'Button1'
	И я закрываю все окна клиентского приложения
	И я удаляю объекты "Справочники.СкидкиНаценки" без контроля ссылок




































