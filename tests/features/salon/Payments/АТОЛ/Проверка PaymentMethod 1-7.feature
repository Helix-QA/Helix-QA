﻿#language: ru

@tree

Функционал: Проверка PaymentMethod 1-7 (Признаки способа расчета)

		Признаки способа расчета
| 'Код' | 'Описание'                             |
| '1'   | 'Предоплата полная (В Салоне нет)'     |
| '2'   | 'Предоплата частичная  (В Салоне нет)' |
| '3'   | 'Аванс'                                |
| '4'   | 'Полный расчет'                        |
| '5'   | 'Частичный расчет и кредит'            |
| '6'   | 'Передача в кредит (В Салоне нет)'     |
| '7'   | 'Оплата кредита'                       |

https://disk.yandex.com/i/nyIsRcmTJNL8bw

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Сценарий: 01. Первоначальная настройка
	И я удаляю все переменные
	И Я устанавливаю в константу "НеКонтролироватьЗанятостьМастера" значение "Истина"
	И Я создаю Клиента
	И Я создаю Мастера
	И Я создаю Услугу_Салон
	И Я генерирую СлучайноеЧисло

	И Я открываю навигационную ссылку "e1cib/list/РегистрСведений.ПрименениеСистемНалогообложения"
	Если в таблице "Список" количество строк "больше или равно" 1 Тогда
		И в таблице 'Список' я выделяю все строки
		И в таблице 'Список' я удаляю строку
		И я нажимаю на кнопку с именем 'Button0'
	И я закрываю текущее окно

	И я удаляю объекты "Справочники.СтавкиНДС" без контроля ссылок
	И я создаю все виды ставок НДС

	Дано Я открываю основную форму списка справочника "Организации"
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
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

Сценарий: 02. Проверка PaymentMethod 3
	Дано Я открываю основную форму документа "Курс"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ТаблицаУслугиДобавить'
	И в таблице 'ТаблицаУслуги' из выпадающего списка с именем 'ТаблицаУслугиНоменклатура' я выбираю по строке "$$Услуга$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	Дано Я открываю основную форму списка документа "Курс"
	И я нажимаю на кнопку с именем 'СписокВнестиАванс'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я проверяю ЗакрытиеСмены

* Проверка XML (PaymentMethod 3)
	И элемент формы с именем 'XML' стал равен по шаблону
		|'<?xml version=\"1.0\" encoding=\"UTF-8\"?>'|
		|'<CheckPackage>'|
		|'	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'|
		|'		<AgentData/>'|
		|'		<VendorData/>'|
		|'		<CustomerDetail/>'|
		|'		<OperationalAttribute/>'|
		|'		<IndustryAttribute/>'|
		|'	</Parameters>'|
		|'	<Positions>'|
		|'		<FiscalString Name=\"Аванс от: $$Клиент$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"3\" CalculationSubject=\"10\" MeasureOfQuantity=\"255\">'|
		|'			<IndustryAttribute/>'|
		|'			<AgentData/>'|
		|'			<VendorData/>'|
		|'		</FiscalString>'|
		|'	</Positions>'|
		|'	<Payments Cash=\"250\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'|
		|'</CheckPackage>'|
	И таблица 'ПозицииЧека' стала равной:
		| "Наименование"         | "Количество" | "Цена"   | "Цена со скидками" | "Сумма НДС" | "Сумма скидок" | "Сумма"  | "Номер секции" | "Ставка НДС" | "Штрихкод" | "Признак предмета расчета" | "Признак способа расчета" |
		| "Аванс от: $$Клиент$$" | "1,00"       | "250,00" | "250,00"           | ""          | ""             | "250,00" | "1"            | ""           | ""         | "Платеж выплата"           | "Аванс"                   |
	И таблица 'ТаблицаОплат' стала равной:
		| "Тип оплаты"      | "Сумма"  |
		| "Наличная оплата" | "250,00" |

Сценарий: 03. Проверка PaymentMethod 4
	Дано Я открываю основную форму документа "Визит"
	И из выпадающего списка с именем 'ИмяКонтрагента' я выбираю по строке "$$Клиент$$"
	И из выпадающего списка с именем 'ПолеФормы_Номенклатура_ТЧ_Запасы_0' я выбираю по строке "$$Услуга$$"
	И из выпадающего списка с именем 'ПолеФормы_Сотрудник_ТЧ_Запасы_0' я выбираю по строке "$$Мастер$$"
	И я нажимаю на кнопку с именем 'Пришел'
	Если открылось окно "1С:Предприятие" Тогда
		И я нажимаю на кнопку с именем 'Button0'
	И Я Оплитил документ
	
* Проверка XML (PaymentMethod 4)
	И элемент формы с именем 'XML' стал равен по шаблону
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                         |
		| '<CheckPackage>'                                                                                                                                                                                                                                                     |
		| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                                     |
		| '		<AgentData/>'                                                                                                                                                                                                                                                     |
		| '		<VendorData/>'                                                                                                                                                                                                                                                    |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                                |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                                          |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                                             |
		| '	</Parameters>'                                                                                                                                                                                                                                                     |
		| '	<Positions>'                                                                                                                                                                                                                                                       |
		| '		<FiscalString Name=\"$$Услуга$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                                            |
		| '			<AgentData/>'                                                                                                                                                                                                                                                    |
		| '			<VendorData/>'                                                                                                                                                                                                                                                   |
		| '		</FiscalString>'                                                                                                                                                                                                                                                  |
		| '	</Positions>'                                                                                                                                                                                                                                                      |
		| '	<Payments Cash=\"250\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'                                                                                                                                                                  |
		| '</CheckPackage>'                                                                                                                                                                                                                                                    |
	И таблица 'ПозицииЧека' стала равной:
		| "Наименование" | "Количество" | "Цена"   | "Цена со скидками" | "Сумма НДС" | "Сумма скидок" | "Сумма"  | "Номер секции" | "Ставка НДС" | "Штрихкод" | "Признак предмета расчета" | "Признак способа расчета"   |
		| "$$Услуга$$"   | "1,00"       | "250,00" | "250,00"           | ""          | ""             | "250,00" | "1"            | ""           | ""         | "Услуга"                   | "Передача с полной оплатой" |
	И таблица 'ТаблицаОплат' стала равной:
		| "Тип оплаты"      | "Сумма"  |
		| "Наличная оплата" | "250,00" |

Сценарий: 04. Проверка PaymentMethod 5
	Дано Я открываю основную форму документа "Визит"
	И из выпадающего списка с именем 'ИмяКонтрагента' я выбираю по строке "$$Клиент$$"
	И из выпадающего списка с именем 'ПолеФормы_Номенклатура_ТЧ_Запасы_0' я выбираю по строке "$$Услуга$$"
	И из выпадающего списка с именем 'ПолеФормы_Сотрудник_ТЧ_Запасы_0' я выбираю по строке "$$Мастер$$"
	И я нажимаю на кнопку с именем 'Пришел'
	Если открылось окно "1С:Предприятие" Тогда
		И я нажимаю на кнопку с именем 'Button0'
	И я сохраняю навигационную ссылку текущего окна в переменную "$$PaymentMethod_7$$"
	И я нажимаю на кнопку с именем 'Кнопка_Оплаты_Визита'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "100"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И я нажимаю на кнопку с именем 'Button0'
	И Я проверяю ЗакрытиеСмены

* Проверка XML (PaymentMethod 5)
	И элемент формы с именем 'XML' стал равен по шаблону 
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                           |
		| '<CheckPackage>'                                                                                                                                                                                                                                       |
		| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                           |
		| '		<AgentData/>'                                                                                                                                                                                                                                       |
		| '		<VendorData/>'                                                                                                                                                                                                                                      |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                  |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                            |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                               |
		| '	</Parameters>'                                                                                                                                                                                                                                       |
		| '	<Positions>'                                                                                                                                                                                                                                         |
		| '		<FiscalString Name=\"$$Услуга$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"5\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                              |
		| '			<AgentData/>'                                                                                                                                                                                                                                      |
		| '			<VendorData/>'                                                                                                                                                                                                                                     |
		| '		</FiscalString>'                                                                                                                                                                                                                                    |
		| '	</Positions>'                                                                                                                                                                                                                                        |
		| '	<Payments Cash=\"100\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"150\" Barter=\"0\"/>'                                                                                                                                                  |
		| '</CheckPackage>'                                                                                                                                                                                                                                      |
	И таблица 'ПозицииЧека' стала равной:
		| "Наименование" | "Количество" | "Цена"   | "Цена со скидками" | "Сумма НДС" | "Сумма скидок" | "Сумма"  | "Номер секции" | "Ставка НДС" | "Штрихкод" | "Признак предмета расчета" | "Признак способа расчета"      |
		| "$$Услуга$$"   | "1,00"       | "250,00" | "250,00"           | ""          | ""             | "250,00" | "1"            | ""           | ""         | "Услуга"                   | "Передача с частичной оплатой" |
	
	И таблица 'ТаблицаОплат' стала равной:
		| "Тип оплаты"          | "Сумма"  |
		| "Наличная оплата"     | "100,00" |
		| "Постоплата (кредит)" | "150,00" |
	
Сценарий: 05. Проверка PaymentMethod 7
	И Я открываю навигационную ссылку "$$PaymentMethod_7$$"
	И Я Оплитил документ

* Проверка XML (PaymentMethod 7)
	И элемент формы с именем 'XML' стал равен по шаблону
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                            |
		| '<CheckPackage>'                                                                                                                                                                                                                                        |
		| '	<Parameters CashierName=\"* \" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                       |
		| '		<AgentData/>'                                                                                                                                                                                                                                        |
		| '		<VendorData/>'                                                                                                                                                                                                                                       |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                   |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                             |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                                |
		| '	</Parameters>'                                                                                                                                                                                                                                        |
		| '	<Positions>'                                                                                                                                                                                                                                          |
		| '		<FiscalString Name=\"$$Услуга$$\" Quantity=\"1\" PriceWithDiscount=\"150\" AmountWithDiscount=\"150\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"7\" CalculationSubject=\"10\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                               |
		| '			<AgentData/>'                                                                                                                                                                                                                                       |
		| '			<VendorData/>'                                                                                                                                                                                                                                      |
		| '		</FiscalString>'                                                                                                                                                                                                                                     |
		| '	</Positions>'                                                                                                                                                                                                                                         |
		| '	<Payments Cash=\"150\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'                                                                                                                                                     |
		| '</CheckPackage>'                                                                                                                                                                                                                                       |
	И таблица 'ПозицииЧека' стала равной:
		| 'Наименование' | 'Количество' | 'Цена'   | 'Цена со скидками' | 'Сумма скидок' | 'Сумма'  | 'Номер секции' | 'Ставка НДС' | 'Сумма НДС' | 'Штрихкод' | 'Признак способа расчета' | 'Признак предмета расчета' |
		| '$$Услуга$$'   | '1,00'       | '150,00' | '150,00'           | ''             | '150,00' | '1'            | ''           | ''          | ''         | 'Оплата кредита'          | 'Платеж выплата'           |
	И таблица 'ТаблицаОплат' стала равной:
		| 'Тип оплаты'      | 'Сумма'  |
		| 'Наличная оплата' | '150,00' |
