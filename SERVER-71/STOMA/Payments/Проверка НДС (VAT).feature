﻿#language: ru

@tree

Функционал: Проверка VATRate в xml

Фискальный регистратор: 'АТОЛ:ККТ с передачей данных в ОФД 10.Х (ФФД 1.2)'

Переменные:
	VATRate_Товар_2 =	"20"
	VATAmount_Товар_2 = "43.75"
	СтавкаНДС_Товар_2 = 20"
	СуммаНДС_Товар_2 = "43,75"

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Сценарий: Первоначальная настройка
	И я удаляю все переменные

* Настройка систем налогообложения
	И Я открываю навигационную ссылку "e1cib/list/РегистрСведений.ПрименениеСистемНалогообложения"
	Если в таблице "Список" количество строк "больше или равно" 1 Тогда
		И в таблице 'Список' я выделяю все строки
		И в таблице 'Список' я удаляю строку
		И я нажимаю на кнопку с именем 'Button0'
	И я закрываю текущее окно
* Настройка организации
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

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
	И Я запоминаю случайное число в переменную "Группа"
	И я запоминаю значение выражения '"Группа" + Формат($Группа$,"ЧГ=0")' в переменную "$$ГруппаПриоритет$$"
	И я нажимаю на кнопку создать поля с именем 'ПолеФормыГруппаНалогообложения_3'	
	И в поле с именем 'Наименование' я ввожу текст '$$ГруппаПриоритет$$'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_3'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Общая"	
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_3'
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю точное значение "20%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Настройка переменных
	И Я создаю пациента
	И Я создаю товар
	И Я создаю товар_2

* Настройка номенклатуры товар_2
	И Я открываю навигационную ссылку "$$СсылкаТовара_2$$"
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'ГруппаНалогообложения'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ГруппаПриоритет$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Сценарий: В чеке "VATRate=none"
	И Остановка если была ошибка в прошлом сценарии

	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку		

* Проверка списка
	И я открываю выпадающий список с именем 'ПолеФормыСтавкаНДС_0'
	И выпадающий список с именем 'ПолеФормыСтавкаНДС_0' стал равен:
		| 'Без НДС' |
		| '0%'      |
		| '5%'      |
		| '7%'      |
		| '10%'     |
		| '18%'     |
		| '20%'     |

	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "Без НДС"

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "none" в переменную 'VATRate'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "" в переменную 'СтавкаНДС'
	И я запоминаю строку "" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT)

Сценарий: В чеке "VATRate=0"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "0%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "0%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "0%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "0" в переменную 'VATRate'
	И я запоминаю строку "0" в переменную 'VATAmount'
	И я запоминаю строку "" в переменную 'СтавкаНДС'
	И я запоминаю строку "" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT)

Сценарий: В чеке "VATRate=5"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	
	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "5%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "5%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "5%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "5" в переменную 'VATRate'
	И я запоминаю строку "26.65" в переменную 'VATAmount'
	И я запоминаю строку "5" в переменную 'СтавкаНДС'
	И я запоминаю строку "26,65" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT)

Сценарий: В чеке "VATRate=7"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	
	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "7%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "7%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "7%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "7" в переменную 'VATRate'
	И я запоминаю строку "36.61" в переменную 'VATAmount'
	И я запоминаю строку "7" в переменную 'СтавкаНДС'
	И я запоминаю строку "36,61" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT)

Сценарий: В чеке "VATRate=10"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	
	// Настройка НДС для всех предметов налогообложения
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "10%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "10%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "10%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "10" в переменную 'VATRate'
	И я запоминаю строку "50.87" в переменную 'VATAmount'
	И я запоминаю строку "10" в переменную 'СтавкаНДС'
	И я запоминаю строку "50,87" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT)

Сценарий: В чеке "VATRate=18"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "18%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "18%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "18%"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "18" в переменную 'VATRate'
	И я запоминаю строку "85.36" в переменную 'VATAmount'
	И я запоминаю строку "18" в переменную 'СтавкаНДС'
	И я запоминаю строку "85,36" в переменную 'СуммаНДС'

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT)

Сценарий: В чеке "VATRate=20"
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку

	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "20%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "20%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "20%"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю точное значение "10%"
		
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Ввод переменных для проверки xml
	И я запоминаю строку "20" в переменную 'VATRate'
	И я запоминаю строку "93.27" в переменную 'VATAmount'
	И я запоминаю строку "20" в переменную 'СтавкаНДС'
	И я запоминаю строку "93,27" в переменную 'СуммаНДС'
	И я запоминаю строку "10" в переменную '{"VATRate_Товар_2"}'
	И я запоминаю строку "23.86" в переменную '{"VATAmount_Товар_2"}'
	И я запоминаю строку "10" в переменную '{"СтавкаНДС_Товар_2"}'
	И я запоминаю строку "23,86" в переменную '{"СуммаНДС_Товар_2"}'

// Если будут вопросы почему так: '{"ИмяПеременной"}'
// https://t.me/testspro1c/90582

	И Я проверяю xml реализации НДС (VAT)
	И Я проверяю xml возврата реализации НДС (VAT)
	И Я проверяю xml с приорететом номенклатуры реализации НДС (VAT)

Сценарий: Очистка поля СтавкаНДС в Организации
	И Я открываю основную форму списка справочника "Организации"
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'УдалитьСтроку_3'
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "Без НДС"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "Без НДС"
		
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

		