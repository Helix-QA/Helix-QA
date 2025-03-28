﻿#language: ru

@tree

Функционал: Проверка возвратов (OperationType) АТОЛ

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Сценарий: 01. Первоначальная настройка
	
	И я удаляю все переменные
	И Я создаю Клиента
	И Я создаю Мастера
	И Я создаю Услугу_Салон

	И я удаляю объекты "Справочники.СтавкиНДС" без контроля ссылок
	И я создаю все виды ставок НДС

	// Настройка салона
	И я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	Если элемент "ПолеФормыПредметНалогообложения_0" доступен не только для просмотра Тогда
		И в поле с именем 'ПолеФормыПериод_0' я ввожу текст "01.12.2024"	
		И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_0' я выбираю точное значение "Авансы"
		И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Общая"
		И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "Без НДС "

		И я нажимаю на кнопку с именем 'ДобавитьГруппуПримененияСНО'				
		И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_1' я выбираю точное значение "Товары"
		И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Общая"
		И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "Без НДС "

		И я нажимаю на кнопку с именем 'ДобавитьГруппуПримененияСНО'
		И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_2' я выбираю точное значение "Услуги"
		И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Общая"
		И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "Без НДС "
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "Без НДС "
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "Без НДС "
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "Без НДС "
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Общая"
		
		
	// ------ ДОДЕЛАТЬ

Сценарий: 02. OperationType-2 (полный возврат)

*Продажа
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю '$$Услуга$$'
	И я нажимаю на кнопку с именем 'ВсеСотрудники'
	И в поле с именем 'СтрокаПоиска' я ввожу текст "$$Мастер$$"
	И я жду, что в таблице "ТаблицаСотрудников" количество строк будет "больше" 0 в течение 20 секунд
	И я нажимаю на кнопку с именем 'Выбрать'		
	И Я Оплитил документ
	И я закрываю все окна клиентского приложения

*Возврат
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'СписокПопомщникВозврата'
	И я нажимаю на кнопку с именем 'КомандаВыполнить'
	И я активизирую окно "Возврат"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'

	Тогда элемент формы с именем 'XML' стал равен по шаблону
		|'<?xml version=\"1.0\" encoding=\"UTF-8\"?>'|
		|'<CheckPackage>'|
		|'	<Parameters CashierName=\"*\" OperationType=\"2\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'|
		|'		<AgentData/>'|
		|'		<VendorData/>'|
		|'		<CustomerDetail/>'|
		|'		<OperationalAttribute/>'|
		|'		<IndustryAttribute/>'|
		|'	</Parameters>'|
		|'	<Positions>'|
		|'		<FiscalString Name=\"$$Услуга$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">'|
		|'			<IndustryAttribute/>'|
		|'			<AgentData/>'|
		|'			<VendorData/>'|
		|'		</FiscalString>'|
		|'	</Positions>'|
		|'	<Payments Cash=\"250\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'|
		|'</CheckPackage>'|

	И таблица 'ПозицииЧека' стала равной:
		| 'Наименование' | 'Количество' | 'Сумма скидок' | 'Цена'   | 'Цена со скидками' | 'Сумма'  | 'Номер секции' | 'Признак предмета расчета' | 'Ставка НДС' | 'Сумма НДС' | 'Штрихкод' | 'Признак способа расчета'   |
		| '$$Услуга$$'   | '1,00'       | ''             | '250,00' | '250,00'           | '250,00' | '1'            | 'Услуга'                   | ''           | ''          | ''         | 'Передача с полной оплатой' |
	
	И таблица 'ТаблицаОплат' стала равной:
		| 'Тип оплаты'      | 'Сумма'  |
		| 'Наличная оплата' | '250,00' |
	

Сценарий: 03. OperationType-2 (частичный возврат номенклатуры)

*Продажа
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю по строке '$$Услуга$$'
	И я нажимаю на кнопку с именем 'ВсеСотрудники'
	И в поле с именем 'СтрокаПоиска' я ввожу текст "$$Мастер$$"
	И я жду, что в таблице "ТаблицаСотрудников" количество строк будет "больше" 0 в течение 20 секунд
	И я нажимаю на кнопку с именем 'Выбрать'	
	И Я Оплитил документ
	И я закрываю все окна клиентского приложения

*Возврат
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'Возврат'
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыКоличествоУпаковок'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' в поле с именем 'ЗапасыКоличествоУпаковок' я ввожу текст "0,300"
	И в таблице 'Запасы' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'ФормаПровести'
	И я нажимаю на кнопку с именем 'ФормаОплатить'
	И я активизирую окно "Возврат"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
		
*Проверка чека
	Тогда элемент формы с именем 'XML' стал равен по шаблону
		|'<?xml version=\"1.0\" encoding=\"UTF-8\"?>'|
		|'<CheckPackage>'|
		|'	<Parameters CashierName=\"*\" OperationType=\"2\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'|
		|'		<AgentData/>'|
		|'		<VendorData/>'|
		|'		<CustomerDetail/>'|
		|'		<OperationalAttribute/>'|
		|'		<IndustryAttribute/>'|
		|'	</Parameters>'|
		|'	<Positions>'|
		|'		<FiscalString Name=\"$$Услуга$$\" Quantity=\"0.3\" PriceWithDiscount=\"250\" AmountWithDiscount=\"75\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">'|
		|'			<IndustryAttribute/>'|
		|'			<AgentData/>'|
		|'			<VendorData/>'|
		|'		</FiscalString>'|
		|'	</Positions>'|
		|'	<Payments Cash=\"75\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'|
		|'</CheckPackage>'|

	И таблица 'ПозицииЧека' стала равной:
		| 'Наименование' | 'Количество' | 'Сумма скидок' | 'Цена'   | 'Цена со скидками' | 'Сумма' | 'Номер секции' | 'Признак предмета расчета' | 'Ставка НДС' | 'Сумма НДС' | 'Штрихкод' | 'Признак способа расчета'   |
		| '$$Услуга$$'   | '0,30'       | ''             | '250,00' | '250,00'           | '75,00' | '1'            | 'Услуга'                   | ''           | ''          | ''         | 'Передача с полной оплатой' |
	
	И таблица 'ТаблицаОплат' стала равной:
		| 'Тип оплаты'      | 'Сумма' |
		| 'Наличная оплата' | '75,00' |
	
	И я закрываю все окна клиентского приложения

Сценарий: 04. OperationType-2 (последовательный возврат номенклатуры)

*Возврат
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'Возврат'
	И я нажимаю на кнопку с именем 'ФормаПровести'
	И я нажимаю на кнопку с именем 'ФормаОплатить'
	И я активизирую окно "Возврат"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'

*Проверка чека
	Тогда элемент формы с именем 'XML' стал равен по шаблону
		|'<?xml version=\"1.0\" encoding=\"UTF-8\"?>'|
		|'<CheckPackage>'|
		|'	<Parameters CashierName=\"*\" OperationType=\"2\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'|
		|'		<AgentData/>'|
		|'		<VendorData/>'|
		|'		<CustomerDetail/>'|
		|'		<OperationalAttribute/>'|
		|'		<IndustryAttribute/>'|
		|'	</Parameters>'|
		|'	<Positions>'|
		|'		<FiscalString Name=\"$$Услуга$$\" Quantity=\"0.7\" PriceWithDiscount=\"250\" AmountWithDiscount=\"175\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">'|
		|'			<IndustryAttribute/>'|
		|'			<AgentData/>'|
		|'			<VendorData/>'|
		|'		</FiscalString>'|
		|'	</Positions>'|
		|'	<Payments Cash=\"175\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'|
		|'</CheckPackage>'|

	И таблица 'ПозицииЧека' стала равной:
		| 'Наименование' | 'Количество' | 'Сумма скидок' | 'Цена'   | 'Цена со скидками' | 'Сумма'  | 'Номер секции' | 'Признак предмета расчета' | 'Ставка НДС' | 'Сумма НДС' | 'Штрихкод' | 'Признак способа расчета'   |
		| '$$Услуга$$'   | '0,70'       | ''             | '250,00' | '250,00'           | '175,00' | '1'            | 'Услуга'                   | ''           | ''          | ''         | 'Передача с полной оплатой' |

	И таблица 'ТаблицаОплат' стала равной:
		| 'Тип оплаты'      | 'Сумма'  |
		| 'Наличная оплата' | '175,00' |
	
Сценарий: 05. OperationType-2 (частичный возврат средств)

*Продажа
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю по строке '$$Услуга$$'
	И я нажимаю на кнопку с именем 'ВсеСотрудники'
	И в поле с именем 'СтрокаПоиска' я ввожу текст "$$Мастер$$"
	И я жду, что в таблице "ТаблицаСотрудников" количество строк будет "больше" 0 в течение 20 секунд
	И я нажимаю на кнопку с именем 'Выбрать'	
	И Я Оплитил документ
	И я закрываю все окна клиентского приложения

*Возврат
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'СписокПопомщникВозврата'
	И я нажимаю на кнопку с именем 'КомандаВыполнить'
	И я активизирую окно "Возврат"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "35,00"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И я нажимаю на кнопку с именем 'Button0'

*Проверка чека	
	Тогда элемент формы с именем 'XML' стал равен по шаблону
		|'<?xml version=\"1.0\" encoding=\"UTF-8\"?>'|
		|'<CheckPackage>'|
		|'	<Parameters CashierName=\"*\" OperationType=\"2\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'|
		|'		<AgentData/>'|
		|'		<VendorData/>'|
		|'		<CustomerDetail/>'|
		|'		<OperationalAttribute/>'|
		|'		<IndustryAttribute/>'|
		|'	</Parameters>'|
		|'	<Positions>'|
		|'		<FiscalString Name=\"$$Услуга$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"5\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">'|
		|'			<IndustryAttribute/>'|
		|'			<AgentData/>'|
		|'			<VendorData/>'|
		|'		</FiscalString>'|
		|'	</Positions>'|
		|'	<Payments Cash=\"35\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"215\" Barter=\"0\"/>'|
		|'</CheckPackage>'|

	И таблица 'ПозицииЧека' стала равной:
		| 'Наименование' | 'Количество' | 'Сумма скидок' | 'Цена'   | 'Цена со скидками' | 'Сумма'  | 'Номер секции' | 'Признак предмета расчета' | 'Ставка НДС' | 'Сумма НДС' | 'Штрихкод' | 'Признак способа расчета'      |
		| '$$Услуга$$'   | '1,00'       | ''             | '250,00' | '250,00'           | '250,00' | '1'            | 'Услуга'                   | ''           | ''          | ''         | 'Передача с частичной оплатой' |
	
	И таблица 'ТаблицаОплат' стала равной:
		| 'Тип оплаты'          | 'Сумма'  |
		| 'Наличная оплата'     | '35,00'  |
		| 'Постоплата (кредит)' | '215,00' |
	
Сценарий: 06. OperationType-2 (Отмена ошибочной оплаты)

*Продажа
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю по строке '$$Услуга$$'
	И я нажимаю на кнопку с именем 'ВсеСотрудники'
	И в поле с именем 'СтрокаПоиска' я ввожу текст "$$Мастер$$"
	И я жду, что в таблице "ТаблицаСотрудников" количество строк будет "больше" 0 в течение 20 секунд
	И я нажимаю на кнопку с именем 'Выбрать'	
	И Я Оплитил документ
	И я закрываю все окна клиентского приложения

*Возврат
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'СписокПомощникОтменыОплаты'
	И я нажимаю на кнопку с именем 'КомандаВыполнить'
	И я нажимаю на кнопку с именем 'Button0'

*Проверка чека
	Тогда элемент формы с именем 'XML' стал равен по шаблону
		|'<?xml version=\"1.0\" encoding=\"UTF-8\"?>'|
		|'<CheckPackage>'|
		|'	<Parameters CashierName=\"*\" OperationType=\"2\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'|
		|'		<AgentData/>'|
		|'		<VendorData/>'|
		|'		<CustomerDetail/>'|
		|'		<OperationalAttribute/>'|
		|'		<IndustryAttribute/>'|
		|'	</Parameters>'|
		|'	<Positions>'|
		|'		<FiscalString Name=\"$$Услуга$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">'|
		|'			<IndustryAttribute/>'|
		|'			<AgentData/>'|
		|'			<VendorData/>'|
		|'		</FiscalString>'|
		|'	</Positions>'|
		|'	<Payments Cash=\"250\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'|
		|'</CheckPackage>'|
	
	И таблица 'ПозицииЧека' стала равной:
		| 'Наименование' | 'Количество' | 'Сумма скидок' | 'Цена'   | 'Цена со скидками' | 'Сумма'  | 'Номер секции' | 'Признак предмета расчета' | 'Ставка НДС' | 'Сумма НДС' | 'Штрихкод' | 'Признак способа расчета'   |
		| '$$Услуга$$'   | '1,00'       | ''             | '250,00' | '250,00'           | '250,00' | '1'            | 'Услуга'                   | ''           | ''          | ''         | 'Передача с полной оплатой' |
	

	И таблица 'ТаблицаОплат' стала равной:
		| 'Тип оплаты'      | 'Сумма'  |
		| 'Наличная оплата' | '250,00' |
	
			