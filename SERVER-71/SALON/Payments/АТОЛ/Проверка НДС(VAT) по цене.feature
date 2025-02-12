﻿#language: ru

@tree

Функционал: Проверка НДС(VAT) по цене в xml

Фискальный регистратор: 'АТОЛ:ККТ с передачей данных в ОФД 10.Х (ФФД 1.2)'

Переменные:
	VATRate_Услуга_2 =	"20"
	VATAmount_Услуга_2 = "140"
	СтавкаНДС_Услуга_2 = 20"
	СуммаНДС_Услуга_2 = "140"

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Сценарий: 01. Первоначальная настройка
	И я удаляю все переменные

* Настройка систем налогообложения 
	И Я открываю навигационную ссылку "e1cib/list/РегистрСведений.ПрименениеСистемНалогообложения"
	Если в таблице "Список" количество строк "больше или равно" 1 Тогда
		И в таблице 'Список' я выделяю все строки
		И в таблице 'Список' я удаляю строку
		И я нажимаю на кнопку с именем 'Button0'
	И я закрываю текущее окно

	И я удаляю объекты "Справочники.СтавкиНДС" без контроля ссылок
	И я создаю все виды ставок НДС

* Настройка организации
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

	И в поле с именем 'ПолеФормыПериод_0' я ввожу текст "01.12.2024"	
	И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_0' я выбираю точное значение "Авансы"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "Без НДС"

	И я нажимаю на кнопку с именем 'ДобавитьГруппуПримененияСНО'				
	И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_1' я выбираю точное значение "Товары"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "Без НДС"

	И я нажимаю на кнопку с именем 'ДобавитьГруппуПримененияСНО'
	И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_2' я выбираю точное значение "Услуги"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "Без НДС"

	И я нажимаю на кнопку с именем 'ДобавитьГруппуПримененияСНО'
	И Я запоминаю случайное число в переменную "Группа"
	И я запоминаю значение выражения '"Группа" + Формат($Группа$,"ЧГ=0")' в переменную "$$ГруппаПриоритет$$"
	И я нажимаю на кнопку создать поля с именем 'ПолеФормыГруппаНалогообложения_3'	
	И в поле с именем 'Наименование' я ввожу текст '$$ГруппаПриоритет$$'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_3'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Общая"	
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_3'
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю по строке "20%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

* Настройка переменных SALON
	И Я создаю Клиента
	И Я создаю мастера
	И Я создаю Услугу
	И Я создаю Услугу_2

* Настройка номенклатуры услуга_2
	И я закрываю все окна клиентского приложения
	И Я открываю навигационную ссылку "$$СсылкаУслуги_2$$"
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'ГруппаНалогообложения'
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$ГруппаПриоритет$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Настройка цены "Розничная" (НЕ включ. НДС)
	И Я открываю основную форму списка справочника "ВидыЦен"
	И в таблице 'Список' я перехожу к строке:
		| "Наименование"   |
		| "Розничная цена" |
	И в таблице 'Список' я выбираю текущую строку
	И я снимаю флаг с именем 'ЦенаВключаетНДС'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		
	
Сценарий: 02. В чеке "VATRate=none"
	И Остановка если была ошибка в прошлом сценарии

	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку		

	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "Без НДС"

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

* Ввод переменных для проверки xml
	И я запоминаю строку "none" в переменную 'VATRate'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "" в переменную 'СтавкаНДС'
	И я запоминаю строку "" в переменную 'СуммаНДС'
	И я запоминаю строку "250" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "500" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'

	И Я проверяю xml реализации НДС (VAT) по цене
	И Я проверяю xml возврата реализации НДС (VAT) по цене

	// для проверки реализации с приоритетом номенклатуры
	И я запоминаю строку "420" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "840" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-140" в переменную 'СуммаСкидки'
	
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT) по цене

Сценарий: 03. В чеке "VATRate=0"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "0%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "0%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "0%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

* Ввод переменных для проверки xml
	И я запоминаю строку "0" в переменную 'VATRate'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "0" в переменную 'СтавкаНДС'
	И я запоминаю строку "" в переменную 'СуммаНДС'
	И я запоминаю строку "250" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "500" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "0" в переменную 'СуммаСкидки'

	И Я проверяю xml реализации НДС (VAT) по цене
	И Я проверяю xml возврата реализации НДС (VAT) по цене

	// для проверки реализации с приоритетом номенклатуры
	И я запоминаю строку "420" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "840" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-140" в переменную 'СуммаСкидки'
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT) по цене

Сценарий: 04. В чеке "VATRate=5"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	
	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "5%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "5%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "5%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

* Ввод переменных для проверки xml
	И я запоминаю строку "5" в переменную 'VATRate'
	И я запоминаю строку "25" в переменную 'VATAmount'
	И я запоминаю строку "5" в переменную 'СтавкаНДС'
	И я запоминаю строку "25,00" в переменную 'СуммаНДС'
	И я запоминаю строку "262.5" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "525" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-25" в переменную 'СуммаСкидки'

	И Я проверяю xml реализации НДС (VAT) по цене
	И Я проверяю xml возврата реализации НДС (VAT) по цене

	// для проверки реализации с приоритетом номенклатуры
	И я запоминаю строку "420" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "840" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-140" в переменную 'СуммаСкидки'

	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT) по цене

Сценарий: 05. В чеке "VATRate=7"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	
	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "7%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "7%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "7%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

* Ввод переменных для проверки xml
	И я запоминаю строку "7" в переменную 'VATRate'
	И я запоминаю строку "35" в переменную 'VATAmount'
	И я запоминаю строку "7" в переменную 'СтавкаНДС'
	И я запоминаю строку "35,00" в переменную 'СуммаНДС'
	И я запоминаю строку "267.5" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "535" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-35" в переменную 'СуммаСкидки'

	И Я проверяю xml реализации НДС (VAT) по цене
	И Я проверяю xml возврата реализации НДС (VAT) по цене

	// для проверки реализации с приоритетом номенклатуры
	И я запоминаю строку "420" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "840" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-140" в переменную 'СуммаСкидки'
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT) по цене

Сценарий: 06. В чеке "VATRate=10"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	
	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "10%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "10%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "10%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

* Ввод переменных для проверки xml
	И я запоминаю строку "10" в переменную 'VATRate'
	И я запоминаю строку "50" в переменную 'VATAmount'
	И я запоминаю строку "10" в переменную 'СтавкаНДС'
	И я запоминаю строку "50,00" в переменную 'СуммаНДС'
	И я запоминаю строку "275" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "550" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-50" в переменную 'СуммаСкидки'

	И Я проверяю xml реализации НДС (VAT) по цене
	И Я проверяю xml возврата реализации НДС (VAT) по цене

	// для проверки реализации с приоритетом номенклатуры
	И я запоминаю строку "420" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "840" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-140" в переменную 'СуммаСкидки'
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT) по цене

Сценарий: 07. В чеке "VATRate=18"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "18%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "18%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "18%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

* Ввод переменных для проверки xml
	И я запоминаю строку "18" в переменную 'VATRate'
	И я запоминаю строку "90" в переменную 'VATAmount'
	И я запоминаю строку "18" в переменную 'СтавкаНДС'
	И я запоминаю строку "90,00" в переменную 'СуммаНДС'
	И я запоминаю строку "295" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "590" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-90" в переменную 'СуммаСкидки'

	И Я проверяю xml реализации НДС (VAT) по цене
	И Я проверяю xml возврата реализации НДС (VAT) по цене

	// для проверки реализации с приоритетом номенклатуры
	И я запоминаю строку "420" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "840" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-140" в переменную 'СуммаСкидки'
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT) по цене

Сценарий: 08. В чеке "VATRate=20"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "20%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "20%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "20%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю по строке "10%"
		
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

* Ввод переменных для проверки xml
	И я запоминаю строку "20" в переменную 'VATRate'
	И я запоминаю строку "100" в переменную 'VATAmount'
	И я запоминаю строку "20" в переменную 'СтавкаНДС'
	И я запоминаю строку "100,00" в переменную 'СуммаНДС'
	И я запоминаю строку "300" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "600" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-100" в переменную 'СуммаСкидки'

// Если будут вопросы почему так: '{"ИмяПеременной"}'
// https://t.me/testspro1c/90582

	И Я проверяю xml реализации НДС (VAT) по цене
	И Я проверяю xml возврата реализации НДС (VAT) по цене

	И я запоминаю строку "10" в переменную '{"VATRate_Услуга_2"}'
	И я запоминаю строку "70" в переменную '{"VATAmount_Услуга_2"}'
	И я запоминаю строку "10" в переменную '{"СтавкаНДС_Услуга_2"}'
	И я запоминаю строку "70" в переменную '{"СуммаНДС_Услуга_2"}'
	И я запоминаю строку "385" в переменную 'ЦенаСоСкидкой'
	И я запоминаю строку "770" в переменную 'СуммаСоСкидкой'
	И я запоминаю строку "-70" в переменную 'СуммаСкидки'
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT) по цене

Сценарий: 09. Возврат к исходному состоянию
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'УдалитьСтроку_3'
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю по строке "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю по строке "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю по строке "Без НДС"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'

	И Я открываю основную форму списка справочника "ВидыЦен"
	И в таблице 'Список' я перехожу к строке:
		| "Наименование"   |
		| "Розничная цена" |
	И в таблице 'Список' я выбираю текущую строку
	И я устанавливаю флаг с именем 'ЦенаВключаетНДС'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'