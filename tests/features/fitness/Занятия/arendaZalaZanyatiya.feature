﻿#language: ru

@tree

Функционал: Проверка услуги аренда помещения. 

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения
	
Сценарий: 01. Я создаю данные для проверки занятий.
	И я удаляю все переменные
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(),"ДЛФ=Д")' в переменную "$$Сегодня$$"
	И Я создаю Помещение
	И Я создаю Услуга_АрендаЗала для занятия.
	И Я тренера для проверки занятий.
	И Я создаю клиента

Сценарий: 02. Проверка созданных данных.
	И Остановка если была ошибка в прошлом сценарии

Сценарий: 03. Проверка настройки аренды зала "Считать оказанной "В продаже/В занятие"".
//Добавление настройки.	
	Дано Я открываю навигационную ссылку "$$СсылкаУслугаАренды$$"
	И я меняю значение переключателя с именем 'СписыватьПриПродажеУслуг' на "При продаже"
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
//Создание продажи.
	И Я создаю продажу для аренды зала.
//Проверка списания.
	Дано Я открываю основную форму списка регистра накопления "ОказаниеУслуг"
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 20 секунд
	И таблица 'Список' содержит строки по шаблону:
		| 'Регистратор'       | 'Документ продажи'  | 'Услуга, сегмент'                            | 'Количество' |
		| 'Продажа * от * * ' | 'Продажа * от * * ' | '$$УслугаАрендаЗала$$, $$УслугаАрендаЗала$$' | '1,000'      |
//Смена настройки на оказание в занятии.	
	Дано я открываю навигационную ссылку "$$СсылкаУслугаАренды$$"
	И я меняю значение переключателя с именем 'СписыватьПриПродажеУслуг' на "В занятии"
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
//Создание аренды зала.
	И Я создаю аренду зала для проверки.
//Проверка списания.
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму списка регистра накопления "ОказаниеУслуг"
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 20 секунд
	И я нажимаю на кнопку с именем 'ФормаОбновить'	
	И таблица 'Список' содержит строки по шаблону:
		| 'Регистратор'                                | 'Занятие'                                                                          | 'Услуга, сегмент'                                            |
		| 'Запись на занятие * от $$Сегодня$$ 0:00:00' | 'Аренда зала: $$Сегодня$$ 00:00, $$УслугаАрендаЗала$$, Фитнес плюс, * (выполнено)' | '$$УслугаАрендаЗала$$, $$УслугаАрендаЗала$$, Розничная цена' |
	
			
Сценарий: 04. Проверка настройки аренды зала "Требуется основание для записи".	
//Добавление настройки.
	Дано Я открываю навигационную ссылку "$$СсылкаУслугаАренды$$"
	И я изменяю флаг с именем 'ТребуетсяОснованиеДляЗаписи'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
//Создание аренды зала.
	И Я создаю аренду зала для проверки.

Сценарий: 05. Проверка настройки аренды зала "Использовать ассистента".
//Добавление настройки.
	Дано я открываю навигационную ссылку "$$СсылкаУслугаАренды$$"
	И я снимаю флаг с именем 'ТребуетсяОснованиеДляЗаписи'
	И я устанавливаю флаг с именем 'ИспользоватьАссистента'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
//Создание ассистента.
	И Я создаю второго тренера ассистента_ЗАНЯТИЯ.
//Создание аренды зала.
	И Я создаю аренду зала для проверки.
//Проверка писания.
	Дано Я открываю основную форму списка регистра накопления "ОказаниеУслуг"
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я перехожу к следующему реквизиту
	И таблица 'Список' содержит строки по шаблону:
		| "Ассистент"   | "Занятие"                                                | "Регистратор"                | "Услуга, сегмент"                                            |
		| "$$Тренер2$$" | "Аренда зала: * *, $$УслугаАрендаЗала$$, Фитнес плюс, *" | "Запись на занятие * от * *" | "$$УслугаАрендаЗала$$, $$УслугаАрендаЗала$$, Розничная цена" |

Сценарий: 06. Проверка настройки услуги аренды зала "Отметка прибытия авто/ручная".		
//Отключение настройки.
	Дано Я открываю навигационную ссылку "$$СсылкаУслугаАренды$$"		
	И я снимаю флаг с именем 'ИспользоватьАссистента'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'	
//Создание аренды зала.
	И Я создаю аренду зала для автоматической/ручной отметки прибытия.
//Вход для автоматической отметки прибытия.
	Дано Я открываю основную форму обработки "РабочийСтол"
	И в поле с именем 'ТекущийКлиент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'ТекущийКлиент' я выбираю точное значение "$$Клиент$$"
	И я нажимаю на кнопку с именем 'КнопкаВыполнитьВходВыходКлиента'
//Проверка.
	И я закрываю все окна клиентского приложения
	Дано я открываю основную форму списка документа 'ЗаписьНаЗанятие'
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я перехожу к следующему реквизиту
	И таблица 'Список' содержит строки по шаблону:
		| "Дата"                              | "Занятие"                                                                    | "Статус прибытия" |
		| "* $$СегодняДляЗанятияБезНуля$$:00" | "Аренда зала: * $$СегодняДляЗанятия$$, $$УслугаАрендаЗала$$, Фитнес плюс, *" | "Прибыл"          |
//Включение ручной отметки прибытия.
//	И я закрываю все окна клиентского приложения
//	Дано Я открываю навигационную ссылку "$$СсылкаУслугаАренды$$"
//	И я меняю значение переключателя с именем 'ТипОтметкиПрибытияНаЗанятие' на "Вручную  "	
//	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
//	И Я создаю аренду зала для автоматической/ручной отметки прибытия.
//
//	И я делаю 2 раз
//		Дано Я открываю основную форму обработки "РабочийСтол"
//		И в поле с именем 'ТекущийКлиент' я ввожу значение выражения "$$Клиент$$"
//		И из выпадающего списка с именем 'ТекущийКлиент' я выбираю точное значение "$$Клиент$$"
//		И я нажимаю на кнопку с именем 'КнопкаВыполнитьВходВыходКлиента'
//	И я закрываю все окна клиентского приложения
//	Дано я открываю основную форму списка документа 'ЗаписьНаЗанятие'
//	И таблица 'Список' содержит строки по шаблону:
//		| "Дата"                              | "Занятие"                                                                    | "Клиент"                 | "Статус прибытия" |
//		| "* $$СегодняДляЗанятияБезНуля$$:00" | "Аренда зала: * $$СегодняДляЗанятия$$, $$УслугаАрендаЗала$$, Фитнес плюс, *" | "$$Клиент$$, $$Клиент$$" | "Не прибыл"       |


Сценарий: 07. Проверка смены в аренде зала услуги, помещения, переноса по времени.
//Создание данных для смены в аренде.
	И Я создаю Помещение2_ЗАНЯТИЕ
	И Я создаю Услуга_АрендаЗала2 для занятия.
//Создание аренды зала.
	И Я создаю аренду зала для проверки смены тренера, услуги, переноса по времени.
//Смена данных.
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()+6200, "ДФ=\'ЧЧ:мм\'")' в переменную "$$СегодняДляЗанятия1$$"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=\'дд.ММ.гггг\'")' в переменную "$$ДатаПереноса$$"
	Дано Я открываю навигационную ссылку "$$ЗанятиеСмена$$"
	И я нажимаю кнопку очистить у поля с именем 'Помещение'
	И в поле с именем 'Номенклатура' я ввожу значение выражения "$$УслугаАрендаЗала2$$"
	И из выпадающего списка с именем 'Номенклатура' я выбираю точное значение "$$УслугаАрендаЗала2$$"
	И в поле с именем 'Помещение' я ввожу значение выражения "$$Помещение2$$"
	И из выпадающего списка с именем 'Помещение' я выбираю "$$Помещение2$$"
	И в поле с именем 'ДатаВремяНачала' я ввожу значение выражения "$$СегодняДляЗанятия1$$"
	И я нажимаю кнопку выбора у поля с именем 'ПолеОснованияОплаты_0'
	И из выпадающего списка с именем 'ПолеОснованияОплаты_0' я выбираю точное значение "Продать услугу: \"$$УслугаАрендаЗала2$$\", 1 000 ₽"
	И я нажимаю на кнопку с именем 'КнопкаОплатитьОснование_0'
	И я активизирую окно "Оплата"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я проверяю ЗакрытиеСмены
	И Я закрываю окно "Исходные данные чека"
	И в таблице 'СоставЗанятия' я перехожу к строке:
		| "Клиент"     |
		| "$$Клиент$$" |
	И в таблице 'СоставЗанятия' я активизирую поле с именем 'СоставЗанятияСтатусПрибытия'
	И в таблице 'СоставЗанятия' я выбираю текущую строку
	И в таблице 'СоставЗанятия' из выпадающего списка с именем 'СоставЗанятияСтатусПрибытия' я выбираю точное значение "Прибыл"
	И я меняю значение переключателя с именем 'СтатусЗанятия' на "Выполнено"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	Если открылось окно "1С:Предприятие" Тогда
		И я нажимаю на кнопку с именем 'Button0'
//Проверка списания.
	Дано Я открываю основную форму списка регистра накопления "ОказаниеУслуг"
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я перехожу к следующему реквизиту
	И таблица 'Список' содержит строки по шаблону:
		| "Занятие"                                                                      | "Регистратор"                                        | "Сумма"    | "Услуга, сегмент"                                              |
		| "Аренда зала: * $$СегодняДляЗанятия1$$, $$УслугаАрендаЗала2$$, Фитнес плюс, *" | "Запись на занятие * от * $$СегодняДляЗанятия1$$:00" | "1 000,00" | "$$УслугаАрендаЗала2$$, $$УслугаАрендаЗала2$$, Розничная цена" |
			
Сценарий: 08. Проверка списания услуги аренды зала с настройками Если клиент:"Записан и не отменил" и "Записан, прибыл и подтвердил".
//Смена настройки.	
	Дано Я открываю навигационную ссылку "$$СсылкаУслугаАренды$$"
	И из выпадающего списка с именем 'УслугаТипСписанияЗанятием' я выбираю точное значение "Записан и не отменил"
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'	
//Создание аренды с настройкой 'Записан и не отменил'
	И Я создаю аренду зала для проверки настройки Если клиент:"Записан и не отменил" и "Записан, прибыл и подтвердил".
	Дано я открываю основную форму списка документа 'ЗаписьНаЗанятие'
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я перехожу к следующему реквизиту
	И в таблице 'Список' я перехожу к строке по шаблону:
		| "Дата"                              | "Занятие"                                                                    | "Статус прибытия" |
		| "* $$СегодняДляЗанятияБезНуля$$:00" | "Аренда зала: * $$СегодняДляЗанятия$$, $$УслугаАрендаЗала$$, Фитнес плюс, *" | "Прибыл"          |
	И в таблице 'Список' я выбираю текущую строку
	И элемент формы с именем 'СписаниеЗанятияРазрешено' стал равен "Да"
//Подтверждения нет на форме аренды зала поэтому и толку от проверки "Записан, прибыл и подтвердил" - Нет.

Сценарий: 09. Проверка отмены аренды зала.
	Дано Я открываю навигационную ссылку "$$СсылкаУслугаАренды$$"
	И из выпадающего списка с именем 'УслугаТипСписанияЗанятием' я выбираю точное значение "Записан и прибыл"
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И Я запоминаю случайное число в переменную "ОтказКлиента"
	Дано я запоминаю значение выражения '"ОтказКлиента" + Формат($ОтказКлиента$, "ЧГ=0")' в переменную "$$ОтказКлиента$$"
	Дано я открываю основную форму справочника 'ПричиныОтмен'
	И я активизирую окно "Причина отмены занятия (создание)"
	И в поле с именем 'Наименование' я ввожу значение выражения "$$ОтказКлиента$$"
	И из выпадающего списка с именем 'ТипЗанятия' я выбираю точное значение "Аренда зала"
	И я меняю значение переключателя с именем 'ИнициаторОтмены' на "Клиент"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И Я запоминаю случайное число в переменную "ОтказКлуба"
	Дано я запоминаю значение выражения '"ОтказКлуба" + Формат($ОтказКлуба$, "ЧГ=0")' в переменную "$$ОтказКлуба$$"
	Дано я открываю основную форму справочника 'ПричиныОтмен'
	И я активизирую окно "Причина отмены занятия (создание)"
	И в поле с именем 'Наименование' я ввожу значение выражения "$$ОтказКлуба$$"
	И из выпадающего списка с именем 'ТипЗанятия' я выбираю точное значение "Аренда зала"
	И я меняю значение переключателя с именем 'ИнициаторОтмены' на "Клуб"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Создание занятия	
	Дано я открываю основную форму списка документа 'Занятие'
	И я нажимаю на кнопку с именем 'СписокСоздатьАрендуЗала'
	И в поле с именем 'Номенклатура' я ввожу значение выражения "$$УслугаАрендаЗала$$"
	И из выпадающего списка с именем 'Номенклатура' я выбираю точное значение "$$УслугаАрендаЗала$$"
	И я нажимаю на кнопку с именем 'Button0'		
	И в поле с именем 'Помещение' я ввожу значение выражения "$$Помещение$$"
	И из выпадающего списка с именем 'Помещение' я выбираю "$$Помещение$$"
	И в поле с именем 'ДатаВремяНачала' я ввожу значение выражения "$$СегодняДляЗанятия$$"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"
	И я нажимаю кнопку выбора у поля с именем 'ПолеОснованияОплаты_0'
	И из выпадающего списка с именем 'ПолеОснованияОплаты_0' я выбираю точное значение "Продать услугу: \"$$УслугаАрендаЗала$$\", 1 000 ₽"
	И я нажимаю на кнопку с именем 'КнопкаОплатитьОснование_0'
	И я активизирую окно "Оплата"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я проверяю ЗакрытиеСмены
	И Я закрываю окно "Исходные данные чека"
	И я нажимаю на кнопку с именем 'ФормаПровести'
	И я меняю значение переключателя с именем 'СтатусЗанятия' на "Отменено"
	И я нажимаю на кнопку с именем 'Button0'
	И в таблице 'Список' я перехожу к строке:
		| "Инициатор" | "Наименование"     |
		| "Клиент"    | "$$ОтказКлиента$$" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаПровести'
//Проверка отмены.
	Дано я открываю основную форму списка документа 'ЗаписьНаЗанятие'
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я перехожу к следующему реквизиту	
	И в таблице 'Список' я перехожу к строке по шаблону:
		| "Дата"                              | "Занятие"                                                                    | "Основание оплаты" | "Статус прибытия" |
		| "* $$СегодняДляЗанятияБезНуля$$:00" | "Аренда зала: * $$СегодняДляЗанятия$$, $$УслугаАрендаЗала$$, Фитнес плюс, *" | "Продажа * от * "  | "Отменил"         |
	И в таблице 'Список' я выбираю текущую строку
	И элемент формы с именем 'ПричинаОтмены' стал равен "$$ОтказКлиента$$"
	И элемент формы с именем 'СтатусПрибытия' стал равен "2"
//Отказ от клуба.
	И я закрываю все окна клиентского приложения
	И я удаляю переменную '$$СегодняДляЗанятия$$'
	И я удаляю переменную "$$СегодняДляЗанятияБезНуля$$"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=\'ЧЧ:мм\'")' в переменную "$$СегодняДляЗанятия$$"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=\'Ч:мм\'")' в переменную "$$СегодняДляЗанятияБезНуля$$"
	Дано я открываю основную форму списка документа 'Занятие'
	И я нажимаю на кнопку с именем 'СписокСоздатьАрендуЗала'
	И в поле с именем 'Номенклатура' я ввожу значение выражения "$$УслугаАрендаЗала$$"
	И из выпадающего списка с именем 'Номенклатура' я выбираю точное значение "$$УслугаАрендаЗала$$"
	И я нажимаю на кнопку с именем 'Button0'		
	И в поле с именем 'Помещение' я ввожу значение выражения "$$Помещение$$"
	И из выпадающего списка с именем 'Помещение' я выбираю "$$Помещение$$"
	И в поле с именем 'ДатаВремяНачала' я ввожу значение выражения "$$СегодняДляЗанятия$$"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ФормаПровести'
	И я меняю значение переключателя с именем 'СтатусЗанятия' на "Отменено"
	И я нажимаю на кнопку с именем 'Button0'
	И в таблице 'Список' я перехожу к строке:
		| "Инициатор" | "Наименование"   |
		| "Клуб"      | "$$ОтказКлуба$$" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаПровести'	
//Проверка отмены.
	Дано я открываю основную форму списка документа 'ЗаписьНаЗанятие'
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я перехожу к следующему реквизиту
	И в таблице 'Список' я перехожу к строке по шаблону:
		| "Дата"                              | "Занятие"                                                                    | "Основание оплаты" | "Статус прибытия" |
		| "* $$СегодняДляЗанятияБезНуля$$:00" | "Аренда зала: * $$СегодняДляЗанятия$$, $$УслугаАрендаЗала$$, Фитнес плюс, *" | "Продажа * от * "  | "Отменил"         |
	И в таблице 'Список' я выбираю текущую строку
	И элемент формы с именем 'СписаниеЗанятияРазрешено' стал равен "Нет"
	И элемент формы с именем 'СписаниеПодтвержденоКлиентом' стал равен "Нет"
	И элемент формы с именем 'СтатусПрибытия' стал равен "2"

Сценарий: 10. Проверка списания услуги аренды зала с помощью отмены занятия со штрафом.
//Создание отказа со штрафом.
	И я удаляю переменную '$$СегодняДляЗанятия$$'
	И я удаляю переменную '$$СегодняДляЗанятияБезНуля$$'
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()-3600, "ДФ=\'ЧЧ:мм\'")' в переменную "$$СегодняДляЗанятия$$"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()-3600, "ДФ=\'Ч:мм\'")' в переменную "$$СегодняДляЗанятияБезНуля$$"
	И Я запоминаю случайное число в переменную "ОтказКлиентаШтраф"
	Дано я запоминаю значение выражения '"ОтказКлиентаШтраф" + Формат($ОтказКлиентаШтраф$, "ЧГ=0")' в переменную "$$ОтказКлиентаШтраф$$"
	Дано я открываю основную форму справочника 'ПричиныОтмен'
	И я активизирую окно "Причина отмены занятия (создание)"
	И в поле с именем 'Наименование' я ввожу значение выражения "$$ОтказКлиентаШтраф$$"
	И из выпадающего списка с именем 'ТипЗанятия' я выбираю точное значение "Аренда зала"
	И я меняю значение переключателя с именем 'ИнициаторОтмены' на "Клиент"
	И в поле с именем 'ПериодЗаКоторыйЗанятиеНеСписываетсяПоНеявке' я ввожу текст "1"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Создание занятия	
	Дано я открываю основную форму списка документа 'Занятие'
	И я нажимаю на кнопку с именем 'СписокСоздатьАрендуЗала'
	И в поле с именем 'Номенклатура' я ввожу значение выражения "$$УслугаАрендаЗала$$"
	И из выпадающего списка с именем 'Номенклатура' я выбираю точное значение "$$УслугаАрендаЗала$$"
	И я нажимаю на кнопку с именем 'Button0'		
	И в поле с именем 'Помещение' я ввожу значение выражения "$$Помещение$$"
	И из выпадающего списка с именем 'Помещение' я выбираю "$$Помещение$$"
	И в поле с именем 'ДатаВремяНачала' я ввожу значение выражения "$$СегодняДляЗанятия$$"
	И в поле с именем 'Контрагент' я ввожу значение выражения "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ФормаПровести'
	И я меняю значение переключателя с именем 'СтатусЗанятия' на "Отменено"
	И я нажимаю на кнопку с именем 'Button0'
	И в таблице 'Список' я перехожу к строке:
		| "Инициатор" | "Наименование"          |
		| "Клиент"    | "$$ОтказКлиентаШтраф$$" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаПровести'	
	Если открылось окно "1С:Предприятие" Тогда
		И я нажимаю на кнопку с именем 'OK'
		И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'	
	И я выполняю код встроенного языка на сервере
	"""bsl
	РегламентныеЗаданияСерверФитнес.КонтрольВыполненияЗанятий();
	"""	
//Проверка списания.
	Дано Я открываю основную форму списка регистра накопления "ОказаниеУслуг"
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "$$Клиент$$"
	И я перехожу к следующему реквизиту
	Если я жду, что таблица "Список" не станет содержать строки в течение 20 секунд: Тогда
			| "Занятие"                                                                    | "Количество" | "Регистратор"                                       | "Услуга, сегмент"                                            |
			| "Аренда зала: * $$СегодняДляЗанятия$$, $$УслугаАрендаЗала$$, Фитнес плюс, *" | "1,000"      | "Запись на занятие * от * $$СегодняДляЗанятияБезНуля$$:00" | "$$УслугаАрендаЗала$$, $$УслугаАрендаЗала$$, Розничная цена" |
		Тогда я делаю 5 раз
			И я выполняю код встроенного языка на сервере
				"""bsl
				РегламентныеЗаданияСерверФитнес.КонтрольВыполненияЗанятий();
				"""		
			И я нажимаю на кнопку с именем 'ФормаОбновить'					
	И таблица 'Список' содержит строки по шаблону:
		| "Занятие"                                                                    | "Количество" | "Регистратор"                                       | "Услуга, сегмент"                                            |
		| "Аренда зала: * $$СегодняДляЗанятия$$, $$УслугаАрендаЗала$$, Фитнес плюс, *" | "1,000"      | "Запись на занятие * от * $$СегодняДляЗанятияБезНуля$$:00" | "$$УслугаАрендаЗала$$, $$УслугаАрендаЗала$$, Розничная цена" |