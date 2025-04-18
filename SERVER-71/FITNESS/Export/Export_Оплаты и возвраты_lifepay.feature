﻿#language: ru

@tree
@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортный для lifepay

Фискальный регистратор: 'LifePay - онлайн фискализация в ОФД (54-ФЗ)'
Версия ФФД: "1,2"

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я удаляю все переменные

Сценарий: Я Оплатил документ через lifepay
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КассаОплаты_2'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я проверяю закрытие смены

Сценарий: Проверка xml lifepay
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму списка регистра сведений "ФискальныеОперации"
	И в таблице "Список" я перехожу к последней строке
	И в таблице 'Список' я выбираю текущую строку
	И я перехожу к закладке с именем 'XML'

Сценарий: Я проверяю XML_lifepay_TaxationSystem
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем 'Контрагент' я выбираю точное значение "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная$$"
	И Я Оплатил документ через lifepay

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": *'                                    |
		| '\"products\": *'                                    |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная$$\",*'            |
		| '\"price\": 250,*'                                   |
		| '\"quantity\": 1,*'                                  |
		| '\"tax\": \"none\",*'                                |
		| '\"unit\": \"piece\",*'                              |
		| '\"type\": \"4\",*'                                  |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"print\",*'                              |
		| '\"type\": \"payment\",*'                            |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"cash_amount\": 250,*'                             |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 0,*'                             |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"*\",*'                         |
		| '\"supplier_inn\": \"*\",*'                          |
		| '\"tax_system\": \"$СистемаНалогообложения$\",*'     |
		| '\"target_serial\": \"00106701076650\"*'             |
		| '}*'                                                 |
// Убрал проверку supplier_name (организация) и supplier_inn (кассир)

Сценарий: Я проверяю XML_lifepay_TaxationSystem (СПриоритетомНоменклатуры)
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем 'Контрагент' я выбираю точное значение "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная_2$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная_2$$"
	И Я Оплатил документ через lifepay

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": *'                                    |
		| '\"products\": *'                                    |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная_2$$\",*'          |
		| '\"price\": 350,*'                                   |
		| '\"quantity\": 1,*'                                  |
		| '\"tax\": \"none\",*'                                |
		| '\"unit\": \"piece\",*'                              |
		| '\"type\": \"4\",*'                                  |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"print\",*'                              |
		| '\"type\": \"payment\",*'                            |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"cash_amount\": 350,*'                             |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 0,*'                             |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"*\",*'                         |
		| '\"supplier_inn\": \"*\",*'                           |
		| '\"tax_system\": \"$СистемаНалогообложения2$\",*'    |
		| '\"target_serial\": \"00106701076650\"*'             |
		| '}*'                                                 |
// Убрал проверку supplier_name (организация) и supplier_inn (кассир)

Сценарий: Я создаю ставку НДС
	Дано Я открываю основную форму справочника "СтавкиНДС"
	И в поле с именем 'Наименование' я ввожу текст "НДС_lifepay"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	Дано Я открываю основную форму списка справочника "СтавкиНДС"
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "НДС_lifepay"   |
	И в таблице 'Список' я выбираю текущую строку
	И я сохраняю навигационную ссылку текущего окна в переменную "СтавкаНДС_лок" (Расширение)
	И Я запоминаю значение выражения '$СтавкаНДС_лок$' в переменную "$$СтавкаНДС$$"
	И я закрываю текущее окно

Сценарий: Я проверяю xml продажи со ставкой НДС
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем 'Контрагент' я выбираю точное значение "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная$$"
	И Я Оплатил документ через lifepay

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": *'                                    |
		| '\"products\": *'                                    |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная$$\",*'            |
		| '\"price\": 250,*'                                   |
		| '\"quantity\": 1,*'                                  |
		| '\"tax\": \"$VAT$\",*'                               |
		| '\"unit\": \"piece\",*'                              |
		| '\"type\": \"$PaymentMethod$\",*'                    |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"print\",*'                              |
		| '\"type\": \"payment\",*'                            |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"cash_amount\": 250,*'                             |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 0,*'                             |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"*\",*'                         |
		| '\"supplier_inn\": \"*\",*'                          |
		| '\"tax_system\": \"osn\",*'                          |
		| '\"target_serial\": \"00106701076650\"*'             |
		| '}*'                                                 |


