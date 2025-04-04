﻿#language: ru

@tree
@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортный сценарий для проверки ЧПУ


Сценарий: Я создаю пробный пакет услуг_ЧПУ.	
	Дано я открываю основную форму справочника "Номенклатура"
	И Я запоминаю случайное число в переменную "СлучайноеЧисло"
	Дано я запоминаю значение выражения '"ПробныйПакет" + Формат($СлучайноеЧисло$, "ЧГ=0")' в переменную "$$ПробныйПакет$$"
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Пакет"
	И в поле с именем "Наименование" я ввожу значение выражения "$$ПробныйПакет$$"
	И я нажимаю кнопку выбора у поля с именем 'ЧленствоПакетУслугСоставУслугУслугаСегментПолемСтрока_0'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
//Добавление услуг.	
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$УслугаПерсональная$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 20 секунд
	И в таблице "Список" я выбираю текущую строку
	И в поле с именем 'ЧленствоПакетУслугСоставУслугКоличествоПолемСтрока_0' я ввожу текст "10,00"
	И я нажимаю на кнопку с именем 'ДобавитьСтрочкуДоступныхУслуг'
	И я нажимаю кнопку выбора у поля с именем 'ЧленствоПакетУслугСоставУслугУслугаСегментПолемСтрока_1'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$УслугаГрупповая$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 20 секунд
	И в таблице "Список" я выбираю текущую строку	
	И в поле с именем 'ЧленствоПакетУслугСоставУслугКоличествоПолемСтрока_1' я ввожу текст "10,00"
//Установка нужного флага и срока действия.
	И я устанавливаю флаг с именем 'ПереключательПробныйПакетУслуг'
	И в поле с именем 'СрокДествияЧленстваПакетаУслуг' я ввожу текст "1"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЦену'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю кнопку выбора у поля с именем 'Период'
	И в поле с именем 'Период' я ввожу текст "01.01.2025"
	И в поле с именем 'Цена' я ввожу текст "1 000,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'Записать'
	И я сохраняю навигационную ссылку текущего окна в переменную "$$СсылкаПробныйПакет$$"
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			




