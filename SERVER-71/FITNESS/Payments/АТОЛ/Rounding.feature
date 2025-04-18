﻿#language: ru

@tree

Функционал: Проверка округления по тикету Евгения Б. 558131

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Сценарий: Создание данных для проверки округления в Фитнесе.
	И я удаляю все переменные
	И Я генерирую СлучайноеЧисло
	И Я создаю клиента
	И Я создаю Услуга_Персональная
	И Я создаю Услуга_Групповая
	И Я запоминаю ссылку на розничный вид цен.

Сценарий: Проверка созданных данных.
	И Остановка если была ошибка в прошлом сценарии

Сценарий: Создание бонусного счета для клиента.
	Дано Я открываю основную форму справочника "БонусныеСчета"
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И я нажимаю кнопку выбора у поля с именем "ВидБонусногоСчета"
	И я нажимаю на кнопку с именем 'Создать'
	И я меняю значение переключателя с именем 'Именной' на 'Именной'
	И в поле с именем 'Наименование' я ввожу текст 'Бонус $$СлучайноеЧисло$$'
	И в поле с именем 'СуммаПриветственногоНачисления' я ввожу текст '5000'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И в поле с именем 'Владелец' я ввожу текст '$$Клиент$$'
	И из выпадающего списка с именем 'Владелец' я выбираю точное значение "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Начисление ДС на бонусный счет.
	Дано я открываю основную форму документа "ОперацияПоБонусномуСчету"
	И из выпадающего списка с именем 'ВидОперации' я выбираю точное значение "Начисление"
	И из выпадающего списка с именем 'ВладелецБонусногоСчета' я выбираю по строке "$$Клиент$$"
	И я нажимаю кнопку выбора у поля с именем 'БонусныйСчет'
	И в таблице 'Список' я перехожу к строке по шаблону:
		| "Наименование"                            |
		| "*, Бонус $$СлучайноеЧисло$$, $$Клиент$$" |
	И в таблице "Список" я выбираю текущую строку
	И в поле с именем 'Сумма' я ввожу текст "45 000,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
		
Сценарий: Проверка округления 0.01.
	И Я запускаю сценарий с параметром "251,09"

Сценарий: Проверка округления 0.05.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "0.05"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запускаю сценарий с параметром "251,09"	
	
Сценарий: Проверка округления 0.1.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "0.1"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запускаю сценарий с параметром "251,09"					

Сценарий: Проверка округления 0.5.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "0.5"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запускаю сценарий с параметром "251,06"	

Сценарий: Проверка округления 1.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "1"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запускаю сценарий с параметром "251,99"	

Сценарий: Проверка округления 10.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "10"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запускаю сценарий с параметром "245,99"	

Сценарий: Проверка округления 100.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "100"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запускаю сценарий с параметром "245,99"

Сценарий: Проверка округления 5.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "5"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запускаю сценарий с параметром "245,99"

Сценарий: Проверка округления 50.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "50"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запускаю сценарий с параметром "264,99"

Сценарий: Проверка сброса выбранного способа оплаты(плашки).
//Наличные, а затем бонусный счет.
	Дано я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаГрупповая$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю "$$УслугаГрупповая$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю "$$УслугаПерсональная$$"			
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "250,00"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_1x0'
	И элемент формы с именем 'ПолеВидыОплатВводСуммыСтрока_0' стал равен "0"
//Если равно 0, то прошло проверку и плашка сбросилась.
	И элемент формы с именем 'ПолеВидыОплатВводСуммыСтрока_1x0' стал равен "500,00"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_1x0'
	И я нажимаю на кнопку с именем 'Оплатить'
//Лицевой счет, а затем бонусный.
	//Создание лицевого счета.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЛицевыеБонусныеСчета'
	И я нажимаю кнопку выбора у поля с именем 'ВидЛицевогоСчета'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" | "Организация"           |
		| "Основной"     | "Основная ораганизация" |
	И в таблице "Список" я выбираю текущую строку
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "5 000,00"
	И я нажимаю на кнопку с именем 'Оплатить'
//Проверка снятия плашки.
	Дано я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаГрупповая$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю "$$УслугаГрупповая$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю "$$УслугаПерсональная$$"			
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'		
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_1x0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_1x0' я ввожу текст "250,00"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_1x0'
	И пауза 1
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_2x0'
	И элемент формы с именем 'ПолеВидыОплатВводСуммыСтрока_1x0' стал равен "0"
	И элемент формы с именем 'ПолеВидыОплатВводСуммыСтрока_2x0' стал равен "500,00"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_2x0'
	И я нажимаю на кнопку с именем 'Оплатить'
		
Сценарий: Возврат настроек.
	Дано Я открываю навигационную ссылку "$$СсылкаНаЦену$$"
	И из выпадающего списка с именем 'ПорядокОкругления' я выбираю точное значение "0.01"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	