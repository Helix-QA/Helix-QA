﻿#language: ru
@tree

Функционал: Проверка PaymentMethod 1-7  АТОЛ

Фискальный регистратор: 'АТОЛ:ККТ с передачей данных в ОФД 10.Х (ФФД 1.2)'

	Признаки способа расчета
| 'Код' | 'Описание'                  |
| '1'   | 'Предоплата полная'         |
| '2'   | 'Предоплата частичная'      |
| '3'   | 'Аванс'                     |
| '4'   | 'Полный расчет'             |
| '5'   | 'Частичный расчет и кредит' |
| '6'   | 'Передача в кредит'         |
| '7'   | 'Оплата кредита'            |

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Первоначальная настройка
	И я удаляю все переменные
	И Я создаю клиента
	И Я создаю Услуга_Персональная

Сценарий: Проверка PaymentMethod 1 (Предоплата полная) 
	И Остановка если была ошибка в прошлом сценарии

* Включение "Авансовая схема услуг"
	И В командном интерфейсе я выбираю "Справочники" "Организации"
	И в таблице 'Список' я выбираю текущую строку
	Если флаг с именем "АвансоваяСхемаПробитияУслуг" равен "Ложь" Тогда
		И я устанавливаю флаг с именем 'АвансоваяСхемаПробитияУслуг'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Полная оплата
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "Контрагент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная$$"
	И Я оплачиваю реализацию

* Проверка чека
	И я активизирую окно "Исходные данные чека"
	И элемент формы с именем "XML" стал равен по шаблону
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
		|'		<FiscalString Name=\" $$УслугаПерсональная$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"1\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">'|
		|'			<IndustryAttribute/>'|
		|'			<AgentData/>'|
		|'			<VendorData/>'|
		|'		</FiscalString>'|
		|'	</Positions>'|
		|'	<Payments Cash=\"250\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'|
		|'</CheckPackage>'|
	И таблица "ПозицииЧека" стала равной:
		| 'Наименование'            | 'Количество' | 'Цена'   | 'Цена со скидками' | 'Сумма НДС' | 'Сумма скидок' | 'Сумма'  | 'Номер секции' | 'Ставка НДС' | 'Штрихкод' | 'Признак предмета расчета' | 'Признак способа расчета' |
		| ' $$УслугаПерсональная$$' | '1,00'       | '250,00' | '250,00'           | ''          | ''             | '250,00' | '1'            | ''           | ''         | 'Услуга'                   | 'Предоплата полная'       |
	И таблица "ТаблицаОплат" стала равной:
		| 'Тип оплаты'      | 'Сумма'  |
		| 'Наличная оплата' | '250,00' |
			
Сценарий: Проверка PaymentMethod 2 (Предоплата частичная)					
* Частичная оплата
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "Контрагент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная$$"
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст '50'
<<<<<<< HEAD
=======
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
>>>>>>> e54d268d0dd2607d0e11b145e48b016b7d96d298
	И я нажимаю на кнопку с именем 'Оплатить'
	И я нажимаю на кнопку с именем 'Button0'	
	И я проверяю закрытие смены

* Проверка чека
	И я активизирую окно "Исходные данные чека"
	И элемент формы с именем "XML" стал равен по шаблону 
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                 |
		| '<CheckPackage>'                                                                                                                                                                                                                                             |
		| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                         |
		| '		<AgentData/>'                                                                                                                                                                                                                                             |
		| '		<VendorData/>'                                                                                                                                                                                                                                            |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                        |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                                  |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                                     |
		| '	</Parameters>'                                                                                                                                                                                                                                             |
		| '	<Positions>'                                                                                                                                                                                                                                               |
		| '		<FiscalString Name=\" $$УслугаПерсональная$$\" Quantity=\"1\" PriceWithDiscount=\"50\" AmountWithDiscount=\"50\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"2\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                                    |
		| '			<AgentData/>'                                                                                                                                                                                                                                            |
		| '			<VendorData/>'                                                                                                                                                                                                                                           |
		| '		</FiscalString>'                                                                                                                                                                                                                                          |
		| '	</Positions>'                                                                                                                                                                                                                                              |
		| '	<Payments Cash=\"50\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'                                                                                                                                                           |
		| '</CheckPackage>'                                                                                                                                                                                                                                            |
	И таблица "ПозицииЧека" стала равной:
		| 'Наименование'       | 'Количество' | 'Цена'  | 'Цена со скидками' | 'Сумма НДС' | 'Сумма скидок' | 'Сумма' | 'Номер секции' | 'Ставка НДС' | 'Штрихкод' | 'Признак предмета расчета' | 'Признак способа расчета' |
		| ' $$УслугаПерсональная$$' | '1,00'       | '50,00' | '50,00'            | ''          | ''             | '50,00' | '1'            | ''           | ''         | 'Услуга'                   | 'Предоплата частичная'    |
	И таблица "ТаблицаОплат" стала равной:
		| 'Тип оплаты'      | 'Сумма' |
		| 'Наличная оплата' | '50,00' |

Сценарий: Проверка PaymentMethod 3 (Аванс (Взнос на лицевой счет))
* Выключение "Авансовая схема услуг"
	И В командном интерфейсе я выбираю "Справочники" "Организации"
	И в таблице 'Список' я выбираю текущую строку
	Если флаг с именем "АвансоваяСхемаПробитияУслуг" равен "Истина" Тогда
		И я снимаю флаг с именем 'АвансоваяСхемаПробитияУслуг'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	

* Взнос на ЛС
	И В командном интерфейсе я выбираю 'Главное' 'Рецепция'
	И в поле с именем 'ТекущийКлиент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "ТекущийКлиент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на гиперссылку с именем "ВнестиНаЛицевойСчет"
	И я нажимаю кнопку выбора у поля с именем "ВидЛицевогоСчета"
	И в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000001' | 'Основной'     |
	И в таблице "Список" я выбираю текущую строку
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст '25000'
	И я нажимаю на кнопку с именем 'Оплатить'
	И я проверяю закрытие смены

* Проверка чека
//Взнос на лицевой счет PaymentMethod=3 (Передача без оплаты (БезОп))
	И я активизирую окно "Исходные данные чека"
	И элемент формы с именем "XML" стал равен по шаблону 
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
		|'		<FiscalString Name=\"Взнос на лицевой счет\" Quantity=\"1\" PriceWithDiscount=\"25000\" AmountWithDiscount=\"25000\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"3\" CalculationSubject=\"10\" MeasureOfQuantity=\"255\">'|
		|'			<IndustryAttribute/>'|
		|'			<AgentData/>'|
		|'			<VendorData/>'|
		|'		</FiscalString>'|
		|'	</Positions>'|
		|'	<Payments Cash=\"25000\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'|
		|'</CheckPackage>'|
	И таблица "ПозицииЧека" стала равной:
		| 'Наименование'          | 'Количество' | 'Цена'      | 'Цена со скидками' | 'Сумма НДС' | 'Сумма скидок' | 'Сумма'     | 'Номер секции' | 'Ставка НДС' | 'Штрихкод' | 'Признак предмета расчета' | 'Признак способа расчета' |
		| 'Взнос на лицевой счет' | '1,00'       | '25 000,00' | '25 000,00'        | ''          | ''             | '25 000,00' | '1'            | ''           | ''         | 'Платеж выплата'           | 'Аванс'                   |
	И таблица "ТаблицаОплат" стала равной:
		| 'Тип оплаты'      | 'Сумма'     |
		| 'Наличная оплата' | '25 000,00' |

Сценарий: Проверка PaymentMethod 4 (Передача с полной оплатой)
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "Контрагент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная$$"
	И Я оплачиваю реализацию

* Проверка чека
//Оплата наличными PaymentMethod=4 (Передача с полной оплатой)
	И я активизирую окно "Исходные данные чека"
	И элемент формы с именем "XML" стал равен по шаблону
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                                       |
		| '<CheckPackage>'                                                                                                                                                                                                                                                                   |
		| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                                               |
		| '		<AgentData/>'                                                                                                                                                                                                                                                                   |
		| '		<VendorData/>'                                                                                                                                                                                                                                                                  |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                                              |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                                                        |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                                                           |
		| '	</Parameters>'                                                                                                                                                                                                                                                                   |
		| '	<Positions>'                                                                                                                                                                                                                                                                     |
		| '		<FiscalString Name=\" $$УслугаПерсональная$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                                                          |
		| '			<AgentData/>'                                                                                                                                                                                                                                                                  |
		| '			<VendorData/>'                                                                                                                                                                                                                                                                 |
		| '		</FiscalString>'                                                                                                                                                                                                                                                                |
		| '	</Positions>'                                                                                                                                                                                                                                                                    |
		| '	<Payments Cash=\"250\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'                                                                                                                                                                         |
		| '</CheckPackage>'                                                                                                                                                                                                                                                                  |
	И таблица "ПозицииЧека" стала равной:
		| 'Наименование'            | 'Количество' | 'Цена'   | 'Цена со скидками' | 'Сумма НДС' | 'Сумма скидок' | 'Сумма'  | 'Номер секции' | 'Ставка НДС' | 'Штрихкод' | 'Признак предмета расчета' | 'Признак способа расчета'   |
		| ' $$УслугаПерсональная$$' | '1,00'       | '250,00' | '250,00'           | ''          | ''             | '250,00' | '1'            | ''           | ''         | 'Услуга'                   | 'Передача с полной оплатой' |
	И таблица "ТаблицаОплат" стала равной:
		| 'Тип оплаты'      | 'Сумма'  |
		| 'Наличная оплата' | '250,00' |

Сценарий: Проверка PaymentMethod 5 (Передача с частичной оплатой)
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "Контрагент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная$$"
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст '50'
<<<<<<< HEAD
=======
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
>>>>>>> e54d268d0dd2607d0e11b145e48b016b7d96d298
	И я нажимаю на кнопку с именем 'Оплатить'
	И я нажимаю на кнопку с именем 'Button0'
	И я проверяю закрытие смены

* Проверка чека
//Частичная оплата наличными PaymentMethod=5 (Передача с частичной оплатой)
	И я активизирую окно "Исходные данные чека"
	И элемент формы с именем "XML" стал равен по шаблону
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                                       |
		| '<CheckPackage>'                                                                                                                                                                                                                                                                   |
		| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                                               |
		| '		<AgentData/>'                                                                                                                                                                                                                                                                   |
		| '		<VendorData/>'                                                                                                                                                                                                                                                                  |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                                              |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                                                        |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                                                           |
		| '	</Parameters>'                                                                                                                                                                                                                                                                   |
		| '	<Positions>'                                                                                                                                                                                                                                                                     |
		| '		<FiscalString Name=\" $$УслугаПерсональная$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"5\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                                                          |
		| '			<AgentData/>'                                                                                                                                                                                                                                                                  |
		| '			<VendorData/>'                                                                                                                                                                                                                                                                 |
		| '		</FiscalString>'                                                                                                                                                                                                                                                                |
		| '	</Positions>'                                                                                                                                                                                                                                                                    |
		| '	<Payments Cash=\"50\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"200\" Barter=\"0\"/>'                                                                                                                                                             |
		| '</CheckPackage>'                                                                                                                                                                                                                                                                  |
	И таблица "ПозицииЧека" стала равной:
		| 'Наименование'            | 'Количество' | 'Цена'   | 'Цена со скидками' | 'Сумма НДС' | 'Сумма скидок' | 'Сумма'  | 'Номер секции' | 'Ставка НДС' | 'Штрихкод' | 'Признак предмета расчета' | 'Признак способа расчета'      |
		| ' $$УслугаПерсональная$$' | '1,00'       | '250,00' | '250,00'           | ''          | ''             | '250,00' | '1'            | ''           | ''         | 'Услуга'                   | 'Передача с частичной оплатой' |
	И таблица "ТаблицаОплат" стала равной:
		| 'Тип оплаты'          | 'Сумма'  |
		| 'Наличная оплата'     | '50,00'  |
		| 'Постоплата (кредит)' | '200,00' |

Сценарий: Проверка PaymentMethod 6 (Передача без оплаты)
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем "Контрагент" я выбираю по строке '$$Клиент$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная$$"
	И я нажимаю на кнопку с именем 'ФормаПровести'
	И я нажимаю на кнопку с именем 'ФормаПечатьЧекаККТБезОплаты'
	Если открылось окно "Отправить копию чека" Тогда
		И я нажимаю на кнопку с именем 'Выбрать'	
	Если открылось окно "Кассы" Тогда
		И в таблице 'Список' я перехожу к строке по шаблону
			| "Код" | "Наименование"   | "Организация" |
			| "*"   | "Основная касса" | "*"           |
		И я нажимаю на кнопку с именем 'КнопкаВыбрать'
		И я нажимаю на кнопку с именем 'Выбрать'
	
				
* Проверка чека
//Чек без оплаты PaymentMethod=6 (6. Предоплата полная (ПрОп100))
	И я активизирую окно "Исходные данные чека"
	И элемент формы с именем "XML" стал равен по шаблону
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                                       |
		| '<CheckPackage>'                                                                                                                                                                                                                                                                   |
		| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                                               |
		| '		<AgentData/>'                                                                                                                                                                                                                                                                   |
		| '		<VendorData/>'                                                                                                                                                                                                                                                                  |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                                              |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                                                        |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                                                           |
		| '	</Parameters>'                                                                                                                                                                                                                                                                   |
		| '	<Positions>'                                                                                                                                                                                                                                                                     |
		| '		<FiscalString Name=\" $$УслугаПерсональная$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"6\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                                                          |
		| '			<AgentData/>'                                                                                                                                                                                                                                                                  |
		| '			<VendorData/>'                                                                                                                                                                                                                                                                 |
		| '		</FiscalString>'                                                                                                                                                                                                                                                                |
		| '	</Positions>'                                                                                                                                                                                                                                                                    |
		| '	<Payments Cash=\"0\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"250\" Barter=\"0\"/>'                                                                                                                                                                         |
		| '</CheckPackage>'                                                                                                                                                                                                                                                                  |
	И таблица "ПозицииЧека" стала равной:
		| 'Наименование'            | 'Количество' | 'Цена'   | 'Цена со скидками' | 'Сумма НДС' | 'Сумма скидок' | 'Сумма'  | 'Номер секции' | 'Ставка НДС' | 'Штрихкод' | 'Признак предмета расчета' | 'Признак способа расчета' |
		| ' $$УслугаПерсональная$$' | '1,00'       | '250,00' | '250,00'           | ''          | ''             | '250,00' | '1'            | ''           | ''         | 'Услуга'                   | 'Передача без оплаты'     |
	И таблица "ТаблицаОплат" стала равной:
		| 'Тип оплаты'          | 'Сумма'  |
		| 'Постоплата (кредит)' | '250,00' |

Сценарий: Проверка PaymentMethod 7 (Оплата кредита)
	И предыдущий сценарий выполнен успешно
	Дано Я открываю основную форму списка документа "Реализация"
	И я нажимаю на кнопку с именем 'СписокОплатить'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
<<<<<<< HEAD
=======
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
>>>>>>> e54d268d0dd2607d0e11b145e48b016b7d96d298
	И я нажимаю на кнопку с именем 'Оплатить'
	И я проверяю закрытие смены

* Проверка чека
	И я активизирую окно "Исходные данные чека"
	И элемент формы с именем "XML" стал равен по шаблону 
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                    |
		| '<CheckPackage>'                                                                                                                                                                                                                                                |
		| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                            |
		| '		<AgentData/>'                                                                                                                                                                                                                                                |
		| '		<VendorData/>'                                                                                                                                                                                                                                               |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                           |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                                     |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                                        |
		| '	</Parameters>'                                                                                                                                                                                                                                                |
		| '	<Positions>'                                                                                                                                                                                                                                                  |
		| '		<FiscalString Name=\" $$УслугаПерсональная$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"7\" CalculationSubject=\"10\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                                       |
		| '			<AgentData/>'                                                                                                                                                                                                                                               |
		| '			<VendorData/>'                                                                                                                                                                                                                                              |
		| '		</FiscalString>'                                                                                                                                                                                                                                             |
		| '	</Positions>'                                                                                                                                                                                                                                                 |
		| '	<Payments Cash=\"250\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'                                                                                                                                                             |
		| '</CheckPackage>'                                                                                                                                                                                                                                               |
	И таблица "ПозицииЧека" стала равной:
		| 'Наименование'            | 'Количество' | 'Цена'   | 'Цена со скидками' | 'Сумма НДС' | 'Сумма скидок' | 'Сумма'  | 'Номер секции' | 'Ставка НДС' | 'Штрихкод' | 'Признак предмета расчета' | 'Признак способа расчета' |
		| ' $$УслугаПерсональная$$' | '1,00'       | '250,00' | '250,00'           | ''          | ''             | '250,00' | '1'            | ''           | ''         | 'Платеж выплата'           | 'Оплата кредита'          |
	И таблица "ТаблицаОплат" стала равной:
		| 'Тип оплаты'      | 'Сумма'  |
		| 'Наличная оплата' | '250,00' |
