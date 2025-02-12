﻿#language: ru

@tree
@IgnoreOnCIMainBuild

Функционал: test

Был связанный тикет 529065

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Первоначальная настройка
	И я удаляю все переменные
	И Я создаю Мастера
	И Я создаю Услугу
	И Я создаю Услугу_2
	И Я создаю Клиента
	И Я генерирую СлучайноеЧисло
	И Я создаю даты


Сценарий: Настройка услуг и клиента
	И Остановка если была ошибка в прошлом сценарии
* Код 1
	И Я открываю навигационную ссылку "$$СсылкаУслуги$$"
	И я меняю значение переключателя с именем 'КодУслуги' на "№1 (недорогостоящие)"
	И в поле с именем '_Цена_0' я ввожу текст "250,25"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Код 2
	И Я открываю навигационную ссылку "$$СсылкаУслуги_2$$"
	И я меняю значение переключателя с именем 'КодУслуги' на "№2 (дорогостоящие)"
	И в поле с именем '_Цена_0' я ввожу текст "350,35"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

* Клиент дата
	И Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И в поле с именем 'ДатаРождения' я ввожу текст "02.02.2002"
	И в поле с именем 'ИНН' я ввожу текст "922117156722"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Сценарий: Провел визит
	И Остановка если была ошибка в прошлом сценарии
* Визит
	Дано Я открываю основную форму документа "Визит"
	И в поле с именем 'ИмяКонтрагента' я ввожу текст "$$Клиент$$"
	И из выпадающего списка с именем 'ИмяКонтрагента' я выбираю точное значение "$$Клиент$$"
	И в поле с именем 'ПолеФормы_Номенклатура_ТЧ_Запасы_0' я ввожу текст "$$Услуга$$"
	И из выпадающего списка с именем 'ПолеФормы_Номенклатура_ТЧ_Запасы_0' я выбираю по строке "$$Услуга$$"
	И в поле с именем 'НоваяСтрокаНоменклатура' я ввожу текст "$$Услуга_2$$"
	И из выпадающего списка с именем 'НоваяСтрокаНоменклатура' я выбираю по строке "$$Услуга_2$$"
	И в поле с именем 'ПолеФормы_Сотрудник_ТЧ_Запасы_0' я ввожу текст "$$Мастер$$"
	И из выпадающего списка с именем 'ПолеФормы_Сотрудник_ТЧ_Запасы_0' я выбираю по строке "$$Мастер$$"
	И в поле с именем 'ПолеФормы_Сотрудник_ТЧ_Запасы_1' я ввожу текст "$$Мастер$$"
	И из выпадающего списка с именем 'ПолеФормы_Сотрудник_ТЧ_Запасы_1' я выбираю по строке "$$Мастер$$"
	И я нажимаю на кнопку с именем 'Пришел'
	И я нажимаю на кнопку с именем 'Button0'
	И Я Оплитил документ
		
Сценарий: Создаю документ "СправкаВНалоговую_SPA"
	Дано Я открываю основную форму списка документа "СправкаВНалоговую_SPA"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю точное значение "$$Клиент$$ "
	И я нажимаю на кнопку с именем 'ТаблицаДокументовПродажиТаблицаЗадолженностейУстановитьСнятьГалочки'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаСохранить'
		
Сценарий: Проверка печатной формы_2024
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму списка документа "СправкаВНалоговую_SPA"
	И я нажимаю на кнопку с именем 'ФормаДокументаПечать'
	И в меню формы я выбираю 'Справка в налоговую (новая с 2024г.)'
	Дано Табличный документ "ТекущаяПечатнаяФорма" равен макету "Spravka2024" по шаблону

Сценарий: Проверка печатной формы_old_1
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму списка документа "СправкаВНалоговую_SPA"
	И я нажимаю на кнопку с именем 'ФормаДокументаПечать'
	И в меню формы я выбираю 'Справка в налоговую (код услуг 01 и 02 отдельно)'
	Дано Табличный документ "ТекущаяПечатнаяФорма" равен макету "Spravka_old_1" по шаблону

Сценарий: Проверка печатной формы_old_2
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму списка документа "СправкаВНалоговую_SPA"
	И я нажимаю на кнопку с именем 'ФормаДокументаПечать'
	И в меню формы я выбираю 'Справка в налоговую (код услуг 01 и 02 вместе)'
	Дано Табличный документ "ТекущаяПечатнаяФорма" равен макету "Spravka_old_2" по шаблону