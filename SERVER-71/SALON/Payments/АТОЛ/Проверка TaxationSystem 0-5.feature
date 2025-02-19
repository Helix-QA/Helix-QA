﻿#language: ru

@tree

Функционал: Проверка СистемаНалогообложенияДляУслуг (TaxationSystem) 0-5

				Системы налогообложения
	| 'Код' | '	Описание'                          |
	| '0'   | '	Общая'                             |
	| '1'   | '	Упрощенная (Доход)'                |
	| '2'   | '	Упрощенная (Доход минус Расход)'   |
	| '3'   | '	Единый налог на вмененный доход'   |
	| '4'   | '	Единый сельскохозяйственный налог' |
	| '5'   | '	Патентная система налогообложения' |

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Сценарий: 01. Первоначальная настройка
	И я удаляю все переменные
	И я закрываю все окна клиентского приложения
	И Я создаю Мастера
	И Я создаю ПакетУслуг
	И Я создаю Клиента
	И Я генерирую СлучайноеЧисло

	// Удаление примененных ранее систем налогообложения
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

	И я нажимаю на кнопку с именем 'ДобавитьГруппуПримененияСНО'
	Дано я запоминаю значение выражения 'Группа$$СлучайноеЧисло$$' в переменную "$$ГруппаПриоритет$$"
	И я нажимаю на кнопку создать поля с именем 'ПолеФормыГруппаНалогообложения_3'	
	И в поле с именем 'Наименование' я ввожу текст '$$ГруппаПриоритет$$'	

	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_3'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Патентная система налогообложения"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_3' я выбираю точное значение "Без НДС "
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'
		
	Дано Я открываю навигационную ссылку "$$СсылкаПакетУслуг$$"
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И из выпадающего списка с именем 'ГруппаНалогообложения' я выбираю "$$ГруппаПриоритет$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	И Я запоминаю значение выражения "строка(5)" в переменную "$$СистемыНалогообложения_номенкалатура$$"

Сценарий: 02. СистемаНалогообложенияДляУслуг - Общая - 0
* Проверка системы налогообложения
	И Я запоминаю значение выражения "строка(0)" в переменную "$$СистемыНалогообложения$$"
	И Я проверяю XML_TaxationSystem
	И Я проверяю возврат TaxationSystem
	И Я проверяю номенклатура_TaxationSystem


Сценарий: 03. СистемаНалогообложенияДляУслуг - Упрощенная доход - 1
* Установка системы налогообложения
	Дано Я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Упрощенная доход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Упрощенная доход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Упрощенная доход"
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "строка(1)" в переменную "$$СистемыНалогообложения$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'
	И Я проверяю XML_TaxationSystem
	И Я проверяю возврат TaxationSystem
	И Я проверяю номенклатура_TaxationSystem

Сценарий: 04. СистемаНалогообложенияДляУслуг - Упрощенная доход минус расход - 2
* Установка системы налогообложения
	Дано Я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Упрощенная доход минус расход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Упрощенная доход минус расход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Упрощенная доход минус расход"
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "строка(2)" в переменную "$$СистемыНалогообложения$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'
	И Я проверяю XML_TaxationSystem
	И Я проверяю возврат TaxationSystem
	И Я проверяю номенклатура_TaxationSystem

Сценарий: 05. СистемаНалогообложенияДляУслуг - Единый налог на вмененный доход - 3
* Установка системы налогообложения
	Дано Я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Единый налог на вмененный доход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Единый налог на вмененный доход"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Единый налог на вмененный доход"
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "строка(3)" в переменную "$$СистемыНалогообложения$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'
	И Я проверяю XML_TaxationSystem
	И Я проверяю возврат TaxationSystem
	И Я проверяю номенклатура_TaxationSystem

Сценарий: 06. СистемаНалогообложенияДляУслуг - Единый сельскохозяйственный налог - 4
* Установка системы налогообложения
	Дано Я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Единый сельскохозяйственный налог"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Единый сельскохозяйственный налог"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Единый сельскохозяйственный налог"
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "строка(4)" в переменную "$$СистемыНалогообложения$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'
	И Я проверяю XML_TaxationSystem
	И Я проверяю возврат TaxationSystem
	И Я проверяю номенклатура_TaxationSystem

Сценарий: 07. Настраиваю номенклатуру (TaxationSystem - 4)
	Дано Я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_3'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_3' я выбираю точное значение "Единый сельскохозяйственный налог"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'
	И я удаляю переменную 'СистемыНалогообложения_номенкалатура'
	И Я запоминаю значение выражения "строка(4)" в переменную "$$СистемыНалогообложения_номенкалатура$$"

Сценарий: 08. СистемаНалогообложенияДляУслуг - Патентная система налогообложения - 5
* Установка системы налогообложения
	Дано Я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Патентная система налогообложения"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Патентная система налогообложения"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Патентная система налогообложения"
	И я удаляю переменную 'СистемыНалогообложения'
	И Я запоминаю значение выражения "строка(5)" в переменную "$$СистемыНалогообложения$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'
	И Я проверяю XML_TaxationSystem
	И Я проверяю возврат TaxationSystem
	И Я проверяю номенклатура_TaxationSystem

Сценарий: 09. Возврат в исходное состояние
	Дано Я открываю основную форму списка справочника "Организации"
	И в таблице "Список" я выбираю текущую строку
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "Без НДС "
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "Без НДС "
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "Без НДС "
	И я нажимаю на кнопку с именем 'УдалитьСтроку_3'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть1'
		