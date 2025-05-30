﻿#language: ru

@tree

Функционал: Проверка модификатора ЧПУ - Изменение срока заморозок.

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Создание данных для тестирования модификатра - Изменение срока заморозок.
	И я удаляю все переменные
	И Я создаю Услуга_Персональная
	И Я создаю членство для проверки модификаторов.
	И Я создаю пакет услуг для проверки модификаторов.
	И Я создаю клиента
	И Я создаю модификатор для ЧПУ - Изменение срока заморозок.
//Добавление настроек по заморозкам пользователю.
	Дано я открываю основную форму списка справочника "Сотрудники"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "Админ"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 20 секунд
	И в таблице "Список" я перехожу к строке по шаблону:
		| 'ФИО'     |
		| '*Админ*' |
	И в таблице "Список" я выбираю текущую строку
	И В текущем окне я нажимаю кнопку командного интерфейса "Настройки прав и доступа"
	И в таблице 'ДеревоОбщихНастроек' я перехожу к строке:
		| "Настройка"               |
		| "Членство (пакеты услуг)" |
	И в таблице 'ДеревоОбщихНастроек' я устанавливаю флаг с именем 'ДеревоОбщихНастроекЗначение'
	И в таблице 'ДеревоОбщихНастроек' я завершаю редактирование строки
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Сценарий: Проверка данных.
	И Остановка если была ошибка в прошлом сценарии

Сценарий: Проверка модификатора "Изменение срока заморозок" с членством.
//Создание продажи членства.
//Фиксированный модификатор.
	И Я запоминаю значение выражения 'Формат(ТекущаяДата()-172800, "ДФ=\'дд.ММ.гггг\'")' в переменную "$$ДатаАктЧПУ$$"
	И Я запоминаю значение выражения 'Формат(ТекущаяДата()+259200, "ДФ=\'дд.ММ.гггг\'")' в переменную "$$ЗамороженДО$$"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=\'дд.ММ.гггг\'")' в переменную "$$Сегодня$$"
	Дано я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$ЧленствоМ$$"	
//	И в таблице '_ПодборНоменклатур' я перехожу к строке:
//		| "Номенклатура"  |
//		| "$$ЧленствоМ$$" |
//	И в таблице '_ПодборНоменклатур' я выбираю текущую строку
	И я жду, что в таблице "Запасы" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации'
	И я выбираю пункт контекстного меню с именем 'ЗапасыКнопкаИзменить1' на элементе формы с именем 'Запасы'
	И в таблице 'Запасы' в поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации' я ввожу текст "$$ДатаАктЧПУ$$"
	И Я Оплатил документ
//Открытие ЧПУ и добавление заморозок.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Членства"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура"  |
		| "$$ЧленствоМ$$" |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ДокументЧленстваПакетУслугОперацииУвеличитьЗаморозки'
	И из выпадающего списка с именем 'Модификатор' я выбираю точное значение "$$ИзмСрокаЗамФикс$$ (Цена: 1 000 руб.)"
	И я нажимаю на кнопку с именем '_Дополнительно'
	И в поле с именем 'Дата' я ввожу текст "$$ДатаАктЧПУ$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "5"
	И я нажимаю на кнопку с именем 'ДокументЧленствоПакетУслугОперацииЗаморозить'
	И в поле с именем 'ЗаморозкаДатаС' я ввожу текст "$$ДатаАктЧПУ$$"
	И в поле с именем 'ЗаморозкаСрок' я ввожу текст "5"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'ПровестиИЗакрыть'		
	И я жду открытия окна "Членство \"$$ЧленствоМ$$\" * от $$Сегодня$$ *:*" в течение 20 секунд
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "0"	
	И элемент формы с именем 'ДекорацияИнформацияСтатусПредставление' стал равен "Заморожен до $$ЗамороженДО$$"
//Проверка добавления Доп.дней после заморозки.
	Дано Я открываю основную форму списка регистра накопления "ЧленстваПакетыУслуг"
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюНайти' на элементе формы с именем 'Список'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Основание"
	И я нажимаю кнопку выбора у поля с именем 'Pattern'
	И в таблице '' я перехожу к строке:
		| ""                      |
		| "Членство, пакет услуг" |
	И я нажимаю на кнопку "ОК"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ЧленствоМ$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'Find'
	И в таблице 'Список' я активизирую поле с именем 'Период'

	И таблица 'Список' содержит строки по шаблону:
		| 'Период'               | 'Основание'                                      | 'Регистратор'                                | 'Сумма' | 'Дней заморозок' | 'Дней дополнительно' |
		| '$$ДатаАктЧПУ$$ *:*:*' | 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (заморозка) * от * * ' | ''      | ''               | '5'                  |
	И я закрываю все окна клиентского приложения
//Разморозка.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Членства"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура"  |
		| "$$ЧленствоМ$$" |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ДокументЧленствоПакетУслугОперацииРазморозить'
	И я нажимаю на кнопку с именем 'ПровестиИЗакрыть'
	И я жду открытия окна "Членство \"$$ЧленствоМ$$\" * от $$Сегодня$$ *:*" в течение 20 секунд
	И я активизирую окно "Членство \"$$ЧленствоМ$$\" * от $$Сегодня$$ *:*"
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "3"		
//Проверка добавления Доп.дней после РАЗМОРОЗКИ.
	Дано Я открываю основную форму списка регистра накопления "ЧленстваПакетыУслуг"
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюНайти' на элементе формы с именем 'Список'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Основание"
	И я нажимаю кнопку выбора у поля с именем 'Pattern'
	И в таблице '' я перехожу к строке:
		| ""                      |
		| "Членство, пакет услуг" |
	И я нажимаю на кнопку "ОК"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ЧленствоМ$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'Find'
	И таблица 'Список' содержит строки по шаблону:
		| 'Основание'                                      | 'Регистратор'                                                       | 'Сумма'    | 'Дней заморозок' | 'Дней дополнительно' |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (заморозка) * от $$Сегодня$$ *:* '            | ''         | ''               | '5'                  |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (заморозка) * от $$Сегодня$$ *:* '            | ''         | '5'              | ''                   |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* '                    | '2 000,00' | ''               | ''                   |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Изменение условий членства, пакета услуг * от $$ДатаАктЧПУ$$ *:* ' | ''         | '5'              | ''                   |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* '                    | ''         | ''               | '1'                  |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* '                    | ''         | ''               | '1'                  |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (разморозка) * от $$Сегодня$$ *:* '           | ''         | ''               | '-3'                 |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (разморозка) * от $$Сегодня$$ *:* '           | ''         | '-3'             | ''                   |
//Продажа заморозок ПП.
	И я закрываю все окна клиентского приложения
	И я удаляю переменную '$$Клиент$$'
	И я удаляю переменную '$$СсылкаКлиента$$'
	И Я создаю клиента		
	Дано я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$ЧленствоМ$$"	
//	И в таблице '_ПодборНоменклатур' я перехожу к строке:
//		| "Номенклатура"  |
//		| "$$ЧленствоМ$$" |
//	И в таблице '_ПодборНоменклатур' я выбираю текущую строку
	И я жду, что в таблице "Запасы" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации'
	И я выбираю пункт контекстного меню с именем 'ЗапасыКнопкаИзменить1' на элементе формы с именем 'Запасы'
	И в таблице 'Запасы' в поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации' я ввожу текст "$$ДатаАктЧПУ$$"
	И Я Оплатил документ			
//Открытие ЧПУ и добавление заморозок.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Членства"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура"  |
		| "$$ЧленствоМ$$" |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ДокументЧленстваПакетУслугОперацииУвеличитьЗаморозки'
	И из выпадающего списка с именем 'Модификатор' я выбираю точное значение "$$ИзмСрокаЗамПП$$ (Цена: 200 руб.)"
	И в поле с именем 'Количество' я ввожу текст "5"
	И я нажимаю на кнопку с именем '_Дополнительно'
	И в поле с именем 'Дата' я ввожу текст "$$ДатаАктЧПУ$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "5"
	И я нажимаю на кнопку с именем 'ДокументЧленствоПакетУслугОперацииЗаморозить'
	И в поле с именем 'ЗаморозкаДатаС' я ввожу текст "$$ДатаАктЧПУ$$"
	И в поле с именем 'ЗаморозкаСрок' я ввожу текст "5"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'ПровестиИЗакрыть'		
	И я жду открытия окна "Членство \"$$ЧленствоМ$$\" * от $$Сегодня$$ *:*" в течение 20 секунд
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "0"	
	И элемент формы с именем 'ДекорацияИнформацияСтатусПредставление' стал равен "Заморожен до $$ЗамороженДО$$"
//Проверка добавления Доп.дней после заморозки.
	Дано Я открываю основную форму списка регистра накопления "ЧленстваПакетыУслуг"
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюНайти' на элементе формы с именем 'Список'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Основание"
	И я нажимаю кнопку выбора у поля с именем 'Pattern'
	И в таблице '' я перехожу к строке:
		| ""                      |
		| "Членство, пакет услуг" |
	И я нажимаю на кнопку "ОК"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ЧленствоМ$$"
	И в таблице 'Список' я перехожу к строке:
		| "Клиент"     |
		| "$$Клиент$$" |	
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'Find'
	И таблица 'Список' содержит строки по шаблону:
		| 'Период'               | 'Основание'                                      | 'Регистратор'                                | 'Сумма' | 'Дней заморозок' | 'Дней дополнительно' |
		| '$$ДатаАктЧПУ$$ *:*:*' | 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (заморозка) * от * * ' | ''      | ''               | '5'                  |
	И я закрываю все окна клиентского приложения	
//Разморозка.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Членства"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура"  |
		| "$$ЧленствоМ$$" |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ДокументЧленствоПакетУслугОперацииРазморозить'
	И я нажимаю на кнопку с именем 'ПровестиИЗакрыть'
	И я жду открытия окна "Членство \"$$ЧленствоМ$$\" * от $$Сегодня$$ *:*" в течение 20 секунд
	И я активизирую окно "Членство \"$$ЧленствоМ$$\" * от $$Сегодня$$ *:*"
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "3"		
//Проверка добавления Доп.дней после РАЗМОРОЗКИ.
	Дано Я открываю основную форму списка регистра накопления "ЧленстваПакетыУслуг"
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюНайти' на элементе формы с именем 'Список'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Основание"
	И я нажимаю кнопку выбора у поля с именем 'Pattern'
	И в таблице '' я перехожу к строке:
		| ""                      |
		| "Членство, пакет услуг" |
	И я нажимаю на кнопку "ОК"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ЧленствоМ$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'Find'
	И таблица 'Список' содержит строки по шаблону:
		| 'Основание'                                      | 'Регистратор'                                                       | 'Сумма'    | 'Дней заморозок' | 'Дней дополнительно' |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (заморозка) * от $$Сегодня$$ *:* '            | ''         | ''               | '5'                  |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (заморозка) * от $$Сегодня$$ *:* '            | ''         | '5'              | ''                   |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* '                    | '2 000,00' | ''               | ''                   |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Изменение условий членства, пакета услуг * от $$ДатаАктЧПУ$$ *:* ' | ''         | '5'              | ''                   |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* '                    | ''         | ''               | '1'                  |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* '                    | ''         | ''               | '1'                  |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (разморозка) * от $$Сегодня$$ *:* '           | ''         | ''               | '-3'                 |
		| 'Членство "$$ЧленствоМ$$" * от $$Сегодня$$ *:* ' | 'Операция с членством (разморозка) * от $$Сегодня$$ *:* '           | ''         | '-3'             | ''                   |

Сценарий: Проверка модификатора "Изменение срока заморозок" с пакетом услуг.
//Создание продажи пакета услуг.
//Фиксированный модификатор.
	И я закрываю все окна клиентского приложения
	И я удаляю переменную '$$Клиент$$'
	И я удаляю переменную '$$СсылкаКлиента$$'
	И Я создаю клиента		
	Дано я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$ПакетУМ$$"	
//	И в таблице '_ПодборНоменклатур' я перехожу к строке:
//		| "Номенклатура"  |
//		| "$$ПакетУМ$$" |
//	И в таблице '_ПодборНоменклатур' я выбираю текущую строку
	И я жду, что в таблице "Запасы" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации'
	И я выбираю пункт контекстного меню с именем 'ЗапасыКнопкаИзменить1' на элементе формы с именем 'Запасы'
	И в таблице 'Запасы' в поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации' я ввожу текст "$$ДатаАктЧПУ$$"
	И Я Оплатил документ
//Открытие ЧПУ и добавление заморозок.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Пакеты"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура" |
		| "$$ПакетУМ$$"  |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ДокументЧленстваПакетУслугОперацииУвеличитьЗаморозки'
	И из выпадающего списка с именем 'Модификатор' я выбираю точное значение "$$ИзмСрокаЗамФикс$$ (Цена: 1 000 руб.)"
	И я нажимаю на кнопку с именем '_Дополнительно'
	И в поле с именем 'Дата' я ввожу текст "$$ДатаАктЧПУ$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "5"
	И я нажимаю на кнопку с именем 'ДокументЧленствоПакетУслугОперацииЗаморозить'
	И в поле с именем 'ЗаморозкаДатаС' я ввожу текст "$$ДатаАктЧПУ$$"
	И в поле с именем 'ЗаморозкаСрок' я ввожу текст "5"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'ПровестиИЗакрыть'		
	И я жду открытия окна "Пакет услуг \"$$ПакетУМ$$\" * от $$Сегодня$$ *:*" в течение 20 секунд
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "0"	
	И элемент формы с именем 'ДекорацияИнформацияСтатусПредставление' стал равен "Заморожен до $$ЗамороженДО$$"
//Проверка добавления Доп.дней после заморозки.
	Дано Я открываю основную форму списка регистра накопления "ЧленстваПакетыУслуг"
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюНайти' на элементе формы с именем 'Список'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Основание"
	И я нажимаю кнопку выбора у поля с именем 'Pattern'
	И в таблице '' я перехожу к строке:
		| ""                      |
		| "Членство, пакет услуг" |
	И я нажимаю на кнопку "ОК"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ПакетУМ$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'Find'
	И в таблице 'Список' я активизирую поле с именем 'Период'
	И таблица 'Список' содержит строки по шаблону:
		| 'Период'               | 'Основание'                                          | 'Регистратор'                                                | 'Дней дополнительно' |
		| '$$ДатаАктЧПУ$$ *:*:*' | 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (заморозка) * от $$Сегодня$$ *:* ' | '5'                  |
//Разморозка.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Пакеты"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура" |
		| "$$ПакетУМ$$"  |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ДокументЧленствоПакетУслугОперацииРазморозить'
	И я нажимаю на кнопку с именем 'ПровестиИЗакрыть'
	И я жду открытия окна "Пакет услуг \"$$ПакетУМ$$\" * от $$Сегодня$$ *:*" в течение 20 секунд
	И я активизирую окно "Пакет услуг \"$$ПакетУМ$$\" * от $$Сегодня$$ *:*"	
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "3"		
//Проверка добавления Доп.дней после РАЗМОРОЗКИ.
	Дано Я открываю основную форму списка регистра накопления "ЧленстваПакетыУслуг"
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюНайти' на элементе формы с именем 'Список'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Основание"
	И я нажимаю кнопку выбора у поля с именем 'Pattern'
	И в таблице '' я перехожу к строке:
		| ""                      |
		| "Членство, пакет услуг" |
	И я нажимаю на кнопку "ОК"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ПакетУМ$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'Find'
	И таблица 'Список' содержит строки по шаблону:	
		| 'Основание'                                       | 'Регистратор'                                                       | 'Сумма'    | 'Дней заморозок' | 'Дней дополнительно' |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (заморозка) * от $$Сегодня$$ *:* '        | ''         | ''               | '5'                  |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (заморозка) * от $$Сегодня$$ *:* '        | ''         | '5'              | ''                   |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* '                   | '2 000,00' | ''               | ''                   |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Изменение условий членства, пакета услуг * от $$ДатаАктЧПУ$$ *:* ' | ''         | '5'              | ''                   |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* '                   | ''         | ''               | '1'                  |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* '                   | ''         | ''               | '1'                  |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (разморозка) * от $$Сегодня$$ *:* '       | ''         | ''               | '-3'                 |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (разморозка) * от $$Сегодня$$ *:* '       | ''         | '-3'             | ''                   |
//Продажа заморозок ПП.
	И я закрываю все окна клиентского приложения
	И я удаляю переменную '$$Клиент$$'
	И я удаляю переменную '$$СсылкаКлиента$$'
	И Я создаю клиента		
	Дано я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$ПакетУМ$$"	
//	И в таблице '_ПодборНоменклатур' я перехожу к строке:
//		| "Номенклатура" |
//		| "$$ПакетУМ$$"  |
//	И в таблице '_ПодборНоменклатур' я выбираю текущую строку
	И я жду, что в таблице "Запасы" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации'
	И я выбираю пункт контекстного меню с именем 'ЗапасыКнопкаИзменить1' на элементе формы с именем 'Запасы'
	И в таблице 'Запасы' в поле с именем 'ЗапасыЧленствоПакетУслугДатаАктивации' я ввожу текст "$$ДатаАктЧПУ$$"
	И Я Оплатил документ			
//Открытие ЧПУ и добавление заморозок.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Пакеты"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура" |
		| "$$ПакетУМ$$"  |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ДокументЧленстваПакетУслугОперацииУвеличитьЗаморозки'
	И из выпадающего списка с именем 'Модификатор' я выбираю точное значение "$$ИзмСрокаЗамПП$$ (Цена: 200 руб.)"
	И в поле с именем 'Количество' я ввожу текст "5"
	И я нажимаю на кнопку с именем '_Дополнительно'
	И в поле с именем 'Дата' я ввожу текст "$$ДатаАктЧПУ$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "5"
	И я нажимаю на кнопку с именем 'ДокументЧленствоПакетУслугОперацииЗаморозить'
	И в поле с именем 'ЗаморозкаДатаС' я ввожу текст "$$ДатаАктЧПУ$$"
	И в поле с именем 'ЗаморозкаСрок' я ввожу текст "5"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'ПровестиИЗакрыть'
	И я жду открытия окна "Пакет услуг \"$$ПакетУМ$$\" * от $$Сегодня$$ *:*" в течение 20 секунд		
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "0"	
	И элемент формы с именем 'ДекорацияИнформацияСтатусПредставление' стал равен "Заморожен до $$ЗамороженДО$$"
//Проверка добавления Доп.дней после заморозки.
	Дано Я открываю основную форму списка регистра накопления "ЧленстваПакетыУслуг"
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюНайти' на элементе формы с именем 'Список'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Основание"
	И я нажимаю кнопку выбора у поля с именем 'Pattern'
	И в таблице '' я перехожу к строке:
		| ""                      |
		| "Членство, пакет услуг" |
	И я нажимаю на кнопку "ОК"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ПакетУМ$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я перехожу к строке:
		| "Клиент"     |
		| "$$Клиент$$" |	
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'Find'
	И таблица 'Список' содержит строки по шаблону:
		| 'Период'               | 'Основание'                                       | 'Регистратор'                                                | 'Дней дополнительно' |
		| '$$ДатаАктЧПУ$$ *:*:*' | 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (заморозка) * от $$Сегодня$$ *:* ' | '5'                  |
	И я закрываю все окна клиентского приложения	
//Разморозка.
	Дано Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Пакеты"
	И в таблице 'Список' я перехожу к строке:
		| "Номенклатура" |
		| "$$ПакетУМ$$"  |
	И в таблице 'Список' я выбираю текущую строку	
	И я нажимаю на кнопку с именем 'ДокументЧленствоПакетУслугОперацииРазморозить'
	И я нажимаю на кнопку с именем 'ПровестиИЗакрыть'
	И я жду открытия окна "Пакет услуг \"$$ПакетУМ$$\" * от $$Сегодня$$ *:*" в течение 20 секунд
	И я активизирую окно "Пакет услуг \"$$ПакетУМ$$\" * от $$Сегодня$$ *:*"
	И элемент формы с именем 'ЗаморозкиОстаток' стал равен "3"		
//Проверка добавления Доп.дней после РАЗМОРОЗКИ.
	Дано Я открываю основную форму списка регистра накопления "ЧленстваПакетыУслуг"
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюНайти' на элементе формы с именем 'Список'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Основание"
	И я нажимаю кнопку выбора у поля с именем 'Pattern'
	И в таблице '' я перехожу к строке:
		| ""                      |
		| "Членство, пакет услуг" |
	И я нажимаю на кнопку "ОК"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$ПакетУМ$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я перехожу к строке
		| 'Клиент'     |
		| '$$Клиент$$' |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'Find'
	И таблица 'Список' содержит строки по шаблону:	
		| 'Основание'                                       | 'Регистратор'                                                       | 'Сумма'    | 'Дней заморозок' | 'Дней дополнительно' |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (заморозка) * от $$Сегодня$$ *:* '        | ''         | ''               | '5'                  |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (заморозка) * от $$Сегодня$$ *:* '        | ''         | '5'              | ''                   |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* '                   | '2 000,00' | ''               | ''                   |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Изменение условий членства, пакета услуг * от $$ДатаАктЧПУ$$ *:* ' | ''         | '5'              | ''                   |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* '                   | ''         | ''               | '1'                  |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* '                   | ''         | ''               | '1'                  |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (разморозка) * от $$Сегодня$$ *:* '       | ''         | ''               | '-3'                 |
		| 'Пакет услуг "$$ПакетУМ$$" * от $$Сегодня$$ *:* ' | 'Операция с пакетом услуг (разморозка) * от $$Сегодня$$ *:* '       | ''         | '-3'             | ''                   |