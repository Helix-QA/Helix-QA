﻿#language: ru
@tree

Функционал: Проверка система налогообложения (TaxationSystem) 0-5

	Системы налогообложения (TaxationSystem)
	| 'Код' | 'Описание'                          |
	| '0'   | 'Общая'                             |
	| '1'   | 'Упрощенная (Доход)'                |
	| '2'   | 'Упрощенная (Доход минус Расход)'   |
	| '3'   | 'Единый налог на вмененный доход'   |
	| '4'   | 'Единый сельскохозяйственный налог' |
	| '5'   | 'Патентная система налогообложения' |

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Сценарий: 01. Первоначальная настройка
	И я удаляю все переменные

	// Удаление примененных ранее систем налогообложения
	И Я открываю навигационную ссылку "e1cib/list/РегистрСведений.ПрименениеСистемНалогообложения"
	Если в таблице "Список" количество строк "больше или равно" 1 Тогда
		И в таблице 'Список' я выделяю все строки
		И в таблице 'Список' я удаляю строку
		И я нажимаю на кнопку с именем 'Button0'
	И я закрываю текущее окно
		
	И я создаю пациента
	И Я создаю врача
	И Я создаю услугу
	И Я создаю услугу_2

Сценарий: 02. СистемаНалогообложенияДляУслуг -  Общая - 0
	И Остановка если была ошибка в прошлом сценарии

* Настройка организации
	Дано Я открываю основную форму списка справочника "Организации"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице "Список" я выбираю текущую строку
	
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
	Дано я запоминаю значение выражения 'Группа$$Услуга_2$$' в переменную "$$ГруппаПриоритет$$"
	И я нажимаю на кнопку создать поля с именем 'ПолеФормыГруппаНалогообложения_3'	
	И в поле с именем 'Наименование' я ввожу текст '$$ГруппаПриоритет$$'	

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_3'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Патентная система налогообложения"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю точное значение "Без НДС"
			
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	* Установка на Услуга_2 "ВидНалога" 'Патентная система налогообложения'
	Дано Я открываю основную форму списка справочника "Номенклатура"
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$Услуга_2$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'ГруппаНалогообложения'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование"        |
		| "$$ГруппаПриоритет$$" |
	И в таблице 'Список' я выбираю текущую строку	
	И я сохраняю навигационную ссылку текущего окна в переменную "$$СсылкаУслуга_2$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запоминаю значение выражения "Формат(строка(5))" в переменную "$$СистемыНалогообложения2$$"

	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "Формат(строка(0))" в переменную "$$СистемыНалогообложения$$"
	И Я проверяю XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю возврат XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю XML_TaxationSystem (СПриоритетомНоменклатуры)
	

Сценарий: 03. СистемаНалогообложенияДляУслуг -  Упрощенная доход - 1
	Дано Я открываю основную форму списка справочника "Организации"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице "Список" я выбираю текущую строку

	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Упрощенная доход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Упрощенная доход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Упрощенная доход"	
	
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "Формат(строка(1))" в переменную "$$СистемыНалогообложения$$"
	И Я проверяю XML_TaxationSystem
	И я закрываю все окна клиентского приложения

	И Я проверяю возврат XML_TaxationSystem
	И я закрываю все окна клиентского приложения

	И Я проверяю XML_TaxationSystem (СПриоритетомНоменклатуры)

Сценарий: 04. СистемаНалогообложенияДляУслуг - Упрощенная доход минус расход - 2
	Дано Я открываю основную форму списка справочника "Организации"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице "Список" я выбираю текущую строку

	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Упрощенная доход минус расход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Упрощенная доход минус расход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Упрощенная доход минус расход"

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "Формат(строка(2))" в переменную "$$СистемыНалогообложения$$"
	И Я проверяю XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю возврат XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю XML_TaxationSystem (СПриоритетомНоменклатуры)

Сценарий: 05. СистемаНалогообложенияДляУслуг - Единый налог на вмененный доход - 3
	Дано Я открываю основную форму списка справочника "Организации"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице "Список" я выбираю текущую строку

	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Единый налог на вмененный доход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Единый налог на вмененный доход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Единый налог на вмененный доход"

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "Формат(строка(3))" в переменную "$$СистемыНалогообложения$$"
	И Я проверяю XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю возврат XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю XML_TaxationSystem (СПриоритетомНоменклатуры)

Сценарий: 06. СистемаНалогообложенияДляУслуг - Единый сельскохозяйственный налог - 4
	Дано Я открываю основную форму списка справочника "Организации"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице "Список" я выбираю текущую строку
	
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Единый сельскохозяйственный налог"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Единый сельскохозяйственный налог"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Единый сельскохозяйственный налог"

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "Формат(строка(4))" в переменную "$$СистемыНалогообложения$$"
	И Я проверяю XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю возврат XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю XML_TaxationSystem (СПриоритетомНоменклатуры)

Сценарий: 07. СистемаНалогообложенияДляУслуг - Патентная система налогообложения - 5
	Дано Я открываю основную форму списка справочника "Организации"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице "Список" я выбираю текущую строку
	
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Патентная система налогообложения"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Патентная система налогообложения"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Патентная система налогообложения"

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "Формат(строка(5))" в переменную "$$СистемыНалогообложения$$"
	И Я проверяю XML_TaxationSystem
	И я закрываю все окна клиентского приложения
	И Я проверяю возврат XML_TaxationSystem
	И я закрываю все окна клиентского приложения

* Установка группе налогообложения вид налога 'Единый налог на вмененный доход'
	И я удаляю переменную 'СистемыНалогообложения2'
	И Я запоминаю значение выражения "Формат(строка(3))" в переменную "$$СистемыНалогообложения2$$"
	Дано Я открываю основную форму списка справочника "Организации"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице "Список" я выбираю текущую строку
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Единый налог на вмененный доход"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	И Я проверяю XML_TaxationSystem (СПриоритетомНоменклатуры)

Сценарий: 08. Возврат в исходное состояние
	Дано Я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Общая"

	И я нажимаю на кнопку с именем 'УдалитьСтроку_3'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
