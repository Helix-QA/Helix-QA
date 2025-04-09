﻿#language: ru
@tree

Функционал: Заполнение ИБ после обработки Начальное заполнение

Контекст:
	Дано Я подключаю клиент тестирования с параметрами:
		| 'Имя'        | 'Синоним' | 'Тип клиента' | 'Порт' | 'Строка соединения'                  | 'Логин' | 'Пароль' | 'Запускаемая обработка' | 'Дополнительные параметры строки запуска' |
		| 'AvtotestQA' | ''        | 'Тонкий'      | ''     | 'Srvr="localhost";Ref="AvtotestQA";' | 'Админ'      | ''       | ''                      | ''                                        |

Сценарий: Настройка структурной единицы и организации.
	И я удаляю все переменные
	Дано я открываю основную форму списка справочника "СтруктурныеЕдиницы"
	И в таблице "Список" я выбираю текущую строку
	И я сохраняю навигационную ссылку текущего окна в переменную "Ссылка" (Расширение)
	И Я запоминаю в переменную "$$СсылкаНаСтруктурку$$" значение "$Ссылка$"
	И я нажимаю на кнопку с именем '_Дополнительно'
	И из выпадающего списка с именем 'ЧасовойПояс' я выбираю точное значение "Europe/Moscow"
	И я нажимаю на кнопку открытия поля с именем 'Страна'
	И в поле с именем 'ТелефонныйКод' я ввожу текст "+7"
	И из выпадающего списка с именем 'ВалютаУчета' я выбираю точное значение "RUR"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю кнопку выбора у поля с именем 'Язык'
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "Русский"
	И я перехожу к следующему реквизиту
	И в поле с именем 'СимвольныйКод' я ввожу текст "RU"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Настройка организации.
	//Заполнение наименований.
	Дано я открываю основную форму списка справочника "Организации"			
	И в таблице "Список" я выбираю текущую строку
	И в поле с именем 'ПолноеНаименование' я ввожу текст "Основная организация"
	И в поле с именем 'Наименование' я ввожу текст "Основная организация"
	//Заполнение НДС.
	И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_0' я выбираю точное значение "Авансы"
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_0'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_0' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_0' я выбираю точное значение "Без НДС"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьГруппуПримененияСНО'
	И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_1' я выбираю точное значение "Товары"
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_1' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_1' я выбираю точное значение "Без НДС"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьГруппуПримененияСНО'
	И из выпадающего списка с именем 'ПолеФормыПредметНалогообложения_2' я выбираю точное значение "Услуги"
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_СистемаНалогообложения_2'
	И из выпадающего списка с именем 'ПолеФормы_СистемаНалогообложения_2' я выбираю точное значение "Общая"
	И из выпадающего списка с именем 'ПолеФормыСтавкаНДС_2' я выбираю точное значение "Без НДС"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Сценарий: Создание и настройка подключаемого оборудования.
	Попытка
		Если предыдущий сценарий выполнен успешно
	Исключение
		Тогда я останавливаю выполнение сценариев данной фичи
		Тогда я вызываю исключение "Ошибка при настройке структурной единицы или организации"
	//Включение режима тестирования ККТ
	
	И я открываю окно функции для технического специалиста (расширение)
	И в таблице 'Table' я активизирую дополнение формы с именем 'SearchStr'
	И в таблице 'Table' в дополнение формы с именем 'SearchStr' я ввожу текст "Режим тестирования ККТ"
	И я жду, что в таблице "Table" количество строк будет "больше" 0 в течении 20 секунд
	И в таблице 'Table' я выбираю текущую строку
	Если флаг с именем 'РежимТестированияККТ' равен "Ложь" Тогда
		И я изменяю флаг с именем 'РежимТестированияККТ'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		
//Создание подключаемого оборудования.
	//Создание АТОЛ 10x.
	И В командном интерфейсе я выбираю "Настройки" "Подключаемое оборудование"
	И я нажимаю на кнопку с именем 'СправочникПодключаемоеОборудование'
	И я нажимаю на кнопку с именем 'СписокСоздать'
	И из выпадающего списка с именем 'ТипОборудования' я выбираю точное значение "ККТ с передачей данных"
	И из выпадающего списка с именем 'ДрайверОборудования' я выбираю точное значение "АТОЛ:ККТ с передачей данных в ОФД 10.Х (ФФД 1.2)"
	И я нажимаю кнопку выбора у поля с именем 'Организация'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю кнопку выбора у поля с именем 'РабочееМесто'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку 'Сохранить'
	Если элемент формы с именем 'Драйвер' стал равен шаблону "Установлен интеграционный компонент" Тогда
		И элемент формы с именем 'УстройствоПодключено' стал равен "Устройство подключено"
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
	Иначе 
		И я нажимаю на кнопку с именем 'УстановитьДрайвер'
	 	И я нажимаю на кнопку с именем 'Button0'
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
	И я закрываю все окна клиентского приложения
	//Создание АТОЛ 10x УСН.
	И В командном интерфейсе я выбираю "Настройки" "Подключаемое оборудование"
	И я нажимаю на кнопку с именем 'СправочникПодключаемоеОборудование'
	И я нажимаю на кнопку с именем 'СписокСоздать'
	И из выпадающего списка с именем 'ТипОборудования' я выбираю точное значение "ККТ с передачей данных"
	И из выпадающего списка с именем 'ДрайверОборудования' я выбираю точное значение "АТОЛ:ККТ с передачей данных в ОФД 10.x (ФФД 1.2) УСН НДС"
	И я нажимаю кнопку выбора у поля с именем 'Организация'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю кнопку выбора у поля с именем 'РабочееМесто'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'			
	И открылось окно "Оборудование: \'АТОЛ:ККТ с передачей данных в ОФД 10.x (ФФД 1.2) УСН НДС\'"
	Если элемент формы с именем 'Драйвер' стал равен шаблону "Установлен интеграционный компонент" Тогда
		И элемент формы с именем 'УстройствоПодключено' стал равен "Устройство подключено"
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
	Иначе 
		И я нажимаю на кнопку с именем 'УстановитьДрайвер'
		И я нажимаю на кнопку с именем 'Button0'
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
	И я закрываю все окна клиентского приложения
	//Создание Life-Pay.
	И В командном интерфейсе я выбираю "Настройки" "Подключаемое оборудование"
	И я нажимаю на кнопку с именем 'СправочникПодключаемоеОборудование'
	И я нажимаю на кнопку с именем 'СписокСоздать'
	И из выпадающего списка с именем 'ТипОборудования' я выбираю точное значение "ККТ с передачей данных"
	И из выпадающего списка с именем 'ДрайверОборудования' я выбираю точное значение "LifePay - онлайн фискализация в ОФД (54-ФЗ)"
	И из выпадающего списка с именем 'Организация' я выбираю точное значение "Основная организация"
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И в поле с именем 'СерийныйНомер' я ввожу текст "00106701076650"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И открылось окно "Настройка Life Pay с передачей данных в ОФД (54-ФЗ)"
	И в поле с именем 'АдресURL' я ввожу текст "sapi.life-pay.ru"
	И в поле с именем 'Login' я ввожу текст "79882843969"
	И я меняю значение переключателя с именем 'ВерсияФФД11' на "1.2"
	И в поле с именем 'Apikey' я ввожу текст "379b9878cf4973699a7aea7d37562a3f"
	И я нажимаю на кнопку с именем 'ФормаТестПодключения'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'

Сценарий: Настройка Касс/Создание онлайн кассы и подключение к ней эквайрингов.
	Попытка
		Если предыдущий сценарий выполнен успешно
	Исключение
		Тогда я останавливаю выполнение сценариев данной фичи
		Тогда я вызываю исключение "Ошибка при работе с подключаемым оборудованием"
//Настройка основной кассы
	Дано Я открываю основную форму списка справочника "Кассы"
	И в таблице "Список" я перехожу к строке по шаблону:
		| 'Наименование'   |
		| 'Основная касса' |
	И в таблице "Список" я выбираю текущую строку
	И я устанавливаю флаг с именем 'ИспользоватьБезПодключенияОборудования'
	И из выпадающего списка с именем 'ВнешнееОборудование' я выбираю точное значение "\'АТОЛ:ККТ с передачей данных в ОФД 10.Х (ФФД 1.2)\'"
	И из выпадающего списка с именем 'ВерсияФФДдляККТ' я выбираю точное значение "1.2"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Создание онлайн кассы.	
	Дано Я открываю основную форму справочника "Кассы"
	И в поле с именем 'Наименование' я ввожу текст "ОнлайнКасса"
	И я устанавливаю флаг с именем 'ИспользоватьБезПодключенияОборудования'

	И из выпадающего списка с именем 'Организация' я выбираю по строке "Основная"

		
	И из выпадающего списка с именем 'ВнешнееОборудование' я выбираю точное значение "\'АТОЛ:ККТ с передачей данных в ОФД 10.Х (ФФД 1.2)\'"
	И из выпадающего списка с именем 'ВерсияФФДдляККТ' я выбираю точное значение "1.2"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	 		
*Создание и добавление эквайринговых терминалов.
//Создание Юкассы.
	Дано я открываю основную форму справочника "ЭквайринговыеТерминалы"
	И я нажимаю на кнопку с именем 'ПереключательОнлайнЭквайринг'
	И я нажимаю кнопку выбора у поля с именем 'Эквайрер'
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюКнопкаОтображениеСписок' на элементе формы с именем 'Список'
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "Юкасса"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'Организация' я выбираю точное значение "Основная организация"
		
	И я нажимаю кнопку выбора у поля с именем 'БанковскийСчет'
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'НомерСчета' я ввожу текст "12344321"
	И я нажимаю кнопку выбора у поля с именем 'БИКБанка'
	И я нажимаю на кнопку с именем 'Создать'
	И я нажимаю на кнопку с именем 'Button1'
	И в поле с именем 'Наименование' я ввожу текст "1234554321"
	И в поле с именем 'Код' я ввожу текст "123456789"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И из выпадающего списка с именем 'Наименование' я выбираю точное значение "12344321, в 123456789 1234554321"
	И я нажимаю кнопку выбора у поля с именем 'Валюта'
	И в таблице 'Валюты' я выбираю текущую строку
	Когда открылось окно "Банковский счет (создание) *"
	И я нажимаю кнопку выбора у поля с именем 'Владелец'
	Тогда открылось окно "Выбор типа данных"
	И я нажимаю на кнопку "ОК"
	Тогда открылось окно "Организации"
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
		
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю кнопку выбора у поля с именем 'ВидЛицевогоСчета'
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю кнопку выбора у поля с именем 'Касса'
	И в таблице "Список" я перехожу к строке по шаблону:
		| 'Наименование' |
		| 'ОнлайнКасса'  |
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'ТипБанка' я выбираю точное значение "ЮКасса"
	И я устанавливаю флаг с именем 'ТестовыйРежим'
	И в поле с именем 'ЛогинБанка' я ввожу текст "1050064"
	И в поле с именем 'ПарольБанка' я ввожу текст "test_3Rh6TWL8p4QgouSE6P-A-yVm7a-TruGghmPVKPuQkWg"
	И я устанавливаю флаг с именем 'ИспользоватьОплатуПоСсылке'
	И в поле с именем 'UrlRedirect' я ввожу текст "ya.ru"
	И в поле с именем 'ВремяЖизниСсылкиНаОплату' я ввожу текст "3"
	И я устанавливаю флаг с именем 'ПривязыватьКартуВСервисе'
	И я нажимаю на кнопку с именем 'ОтобразитьВыборТиповФискализации'
	И в меню формы я выбираю 'В Юкассе'
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И из выпадающего списка с именем 'Наименование' я выбираю точное значение "Юкасса, Основная организация"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Создание сбербанка.
	Дано я открываю основную форму справочника "ЭквайринговыеТерминалы"
	И я нажимаю на кнопку с именем 'ПереключательОнлайнЭквайринг'
	И я нажимаю кнопку выбора у поля с именем 'Эквайрер'
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюКнопкаОтображениеСписок' на элементе формы с именем 'Список'
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "Сбербанк"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'				
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'Организация' я выбираю точное значение "Основная организация"
	И я нажимаю кнопку выбора у поля с именем 'БанковскийСчет'								
	И в таблице "Список" я выбираю текущую строку
	И я нажимаю кнопку выбора у поля с именем 'ВидЛицевогоСчета'
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю кнопку выбора у поля с именем 'Касса'
	И в таблице "Список" я перехожу к строке по шаблону:
		| 'Наименование' |
		| 'ОнлайнКасса'  |
	И в таблице 'Список' я выбираю текущую строку
	И из выпадающего списка с именем 'ТипБанка' я выбираю точное значение "Сбербанк"
	И я устанавливаю флаг с именем 'ТестовыйРежим'
	И в поле с именем 'URLБанка' я ввожу текст "ya.ru"
	И в поле с именем 'ЛогинБанка' я ввожу текст "t6320050837-api"
	И в поле с именем 'ПарольБанка' я ввожу текст "x3dv6963"
	И я изменяю флаг с именем 'ИспользоватьОплатуПоСсылке'
	И в поле с именем 'UrlRedirect' я ввожу текст "ya.ru"
	И в поле с именем 'ВремяЖизниСсылкиНаОплату' я ввожу текст "2"
	И я изменяю флаг с именем 'ПривязыватьКартуВСервисе'
	И я нажимаю на кнопку с именем 'ОтобразитьВыборТиповФискализации'
	И в меню формы я выбираю 'В Сбербанке'
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И из выпадающего списка с именем 'Наименование' я выбираю точное значение "Сбербанк, Основная организация"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
*Продолжение создания касс.
//Создание кассы LifePay.
	Дано я открываю основную форму справочника "Кассы"
	И в поле с именем 'Наименование' я ввожу текст "LifePay"
	И из выпадающего списка с именем 'Организация' я выбираю точное значение "Основная организация"
	И из выпадающего списка с именем 'ВнешнееОборудование' я выбираю точное значение "\'LifePay - онлайн фискализация в ОФД (54-ФЗ)\'"
	И из выпадающего списка с именем 'ВерсияФФДдляККТ' я выбираю точное значение "1.2"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Создание кассы АТОЛ УСН.
	Дано я открываю основную форму справочника "Кассы"
	И в поле с именем 'Наименование' я ввожу текст "АтолУСН"
	И из выпадающего списка с именем 'Организация' я выбираю точное значение "Основная организация"
	И из выпадающего списка с именем 'ВнешнееОборудование' я выбираю точное значение "\'АТОЛ:ККТ с передачей данных в ОФД 10.x (ФФД 1.2) УСН НДС\'"
	И из выпадающего списка с именем 'ВерсияФФДдляККТ' я выбираю точное значение "1.2"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Сценарий: Создание интеграций.
	Попытка
		Если предыдущий сценарий выполнен успешно
	Исключение
		Тогда я останавливаю выполнение сценариев данной фичи
		Тогда я вызываю исключение "Ошибка при создании касс"
//Запись публикации в константу.
	И я открываю окно функции для технического специалиста (расширение)
	И в таблице 'Table' в дополнение формы с именем 'SearchStr' я ввожу текст "Адрес внешней публикации"
	И я жду, что в таблице "Table" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Table' я выбираю текущую строку
	И в поле с именем 'ВнешняяПубликацияАдрес' я ввожу текст "http://37.26.136.234:8100/VAFitness"
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И я жду закрытия окна "Адрес внешней публикации *" в течение 20 секунд
//Вход в личный кабинет.
	И В командном интерфейсе я выбираю "Настройки" "Личный кабинет"
	И я нажимаю на гиперссылку 'Уже зарегистрирован'
	И открылось окно "Вход в личный кабинет"
	И в поле с именем 'АвторизацияРегистрационныйНомер' я ввожу текст "77507942_1"
	И в поле с именем 'АвторизацияПароль' я ввожу текст "77507942_1"
	И я нажимаю на кнопку с именем 'ВойтиИлиЗарегистрироваться'
	И я жду открытия окна "Личный кабинет, регистрация: 77507942_1 - подтверждена." в течение 20 секунд
	И Я закрываю окно "Личный кабинет, регистрация: 77507942_1 - подтверждена."
//Настройка и создание виджета расписания.
	//Настройка основного раздела виджета.
	И В командном интерфейсе я выбираю "Настройки" "Все интеграции"
	И я нажимаю на кнопку с именем 'КнопкаДобавить'
	И я нажимаю на кнопку с именем 'Виджеты_Строка_0_Элемент_1_КнопкаНастройки'
	И я устанавливаю флаг с именем 'ГрупповыеПрограммы'
	И я устанавливаю флаг с именем 'ПерсональныеЗанятия'
	И я устанавливаю флаг с именем 'Аренда'
	И я устанавливаю флаг с именем 'ОтображатьЕмкостьЗанятия'
	И я устанавливаю флаг с именем 'ОтображатьПереносыИЗамены'
	И я устанавливаю флаг с именем 'ИспользоватьЛистОжидания'
	И я нажимаю на кнопку с именем 'СпособОтправки_1'
	//Настройка раздела Личный кабинет.
	И я нажимаю на кнопку с именем '_ЛичныйКабинет'
	И в поле с именем 'АдресСтраницыЛичногоКабинета' я ввожу текст "https://www.fitness1c.ru/club/index.php?api_key=dae7f345-5902-4f3a-a244-b7b7f9290817"
	//Настройка раздела Структурные единицы.
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем '_СтруктурныеЕдиницы'
	И я нажимаю на кнопку с именем 'ДобавитьСтруктурнуюЕдиницу'
	И я нажимаю кнопку выбора у поля с именем 'СтруктурнаяЕдиница_0'
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице 'Список' я выбираю текущую строку

	И я перехожу к закладке с именем 'ГруппаЭквайринговыеТерминалыВсплывающая_0'
	И из выпадающего списка с именем 'ЭквайринговыйТерминал_0' я выбираю по строке "Юкасса, Основная ораганизация"
	//Сохранение виджета.
	И я перехожу к закладке с именем 'ГруппаЭквайринговыеТерминалыВсплывающая_0'
	И я нажимаю на кнопку с именем 'СохранитьВиджет'
	И я закрываю все окна клиентского приложения
//Создание интеграции с мобильным приложением тренера.
	И В командном интерфейсе я выбираю "Настройки" "Все интеграции"
	И я нажимаю на кнопку с именем 'КнопкаДобавить'	
	И я нажимаю на кнопку с именем 'МобильныеПриложения_Строка_0_Элемент_1_КнопкаНастройки'
	И я нажимаю на кнопку с именем 'Сохранить'
	И я закрываю все окна клиентского приложения												

Сценарий: Добавление касс в структурную единицу и пользователю ИБ(Админ).
	Попытка
		Если предыдущий сценарий выполнен успешно
	Исключение
		Тогда я останавливаю выполнение сценариев данной фичи
		Тогда я вызываю исключение "Ошибка при создании интеграций"
//Добавление в структурную единицу касс.
	Дано Я открываю навигационную ссылку "$$СсылкаНаСтруктурку$$"
	И я нажимаю на кнопку с именем 'КассыДляОплатыДобавитьКассу'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "ОнлайнКасса"  |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'КассыДляОплатыДобавитьКассу'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "LifePay"      |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'КассыДляОплатыДобавитьКассу'
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "АтолУСН"      |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
//Добавление сотруднику касс.
	Дано я открываю основную форму списка справочника "Сотрудники"	
	И в таблице "Список" я перехожу к строке:
		| 'ФИО'   |
		| 'Админ' |
	И в таблице "Список" я выбираю текущую строку
	//Основная касса.
	И я нажимаю на кнопку с именем 'СписокДоступныеКассыКнопкаДобавить'
	И в меню формы я выбираю 'Основная касса (касса)'
	//Онлайн касса.
	И я нажимаю на кнопку с именем 'СписокДоступныеКассыКнопкаДобавить'
	И в меню формы я выбираю 'ОнлайнКасса (касса)'
	//Касса LifePay.
	И я нажимаю на кнопку с именем 'СписокДоступныеКассыКнопкаДобавить'
	И в меню формы я выбираю 'LifePay (касса)'
	И я нажимаю на кнопку с именем 'СписокДоступныеКассыКнопкаДобавить'
	//Касса АтолУСН.
	И в меню формы я выбираю 'АтолУСН (касса)'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		

