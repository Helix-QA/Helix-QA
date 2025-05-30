﻿#language: ru

@tree

Функционал: Проверка оплат через кассу АТОЛ со ставками НДС

	Ставка НДС:
| 'Код'    | 'Описание'                |
| 'none'   | 'БЕЗ НДС'                 |
| '0'      | 'НДС 0'                   |
| '5'      | 'НДС 5'                   |
| '7'      | 'НДС 7'                   |
| '10'     | 'НДС 10'                  |
| '18'     | 'НДС 18'                  |
| '20'     | 'НДС 20'                  |
| '10/110' | 'расчетная ставка 10/110' |
| '18/118' | 'расчетная ставка 18/118' |
| '20/120' | 'расчетная ставка 20/120' |

Переменные:
	VATRate_УслугаПерсональная_2 =	"none"
	VATAmount_УслугаПерсональная_2 = "0"
	СтавкаНДС_УслугаПерсональная_2 = ""
	СуммаНДС_УслугаПерсональная_2 = ""
	// PaymentMethod = "4"
	// ПризнакСпособаРасчета = "Передача с полной оплатой"

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения
	
Сценарий: 01. Первоначальная настройка
* Настройка переменных
	И я удаляю все переменные
	И я создаю клиента
	И Я создаю Услуга_Персональная
	И Я создаю Услуга_Персональная_2
	И Я генерирую СлучайноеЧисло

	// --- Добавлено
	Дано я запоминаю строку "4" в переменную "$$PaymentMethod$$"
	Дано я запоминаю строку "Передача с полной оплатой" в переменную "$$ПризнакСпособаРасчета$$"

	И я удаляю объекты "Справочники.СтавкиНДС" без контроля ссылок

	* Создание Ставки НДС (для организации)
	И Я открываю основную форму списка справочника "СтавкиНДС"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "НДС_$$СлучайноеЧисло$$"
	И в поле с именем 'Ставка' я ввожу текст "0"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование"           |
		| "НДС_$$СлучайноеЧисло$$" |
	И в таблице 'Список' я выбираю текущую строку
// 	И Я запоминаю значение выражения '$СсылкаНДС_лок$' в переменную "$$СсылкаНДС$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Настройка организации
	И Я открываю навигационную ссылку "e1cib/list/РегистрСведений.ПрименениеСистемНалогообложения"
	Если в таблице "Список" количество строк "больше или равно" 1 Тогда
		И в таблице 'Список' я выделяю все строки
		И в таблице 'Список' я удаляю строку
		И я нажимаю на кнопку с именем 'Button0'
	И я закрываю текущее окно

	И Я открываю основную форму списка справочника "Организации"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я снимаю флаг с именем 'АвансоваяСхемаПробитияУслуг'

	Если элемент "ПолеФормыПредметНалогообложения_0" доступен не только для просмотра Тогда
		И в поле с именем 'ПолеФормыПериод_0' я ввожу текст "01.12.2024"	
		И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_0' я выбираю точное значение "Авансы"
		И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Общая"
		И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "Без НДС"

		И я нажимаю на кнопку с именем 'КнопкаДобавитьГруппуПримененияСНО'				
		И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_1' я выбираю точное значение "Товары"
		И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Общая"
		И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "Без НДС"

		И я нажимаю на кнопку с именем 'КнопкаДобавитьГруппуПримененияСНО'
		И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_2' я выбираю точное значение "Услуги"
		И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Общая"
		И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "Без НДС"

	И я нажимаю на кнопку с именем 'КнопкаДобавитьГруппуПримененияСНО'
	Дано я запоминаю значение выражения 'Группа$$СлучайноеЧисло$$' в переменную "$$ГруппаПриоритет$$"
	И я нажимаю на кнопку создать поля с именем 'ПолеФормыГруппаНалогообложения_3'	
	И в поле с именем 'Наименование' я ввожу текст '$$ГруппаПриоритет$$'	

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_3'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"		

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'


* Настройка номенклатуры
	И Я открываю навигационную ссылку "$$СсылкаУслугаПерсональная_2$$"
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И из выпадающего списка с именем 'ГруппаНалогообложения' я выбираю "$$ГруппаПриоритет$$"	
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'

Сценарий: 02. VAT=none
	И Остановка если была ошибка в прошлом сценарии
	И я закрываю все окна клиентского приложения
* Ввод переменных для проверки xml
	И я запоминаю строку "none" в переменную 'VATRate'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "" в переменную 'СтавкаНДС'
	И я запоминаю строку "" в переменную 'СуммаНДС'
	И я запоминаю строку "0" в переменную "TaxationSystem"

	// --- Добавлено: для проверки реализации с учетом цены включающей НДС
	И я запоминаю строку "250" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "500" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'

// Если будут вопросы почему так: '{"ИмяПеременной"}'
// https://t.me/testspro1c/90582

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)

	И Я проверяю xml реализации НДС (VAT) (цена включает НДС)
	И Я проверяю xml возврата реализации НДС (VAT) (цена включает НДС)

	// --- Обновление переменных для проверки по Услуге 2
	И я запоминаю строку "0" в переменную '{"VATRate_УслугаПерсональная_2"}'
	И я запоминаю строку "0" в переменную '{"СтавкаНДС_УслугаПерсональная_2"}'
	И я запоминаю строку "350" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "700" в переменную 'СуммаСоСкидкой'
	
	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT) (цена включает НДС)

Сценарий: 03. VAT=0%
	И я закрываю все окна клиентского приложения
* Настройка организации
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю "Без НДС"

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "0" в переменную 'VATRate'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "0" в переменную 'СтавкаНДС'
	И я запоминаю строку "" в переменную 'СуммаНДС'
	И я запоминаю строку "0" в переменную "TaxationSystem"

	// --- Добавлено: для проверки с учетом цены включающей НДС
	И я запоминаю строку "250" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "500" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)

	И Я проверяю xml реализации НДС (VAT) (цена включает НДС)
	И Я проверяю xml возврата реализации НДС (VAT) (цена включает НДС)
	
	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

	// --- Обновление переменных для проверки по Услуге 2
	И я запоминаю строку "350" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "700" в переменную 'СуммаСоСкидкой'

	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT) (цена включает НДС)

Сценарий: 04. VAT=10%
	И я закрываю все окна клиентского приложения
* Настройка НДС
	И я открываю текущую ставку НДС
	И в поле с именем 'Ставка' я ввожу текст "10"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "10" в переменную 'VATRate'
	И я запоминаю строку "45.45" в переменную 'VATAmount'
	И я запоминаю строку "10" в переменную 'СтавкаНДС'
	И я запоминаю строку "45,45" в переменную 'СуммаНДС'
	И я запоминаю строку "0" в переменную "TaxationSystem"

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

	И я закрываю все окна клиентского приложения

	// --- Добавлено: для проверки с учетом цены включающей НДС
	И я запоминаю строку "275" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "550" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-50" в переменную 'СуммаСкидки'
	И я запоминаю строку "10" в переменную 'VATRate'
	И я запоминаю строку "50" в переменную 'VATAmount'
	И я запоминаю строку "10" в переменную 'СтавкаНДС'
	И я запоминаю строку "50,00" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT) (цена включает НДС)
	И Я проверяю xml возврата реализации НДС (VAT) (цена включает НДС)
	
	// --- Обновление переменных для проверки по Услуге 2
	И я запоминаю строку "350" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "700" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "0,00" в переменную 'СуммаНДС'

	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT) (цена включает НДС)
	
Сценарий: 05. VAT=18%
	И я закрываю все окна клиентского приложения
* Настройка НДС
	И я открываю текущую ставку НДС
	И в поле с именем 'Ставка' я ввожу текст "18"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "18" в переменную 'VATRate'
	И я запоминаю строку "76.27" в переменную 'VATAmount'
	И я запоминаю строку "18" в переменную 'СтавкаНДС'
	И я запоминаю строку "76,27" в переменную 'СуммаНДС'
	И я запоминаю строку "0" в переменную "TaxationSystem"

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

	// --- Добавлено: для проверки с учетом цены включающей НДС
	И я запоминаю строку "295" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "590" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-90" в переменную 'СуммаСкидки'
	И я запоминаю строку "18" в переменную 'VATRate'
	И я запоминаю строку "90" в переменную 'VATAmount'
	И я запоминаю строку "18" в переменную 'СтавкаНДС'
	И я запоминаю строку "90,00" в переменную 'СуммаНДС'

	И я закрываю все окна клиентского приложения

	И Я проверяю xml реализации НДС (VAT) (цена включает НДС)
	И Я проверяю xml возврата реализации НДС (VAT) (цена включает НДС)
	
	// --- Обновление переменных для проверки по Услуге 2
	И я запоминаю строку "350" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "700" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "0,00" в переменную 'СуммаНДС'

	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT) (цена включает НДС)

Сценарий: 06. VAT=20%
	И я закрываю все окна клиентского приложения
* Настройка НДС
	И я открываю текущую ставку НДС
	И в поле с именем 'Ставка' я ввожу текст "20"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "20" в переменную 'VATRate'
	И я запоминаю строку "83.33" в переменную 'VATAmount'
	И я запоминаю строку "20" в переменную 'СтавкаНДС'
	И я запоминаю строку "83,33" в переменную 'СуммаНДС'
	И я запоминаю строку "0" в переменную "TaxationSystem"

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

	И я закрываю все окна клиентского приложения

	// --- Добавлено: для проверки с учетом цены включающей НДС
	И я запоминаю строку "300" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "600" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-100" в переменную 'СуммаСкидки'
	И я запоминаю строку "20" в переменную 'VATRate'
	И я запоминаю строку "100" в переменную 'VATAmount'
	И я запоминаю строку "20" в переменную 'СтавкаНДС'
	И я запоминаю строку "100,00" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT) (цена включает НДС)
	И Я проверяю xml возврата реализации НДС (VAT) (цена включает НДС)
	
	// --- Обновление переменных для проверки по Услуге 2
	И я запоминаю строку "350" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "700" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "0,00" в переменную 'СуммаНДС'

	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT) (цена включает НДС)

Сценарий: 07. VAT=20/120%
	И я закрываю все окна клиентского приложения
* Настройка организации
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	И я устанавливаю флаг с именем 'АвансоваяСхемаПробитияУслуг'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "20/120" в переменную 'VATRate'
	И я запоминаю строку "83.33" в переменную 'VATAmount'
	И я запоминаю строку "120" в переменную 'СтавкаНДС'
	И я запоминаю строку "83,33" в переменную 'СуммаНДС'
	И я запоминаю строку "0" в переменную "TaxationSystem"
	// Из за смены схемы пробития услуг, надо дополнительные переменные
	И я удаляю переменную '$$PaymentMethod$$'
	И Я запоминаю строку '1' в переменную '$$PaymentMethod$$'
	И я удаляю переменную '$$ПризнакСпособаРасчета$$'
	И я запоминаю строку "Предоплата полная" в переменную '$$ПризнакСпособаРасчета$$'


	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

	И я закрываю все окна клиентского приложения

	// --- Добавлено: для проверки с учетом цены включающей НДС
	И я запоминаю строку "300" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "600" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-100" в переменную 'СуммаСкидки'
	И я запоминаю строку "120" в переменную 'СтавкаНДС'
	И я запоминаю строку "100,00" в переменную 'СуммаНДС'
	И я запоминаю строку "100" в переменную 'VATAmount'

	И Я проверяю xml реализации НДС (VAT) (цена включает НДС)
	И Я проверяю xml возврата реализации НДС (VAT) (цена включает НДС)
	
	// --- Обновление переменных для проверки по Услуге 2
	И я запоминаю строку "350" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "700" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "0,00" в переменную 'СуммаНДС'

	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT) (цена включает НДС)

Сценарий: 08. VAT=18/180%
	И я закрываю все окна клиентского приложения
* Настройка НДС
	И я открываю текущую ставку НДС
	И в поле с именем 'Ставка' я ввожу текст "18"
//	И я устанавливаю флаг с именем 'Расчетная'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "18/118" в переменную 'VATRate'
	И я запоминаю строку "76.27" в переменную 'VATAmount'
	И я запоминаю строку "118" в переменную 'СтавкаНДС'
	И я запоминаю строку "76,27" в переменную 'СуммаНДС'
	И я запоминаю строку "0" в переменную "TaxationSystem"

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

	И я закрываю все окна клиентского приложения

	// --- Добавлено: для проверки с учетом цены включающей НДС
	И я запоминаю строку "295" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "590" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-90" в переменную 'СуммаСкидки'
	И я запоминаю строку "18/118" в переменную 'VATRate'
	И я запоминаю строку "90" в переменную 'VATAmount'
	И я запоминаю строку "118" в переменную 'СтавкаНДС'
	И я запоминаю строку "90,00" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT) (цена включает НДС)
	И Я проверяю xml возврата реализации НДС (VAT) (цена включает НДС)
	
	// --- Обновление переменных для проверки по Услуге 2
	И я запоминаю строку "350" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "700" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "0,00" в переменную 'СуммаНДС'

	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT) (цена включает НДС)

Сценарий: 09. VAT=10/110%
	И я закрываю все окна клиентского приложения
* Настройка НДС
	И я открываю текущую ставку НДС
	И в поле с именем 'Ставка' я ввожу текст "10"
	И я устанавливаю флаг с именем 'Расчетная'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "10/110" в переменную 'VATRate'
	И я запоминаю строку "45.45" в переменную 'VATAmount'
	И я запоминаю строку "110" в переменную 'СтавкаНДС'
	И я запоминаю строку "45,45" в переменную 'СуммаНДС'
	И я запоминаю строку "0" в переменную "TaxationSystem"

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

	И я закрываю все окна клиентского приложения

	// --- Добавлено: для проверки с учетом цены включающей НДС
	И я запоминаю строку "275" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "550" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-50" в переменную 'СуммаСкидки'
	И я запоминаю строку "10/110" в переменную 'VATRate'
	И я запоминаю строку "50" в переменную 'VATAmount'
	И я запоминаю строку "110" в переменную 'СтавкаНДС'
	И я запоминаю строку "50,00" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT) (цена включает НДС)
	И Я проверяю xml возврата реализации НДС (VAT) (цена включает НДС)
	
	// --- Обновление переменных для проверки по Услуге 2
	И я запоминаю строку "350" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "700" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "0,00" в переменную 'СуммаНДС'

	И я закрываю все окна клиентского приложения

	И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT) (цена включает НДС)

Сценарий: 10. Проверка СНО Упрощенная
	* Ставка 5%
		И я закрываю все окна клиентского приложения
		* Настройка НДС
			И я открываю текущую ставку НДС
			И в поле с именем 'Ставка' я ввожу текст "5"
			И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		* Настройка Организации
			И Я открываю основную форму списка справочника "Организации"
			И в таблице 'Список' я выбираю текущую строку
			И я снимаю флаг с именем 'АвансоваяСхемаПробитияУслуг'
			И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Упрощенная доход"
			И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Упрощенная доход"
			И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Упрощенная доход"
			И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Упрощенная доход"
			И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
			И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
			И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
			И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю "Без НДС"
			И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

		* Настройка сотрудника
//			И я открываю основную форму списка справочника "Сотрудники"	
//			И я активизирую дополнение формы с именем 'СтрокаПоиска'
//			И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "Админ"
//			И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
//			И в таблице 'Список' я выбираю текущую строку
//			И я нажимаю на кнопку с именем 'СписокДоступныеКассыКнопкаДобавить'
//			И в меню формы я выбираю 'АтолУСН (касса)'
//			// ----- ПРОВЕРИТЬ НОМЕР ВЫБРАННОЙ КАССЫ -----
//			И я нажимаю на гиперссылку с именем 'ДоступнаяКассаВыбранные_3'
//			И в меню формы я выбираю 'Назначить основной'	
//			И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
									
		* Ввод переменных для проверки xml
			И я удаляю переменную '$$PaymentMethod$$'
			Дано я запоминаю строку "4" в переменную "$$PaymentMethod$$"
			И я удаляю переменную '$$ПризнакСпособаРасчета$$'
			Дано я запоминаю строку "Передача с полной оплатой" в переменную "$$ПризнакСпособаРасчета$$"

			И я запоминаю строку "5" в переменную 'VATRate'
			И я запоминаю строку "23.81" в переменную 'VATAmount'
			И я запоминаю строку "5" в переменную 'СтавкаНДС'
			И я запоминаю строку "23,81" в переменную 'СуммаНДС'
			И я запоминаю строку "1" в переменную "TaxationSystem"

			И Я проверяю xml реализации НДС (VAT)
			И Я проверяю xml возврата реализации НДС (VAT)
			И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

			И я закрываю все окна клиентского приложения

	* Ставка 7%
		И я закрываю все окна клиентского приложения
		* Настройка НДС
			И я открываю текущую ставку НДС
			И в поле с именем 'Ставка' я ввожу текст "7"
			И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		* Ввод переменных для проверки xml
			И я запоминаю строку "7" в переменную 'VATRate'
			И я запоминаю строку "32.71" в переменную 'VATAmount'
			И я запоминаю строку "7" в переменную 'СтавкаНДС'
			И я запоминаю строку "32,71" в переменную 'СуммаНДС'
			И я запоминаю строку "1" в переменную "TaxationSystem"

			И Я проверяю xml реализации НДС (VAT)
			И Я проверяю xml возврата реализации НДС (VAT)
			И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

			И я закрываю все окна клиентского приложения

Сценарий: 11. Проверка СНО Упрощенная доход минус расход
	* Ставка 5%
		И я закрываю все окна клиентского приложения
		* Настройка НДС
			И я открываю текущую ставку НДС
			И в поле с именем 'Ставка' я ввожу текст "5"
			И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		* Настройка Организации
			И Я открываю основную форму списка справочника "Организации"
			И в таблице 'Список' я выбираю текущую строку
			И я снимаю флаг с именем 'АвансоваяСхемаПробитияУслуг'
			И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Упрощенная доход минус расход"
			И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Упрощенная доход минус расход"
			И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Упрощенная доход минус расход"
			И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Упрощенная доход минус расход"
			И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
			И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
			И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "НДС_$$СлучайноеЧисло$$"
			И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю "Без НДС"
			И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'			
									
		* Ввод переменных для проверки xml
			И я запоминаю строку "5" в переменную 'VATRate'
			И я запоминаю строку "23.81" в переменную 'VATAmount'
			И я запоминаю строку "5" в переменную 'СтавкаНДС'
			И я запоминаю строку "23,81" в переменную 'СуммаНДС'
			И я запоминаю строку "2" в переменную "TaxationSystem"

			И Я проверяю xml реализации НДС (VAT)
			И Я проверяю xml возврата реализации НДС (VAT)
			И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

			И я закрываю все окна клиентского приложения

	* Ставка 7%
		И я закрываю все окна клиентского приложения
		* Настройка НДС
			И я открываю текущую ставку НДС
			И в поле с именем 'Ставка' я ввожу текст "7"
			И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		* Ввод переменных для проверки xml
			И я запоминаю строку "7" в переменную 'VATRate'
			И я запоминаю строку "32.71" в переменную 'VATAmount'
			И я запоминаю строку "7" в переменную 'СтавкаНДС'
			И я запоминаю строку "32,71" в переменную 'СуммаНДС'
			И я запоминаю строку "2" в переменную "TaxationSystem"

			И Я проверяю xml реализации НДС (VAT)
			И Я проверяю xml возврата реализации НДС (VAT)
			И Я проверяю xml с приоритетом номенклатуры реализации НДС (VAT)

			И я закрываю все окна клиентского приложения
Сценарий: 12. Возврат в исходное состояние
* Настройка организации
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	И я снимаю флаг с именем 'АвансоваяСхемаПробитияУслуг'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "Без НДС"
	И я нажимаю на кнопку с именем 'УдалитьСтроку_3'	
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
* Настройка сотрудника
//	И я открываю основную форму списка справочника "Сотрудники"	
//	И я активизирую дополнение формы с именем 'СтрокаПоиска'
//	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "Админ"
//	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
//	И в таблице 'Список' я выбираю текущую строку
//	И я нажимаю на гиперссылку с именем 'ДоступнаяКассаУдалить_3'
//	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		