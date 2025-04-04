﻿#language: ru

@tree

Функционал: Проверка триггер с заявками/обращения и сделками.
  

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения
	И я запоминаю имя конфигурации как "ИмяКонфигурации"
	
Сценарий: Начальное заполнение ИБ.
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
		И я удаляю все переменные
		И я удаляю объекты "Справочники.ТриггерныеСобытия" без контроля ссылок
		И Я генерирую СлучайноеЧисло_Для триггеров стомы и фитнеса
		И Я создаю шаблон сообщения
		И Я создаю Тренера
		И Я создаю клиента
		И Я создаю рекламный источник для триггера с заявками.
		И я удаляю объекты "Справочники.Сделки" без контроля ссылок
		И я удаляю объекты "Справочники.Заявки" без контроля ссылок
		Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()-172800)' в переменную "$$ПозаВчера$$"
		Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()-3601)' в переменную "$$Сегодня$$"
		Затем я останавливаю выполнение сценария
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
		И я удаляю все переменные
		И я удаляю объекты "Справочники.ТриггерныеСобытия" без контроля ссылок
		И Я генерирую СлучайноеЧисло_Для триггеров стомы и фитнеса
		И Я создаю шаблон сообщения
		И Я создаю пациента
		И Я создаю пациента_2
		И Я создаю врача
		И Я создаю рекламный источник для триггера с заявками.
		И я удаляю объекты "Справочники.Сделки" без контроля ссылок
		И я удаляю объекты "Справочники.Заявки" без контроля ссылок
		Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()-172800)' в переменную "$$ПозаВчера$$"
		Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()-3601)' в переменную "$$Сегодня$$"

Сценарий: Проверка количество и порядок триггеров
	И Остановка если была ошибка в прошлом сценарии
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
		Дано Я открываю основную форму справочника "ТриггерныеСобытия"
		И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Заявки'
		И выпадающий список с именем "УсловиеСобытия" стал равен:
			|'Заявка не обработана в течение'|
		И я закрываю все окна клиентского приложения
		Дано Я открываю основную форму справочника "ТриггерныеСобытия"
		И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Сделки'
		И выпадающий список с именем "УсловиеСобытия" стал равен:
			| 'Задержка на этапе более'  |
			| 'Задержка на этапе каждые' |
			| 'Переход с этапа на этап'  |
		Затем я останавливаю выполнение сценария
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
		Дано Я открываю основную форму справочника "ТриггерныеСобытия"
		И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Обращения'
		И выпадающий список с именем "УсловиеСобытия" стал равен:
			| 'Создание нового обращения'         |
			| 'Обращение не обработано в течение' |
			| 'Изменение статуса обращения'       |
		И я закрываю все окна клиентского приложения
		Дано Я открываю основную форму справочника "ТриггерныеСобытия"
		И из выпадающего списка с именем "ВиртуальнаяГруппаСобытий" я выбираю точное значение 'Сделки'
		И выпадающий список с именем "УсловиеСобытия" стал равен:
			| 'Переход с этапа на этап'  |
			| 'Задержка на этапе'        |
			| 'Задержка на этапе каждые' |

Сценарий: Создание триггеров по Заявкам/Обращениям в фитнесе и стоматологии.
//Создание триггера - Заявка не обработана в течение.
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Заявка не обработана в течение $$СлучайноеЧисло$$"
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Заявки"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Заявка не обработана в течение"
		И в поле с именем 'ПериодСобытияПараметр' я ввожу текст "1"
		И из выпадающего списка с именем 'ПериодСобытияВидПараметр' я выбираю точное значение "минуты"
		И Я сохраняю триггер для фитнес клуба		
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
//Создание триггера - Создание нового обращения.
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Создание нового обращения $$СлучайноеЧисло$$"
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Обращения"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Создание нового обращения"
		И Я сохраняю триггер для стоматологии
//Создание триггера - Заявка не обработана в течение.				
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Заявка не обработана в течение $$СлучайноеЧисло$$"
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Обращения"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Обращение не обработано в течение"
		И в поле с именем 'ПериодСобытияПараметр' я ввожу текст "1"
		И из выпадающего списка с именем 'ПериодСобытияВидПараметр' я выбираю точное значение "минуты"
		И Я сохраняю триггер для стоматологии		
//Создание триггера - Изменение статуса обращения.
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Изменение статуса обращения $$СлучайноеЧисло$$"
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Обращения"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Изменение статуса обращения"
		И из выпадающего списка с именем 'СтатусЗаявки' я выбираю точное значение "На любой статус"
		И Я сохраняю триггер для стоматологии		

Сценарий: Создание триггеров по сделкам в фитнесе и стоматологии.
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
//Создание триггера - Задержка на этапе более.
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Задержка на этапе более $$СлучайноеЧисло$$"
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сделки"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Задержка на этапе более"
		И в поле с именем 'ПериодСобытияПараметр' я ввожу текст "1"
		И из выпадающего списка с именем 'ПериодСобытияВидПараметр' я выбираю точное значение "минуты"
		И из выпадающего списка с именем 'ВидСделки' я выбираю точное значение "Для сделок с видом \"Новая продажа\""
		И из выпадающего списка с именем 'ПереходСЭтапа' я выбираю точное значение "На этапе \"1. Контакт с клиентом\""
		И Я сохраняю триггер для фитнес клуба		
//Создание триггера - Задержка на этапе каждые.
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Задержка на этапе каждые $$СлучайноеЧисло$$"
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сделки"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Задержка на этапе каждые"	
		И в поле с именем 'ПериодСобытияПараметр' я ввожу текст "1"
		И из выпадающего списка с именем 'ПериодСобытияВидПараметр' я выбираю точное значение "дня"
		И из выпадающего списка с именем 'ВидСделки' я выбираю точное значение "Для сделок с видом \"Новая продажа\""
		И из выпадающего списка с именем 'ПереходСЭтапа' я выбираю точное значение "На этапе \"1. Контакт с клиентом\""
		И Я сохраняю триггер для фитнес клуба
//Создание триггера - Переход с этапа на этап.
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Переход с этапа на этап $$СлучайноеЧисло$$"
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сделки"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Переход с этапа на этап"		
		И из выпадающего списка с именем 'ВидСделки' я выбираю точное значение "Для любых сделок"
		И Я сохраняю триггер для фитнес клуба
		Затем я останавливаю выполнение сценария
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
//Создание триггера - Переход с этапа на этап.
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Переход с этапа на этап $$СлучайноеЧисло$$"	
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сделки"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Переход с этапа на этап"
		И я нажимаю кнопку выбора у поля с именем 'ВидСделки'
		И из выпадающего списка с именем 'ВидСделки' я выбираю точное значение "Для сделок с видом \"Постоянный пациент\""
		И из выпадающего списка с именем 'ПереходСЭтапа' я выбираю точное значение "С любого этапа"
		И из выпадающего списка с именем 'ПереходНаЭтап' я выбираю точное значение "На любой этап"
		И Я сохраняю триггер для стоматологии
//Создание триггера - Задержка на этапе.(требует пару минут после того как создаются новые условия для активации)
		Дано я открываю основную форму справочника "ТриггерныеСобытия"
		И в поле с именем 'Наименование' я ввожу текст "Задержка на этапе $$СлучайноеЧисло$$"	
		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сделки"
		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Задержка на этапе"
		И в поле с именем 'ПериодСобытияПараметр' я ввожу текст "1"
		И из выпадающего списка с именем 'ПериодСобытияВидПараметр' я выбираю точное значение "минуты"
		И из выпадающего списка с именем 'ВидСделки' я выбираю точное значение "Для сделок с видом \"Постоянный пациент\""
		И из выпадающего списка с именем 'ПереходСЭтапа' я выбираю точное значение "На этапе \"1. Запись на первичный прием\""
		И Я сохраняю триггер для стоматологии
//Создание триггера - Задержка на этапе каждые.(не сьедает смену даты в сделке, следовательно и не активируется)
//		Дано я открываю основную форму справочника "ТриггерныеСобытия"
//		И в поле с именем 'Наименование' я ввожу текст "Задержка на этапе каждые $$СлучайноеЧисло$$"	
//		И из выпадающего списка с именем 'ВиртуальнаяГруппаСобытий' я выбираю точное значение "Сделки"
//		И из выпадающего списка с именем 'УсловиеСобытия' я выбираю точное значение "Задержка на этапе каждые"		
//		Когда открылось окно "Триггерное событие (создание) *"
//		И в поле с именем 'ПериодСобытияПараметр' я ввожу текст "1"
//		И из выпадающего списка с именем 'ПериодСобытияВидПараметр' я выбираю точное значение "дня"
//		И из выпадающего списка с именем 'ВидСделки' я выбираю точное значение "Для сделок с видом \"Постоянный пациент\""
//		И из выпадающего списка с именем 'ПереходСЭтапа' я выбираю точное значение "На этапе \"1. Запись на первичный прием\""
//		И Я сохраняю триггер для стоматологии


Сценарий: Активация триггеров по заявкам.
//Активация триггера - Заявка не обработана в течение.
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
		Дано Я открываю основную форму справочника "Заявки"
		И в поле с именем 'Фамилия' я ввожу текст 'КлиентЗаяв $$СлучайноеЧисло$$'
		И я нажимаю на кнопку с именем 'КнопкаДополнительно'
		И в поле с именем 'Дата' я ввожу текст '$Сегодня$'
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
//Активация триггера - Создание нового обращения.
		Дано я открываю основную форму справочника "Заявки"
		И в поле с именем 'Фамилия' я ввожу значение выражения "КлиентЗаяв $$СлучайноеЧисло$$"
		И я нажимаю на кнопку с именем 'КнопкаДополнительно'
		И в поле с именем 'Дата' я ввожу текст "$$Сегодня$$"
		И я нажимаю на кнопку с именем 'ФормаКнопкаЗаписатьИЗакрыть'					
//Активация триггера - Изменение статуса обращения.				
		И я программно создаю элемент справочника "Заявки" с реквизитами
		| 'Фамилия'            | '$$Пациент$$'                           |
		| 'СтруктурнаяЕдиница' | 'Центр Стоматологической Имплантологии' |
		Дано я открываю основную форму списка справочника "Заявки"
		И я активизирую дополнение формы с именем 'СтрокаПоиска'
		И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$Пациент$$"
		И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 20 секунд
		И в таблице "Список" я выбираю текущую строку
		И я нажимаю на кнопку с именем 'СтатусПропущенныйЗвонок'
		И я нажимаю на кнопку с именем 'ФормаКнопкаЗаписатьИЗакрыть'

Сценарий: Активация триггеров по сделкам.
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
//Активация - Переход с этапа на этап.
		И В командном интерфейсе я выбираю 'CRM' 'Сделки'
		И я нажимаю на кнопку с именем 'ОткрытьСписок'
		И я нажимаю на кнопку с именем 'СоздатьСделку'
		И в поле с именем 'Фамилия' я ввожу текст 'КонтрагентТриггер $$СлучайноеЧисло$$'
		И я нажимаю на кнопку с именем 'КнопкаДополнительно'
		И в поле с именем 'ДатаСделки' я ввожу текст '$$ПозаВчера$$'
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		И Пауза 2
//Активация - Задержка на этапе каждые (1 день)
//Создал сделку задним числом
		И я программно создаю элемент справочника "Сделки" с реквизитами
		| 'Автор'              | 'Админ'               |
		| 'ВидСделки'          | 'Новая продажа'       |
		| 'ДатаСделки'         | '01.05.2024 00:13:37' |
		| 'Контрагент'         | '$$Клиент$$'          |
		| 'Менеджер'           | 'Админ'               |
		| 'СтруктурнаяЕдиница' | 'Фитнес плюс'         |
		| 'ЭтапСделки'         | 'Контакт с клиентом'  |
//Редактирование через универсальный редактор
		И Пауза 1
		Дано Я открываю основную форму обработки "VAExtension_ОткрытьВнешнююОбработкуИлиОтчет"
		И я активизирую окно "VAExtension открыть внешнюю обработку или отчет"	
		И в поле с именем 'ПутьКОбработке' я ввожу текст "D:\Моя документация(данные)\Обработки\_Universal_nyy_redaktor_rekvizitov_8_2_upravlyaemyy_interfeys_2.epf"
		И я нажимаю на кнопку с именем 'ФормаВыполнитьКод'
		Если открылось окно "1С:Предприятие" Тогда
			Тогда я нажимаю на кнопку с именем 'OK'
	//	И я выбираю файл "C:\VA_test\_Universal_nyy_redaktor_rekvizitov_8_2_upravlyaemyy_interfeys_2.epf" ВК
	//	"C:\Users\Димитрий\Desktop\Документация\Обработки\_Universal_nyy_redaktor_rekvizitov_8_2_upravlyaemyy_interfeys_2.epf"
	//Сервер: "C:\VA_test\_Universal_nyy_redaktor_rekvizitov_8_2_upravlyaemyy_interfeys_2.epf"
		И я активизирую окно "Универсальный редактор реквизитов v 2.1"
		И я нажимаю кнопку выбора у поля с именем "ВыбСсылка"
		И в таблице "ДеревоОбъектов" я разворачиваю строку:
			| 'Вид объекта' |
			| 'Справочники' |
		И в таблице "ДеревоОбъектов" я перехожу к строке:
			| 'Вид объекта'     |
			| 'Сделки (Сделки)' |
		И я выбираю пункт контекстного меню с именем 'ДеревоОбъектовКонтекстноеМенюВыбрать' на элементе формы с именем "ДеревоОбъектов"
		И я выбираю пункт контекстного меню с именем 'ДеревоОбъектовКонтекстноеМенюВыбрать' на элементе формы с именем "ДеревоОбъектов"
		И в таблице "ДеревоОбъектов" я выбираю текущую строку
		И в таблице "Список" я перехожу к последней строке
		И в таблице "Список" я выбираю текущую строку
		И я перехожу к закладке с именем "ТабличныеЧасти"
		И я жду, что в таблице "lyayТчИсторияИзмененияЭтапов" количество строк будет "больше" 0 в течение 20 секунд
		И в таблице "lyayТчИсторияИзмененияЭтапов" я активизирую поле с именем "lyayТчИсторияИзмененияЭтаповДата"
		И в таблице "lyayТчИсторияИзмененияЭтапов" я выбираю текущую строку
		И в таблице "lyayТчИсторияИзмененияЭтапов" в поле с именем 'lyayТчИсторияИзмененияЭтаповДата' я ввожу текст '$$ПозаВчера$$'
		И в таблице "lyayТчИсторияИзмененияЭтапов" я завершаю редактирование строки
		И я нажимаю на кнопку с именем 'ЗаписатьИзменения'
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
//Активация триггера - Задержка на этапе.
		Дано Я открываю навигационную ссылку "$$СсылкаПациента$$"
		И я нажимаю на кнопку с именем 'КнопкаСоздатьСделку'
		И в меню формы я выбираю 'Постоянный пациент'
		И я нажимаю на кнопку с именем 'КнопкаСделка_0'
		И я нажимаю на кнопку с именем 'КнопкаДополнительно'
		И в поле с именем 'ДатаСделки' я ввожу значение выражения "$$Сегодня$$"
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'						
//Активация триггера - Переход с этапа на этап.
		Дано я открываю основную форму списка справочника "Сделки"
		И я нажимаю на кнопку с именем 'СоздатьСделку'
		И в поле с именем 'Фамилия' я ввожу значение выражения "КлиентСделка1 $$СлучайноеЧисло$$"
		И я нажимаю на кнопку с именем 'КнопкаДополнительно'
		И в поле с именем 'ДатаСделки' я ввожу текст "$$Позавчера$$"
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
		И я закрываю текущее окно
		Дано я открываю основную форму списка справочника "Сделки"
		И я нажимаю на кнопку с именем 'ИзменитьВидСделки'
		И в меню формы я выбираю 'Новый пациент'
		И я нажимаю на кнопку с именем 'СброситьОтборЗадачиНаСегодня'
		И я активизирую дополнение формы с именем 'СтрокаПоиска'
		И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "КлиентСделка1 $$СлучайноеЧисло$$"
		И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 20 секунд
		И в таблице "Список" я выбираю текущую строку
		И я нажимаю на кнопку с именем 'КнопкаЭтап_1'
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
//Активация триггера - Задержка на этапе каждые.(Держать закоменченным до первых правок или же отработок)						
//		И я закрываю все окна клиентского приложения
//		Дано я открываю основную форму справочника "Контрагенты"
//		И в поле с именем 'Фамилия' я ввожу значение выражения "КлиентСделка2 $$СлучайноеЧисло$$"
//		И я нажимаю на кнопку с именем 'КнопкаСоздатьСделку'
//		И я нажимаю на кнопку с именем 'Button0'
//		И в меню формы я выбираю 'Постоянный пациент'
//		И я нажимаю на кнопку с именем 'КнопкаСделка_0'
//		И я нажимаю на кнопку с именем 'КнопкаДополнительно'
//		И в поле с именем 'ДатаСделки' я ввожу текст "$$Позавчера$$"
//		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
//		И я открываю внешнюю обработку или отчет "D:\Моя документация(данные)\Обработки\_Universal_nyy_redaktor_rekvizitov_8_2_upravlyaemyy_interfeys_2.epf" (Расширение)
////Серверный путь: "C:\VA_test\_Universal_nyy_redaktor_rekvizitov_8_2_upravlyaemyy_interfeys_2.epf"
//		Когда открылось окно "Универсальный редактор реквизитов v 2.1"
//		И я нажимаю кнопку выбора у поля с именем 'ВыбСсылка'
//		Тогда открылось окно "Универсальный редактор реквизитов v 2.1"
//		И в таблице 'ДеревоОбъектов' я разворачиваю строку:
//			| "Вид объекта" |
//			| "Справочники" |
//		И в таблице 'ДеревоОбъектов' я перехожу к строке:
//			| "Вид объекта"     |
//			| "Сделки (Сделки)" |
//		И в таблице 'ДеревоОбъектов' я выбираю текущую строку
//		И в таблице 'Список' я перехожу к строке:
//			| "Клиника"                               | "Пациент"                           |
//			| "Центр Стоматологической Имплантологии" | "КлиентСделка2 $$СлучайноеЧисло$$ " |
//		И в таблице "Список" я выбираю текущую строку
//		И я перехожу к закладке с именем 'ТабличныеЧасти'
//		И в таблице 'lyayТчИсторияИзмененияЭтапов' я активизирую поле с именем 'lyayТчИсторияИзмененияЭтаповДата'
//		И в таблице 'lyayТчИсторияИзмененияЭтапов' я выбираю текущую строку
//		И в таблице 'lyayТчИсторияИзмененияЭтапов' в поле с именем 'lyayТчИсторияИзмененияЭтаповДата' я ввожу текст "$$Позавчера$$"
//		И в таблице 'lyayТчИсторияИзмененияЭтапов' я завершаю редактирование строки
//		И я нажимаю на кнопку с именем 'ЗаписатьИзменения'

Сценарий: Запускаю регламента - Регистрация триггерных событи
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
		И я выполняю код встроенного языка на сервере
			"""bsl
				ТриггерныеСобытия_КОРП.Регламент_ВыполнитьРегистрациюТриггерныхСобытий2();
			"""
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
		И я выполняю код встроенного языка на сервере
			"""bsl
				ТриггерныеСобытия.Регламент_ВыполнитьРегистрациюТриггерныхСобытий();
			"""

Сценарий: Проверка журнала триггеров по заявкам фитнеса и стоматологии.
//Проверка триггера - Заявка не обработана в течение.
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
		Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице 'Список' я перехожу к строке:
			| "Наименование"                                      |
			| "Заявка не обработана в течение $$СлучайноеЧисло$$" |
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'		
		Если в таблице "Список" количество строк "равно" 0 Тогда
			Тогда в течение 60 секунд я выполняю
				И я выполняю код встроенного языка на сервере
				"""bsl
					ТриггерныеСобытия_КОРП.Регламент_ВыполнитьРегистрациюТриггерныхСобытий2();
				"""
				И я нажимаю сочетание клавиш "F5"
				Если в таблице "Список" количество строк "равно" 1 Тогда
					Тогда я прерываю цикл		
		И таблица 'Список' содержит строки по шаблону:
			| 'Триггерное событие'                                | 'Действие (описание)'         | 'Статус события'   | 'Взаимодействие (задача)'   | 'Объект события'                |
			| 'Заявка не обработана в течение $$СлучайноеЧисло$$' | 'Поставить задачу сотруднику' | 'Зарегистрировано' | '$$Шаблон$$ (не выполнена)' | 'Клиентзаяв $$СлучайноеЧисло$$' |
		И Я деактивировал триггер
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
//Проверка триггера - Заявка не обработана в течение.	
		Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице 'Список' я перехожу к строке:
			| "Наименование"                                      |
			| "Заявка не обработана в течение $$СлучайноеЧисло$$" |	
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'		
		Если в таблице "Список" количество строк "равно" 0 Тогда
			Тогда в течение 60 секунд я выполняю
				И я выполняю код встроенного языка на сервере
				"""bsl
					ТриггерныеСобытия.Регламент_ВыполнитьРегистрациюТриггерныхСобытий();
				"""
				И я нажимаю сочетание клавиш "F5"
				Если в таблице "Список" количество строк "равно" 1 Тогда
					Тогда я прерываю цикл
		И таблица 'Список' содержит строки по шаблону:
			| 'Триггерное событие'                                | 'Действие (описание)'         | 'Статус события'   | 'Взаимодействие (задача)'   | 'Объект события'                |
			| 'Заявка не обработана в течение $$СлучайноеЧисло$$' | 'Поставить задачу сотруднику' | 'Зарегистрировано' | '$$Шаблон$$ (не выполнена)' | 'Клиентзаяв $$СлучайноеЧисло$$' |
		И Я деактивировал триггер
		И я закрываю текущее окно
//Проверка триггера - Изменение статуса обращения.
		Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице 'Список' я перехожу к строке:
			| "Наименование"                                   |
			| "Изменение статуса обращения $$СлучайноеЧисло$$" |
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'		
		И таблица 'Список' содержит строки по шаблону:
			| 'Триггерное событие'                             | 'Действие (описание)'         | 'Статус события'   | 'Взаимодействие (задача)'   | 'Объект события' |
			| 'Изменение статуса обращения $$СлучайноеЧисло$$' | 'Поставить задачу сотруднику' | 'Зарегистрировано' | '$$Шаблон$$ (не выполнена)' | '$$Пациент$$'    |
		И Я деактивировал триггер
		И я закрываю текущее окно
//Проверка триггера - Создание нового обращения.
		Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице 'Список' я перехожу к строке:
			| "Наименование"                                 |
			| "Создание нового обращения $$СлучайноеЧисло$$" |
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'		
		И таблица 'Список' содержит строки по шаблону:		
			| 'Триггерное событие'                           | 'Действие (описание)'         | 'Статус события'   | 'Взаимодействие (задача)'   | 'Объект события'                |
			| 'Создание нового обращения $$СлучайноеЧисло$$' | 'Поставить задачу сотруднику' | 'Зарегистрировано' | '$$Шаблон$$ (не выполнена)' | '$$Пациент$$'                   |
			| 'Создание нового обращения $$СлучайноеЧисло$$' | 'Поставить задачу сотруднику' | 'Зарегистрировано' | '$$Шаблон$$ (не выполнена)' | 'Клиентзаяв $$СлучайноеЧисло$$' |
		И Я деактивировал триггер

Сценарий: Проверка журнала триггеров по сделкам фитнеса и стоматологии.
	Если переменная "ИмяКонфигурации" имеет значение "ФитнесКлуб_КОРП" Тогда
//Проверка триггера - Переход с этапа на этап.
		Дано Я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице "Список" я перехожу к строке:
			| 'Момент события'   | 'Наименование'                               | 'Область события' | 'Структурная единица активации' | 'Условие события'         |
			| 'В момент события' | 'Переход с этапа на этап $$СлучайноеЧисло$$' | 'Сделки'          | 'Любая'                         | 'Переход с этапа на этап' |
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
		И таблица "Список" содержит строки по шаблону:
			| "Триггерное событие"                         | "Контрагент" | "Статус события"   | "Период" | "Часовой пояс" | "Источник события" | "Объект события"    | "Действие (описание)"         | "Структурная единица" | "Взаимодействие (задача)"   | "Сведения об ошибке или причине отклонения действия" |
			| "Переход с этапа на этап $$СлучайноеЧисло$$" | "$$Клиент$$" | "Зарегистрировано" | "*"      | "*"            | ""                 | "Новая продажа № *" | "Поставить задачу сотруднику" | "Фитнес плюс"         | "$$Шаблон$$ (не выполнена)" | ""                                                   |
		И Я деактивировал триггер
//Проверка триггера - Задержка на этапе более (1 мин).
		Дано Я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице "Список" я перехожу к строке:
			| 'Момент события'   | 'Наименование'                               | 'Область события' | 'Структурная единица активации' | 'Условие события'         |
			| 'В момент события' | 'Задержка на этапе более $$СлучайноеЧисло$$' | 'Сделки'          | 'Любая'                         | 'Задержка на этапе более' |
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
	//Без цикла не работает, в будущем исправить триггер и можно будет убрать его
		Если в таблице "Список" количество строк "равно" 0 Тогда
			Тогда в течение 300 секунд я выполняю
				И я выполняю код встроенного языка на сервере
				"""bsl
					ТриггерныеСобытия_КОРП.Регламент_ВыполнитьРегистрациюТриггерныхСобытий2();
				"""
				И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюКнопкаОбновить' на элементе формы с именем 'Список'
				Если в таблице "Список" количество строк "равно" 1 Тогда
					Тогда я прерываю цикл
		И таблица "Список" содержит строки по шаблону:
			| 'Триггерное событие'                         | 'Контрагент'                           | 'Статус события'   | 'Период' | 'Часовой пояс' | 'Источник события' | 'Объект события'    | 'Действие (описание)'         | 'Структурная единица' | 'Взаимодействие (задача)'   | 'Сведения об ошибке или причине отклонения действия' |
			| 'Задержка на этапе более $$СлучайноеЧисло$$' | 'КонтрагентТриггер $$СлучайноеЧисло$$' | 'Зарегистрировано' | '*'      | '*'            | ''                 | 'Новая продажа № *' | 'Поставить задачу сотруднику' | 'Фитнес плюс'         | '$$Шаблон$$ (не выполнена)' | ''                                                   |
		И Я деактивировал триггер
//Проверка триггера - Задержка на этапе каждые (1 день).
		Дано Я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице "Список" я перехожу к строке:
			| 'Момент события'   | 'Наименование'                                | 'Область события' | 'Структурная единица активации' | 'Условие события'          |
			| 'В момент события' | 'Задержка на этапе каждые $$СлучайноеЧисло$$' | 'Сделки'          | 'Любая'                         | 'Задержка на этапе каждые' |
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
		Если таблица "Список" не содержит строки по шаблону: Тогда
			| 'Триггерное событие'                          | 'Контрагент' | 'Статус события'   | 'Период' | 'Часовой пояс' | 'Источник события' | 'Объект события'    | 'Действие (описание)'         | 'Структурная единица' | 'Взаимодействие (задача)'   | 'Сведения об ошибке или причине отклонения действия' |
			| 'Задержка на этапе каждые $$СлучайноеЧисло$$' | '$$Клиент$$' | 'Зарегистрировано' | '*'      | '*'            | ''                 | 'Новая продажа № *' | 'Поставить задачу сотруднику' | 'Фитнес плюс'         | '$$Шаблон$$ (не выполнена)' | ''                                                   |
			Тогда в течение 300 секунд я выполняю
				И я выполняю код встроенного языка на сервере
				"""bsl
					ТриггерныеСобытия_КОРП.Регламент_ВыполнитьРегистрациюТриггерныхСобытий2();
				"""
				И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюКнопкаОбновить' на элементе формы с именем 'Список'
				Если таблица "Список" содержит строки по шаблону: Тогда
					| 'Триггерное событие'                          | 'Контрагент' | 'Статус события'   | 'Период' | 'Часовой пояс' | 'Источник события' | 'Объект события'    | 'Действие (описание)'         | 'Структурная единица' | 'Взаимодействие (задача)'   | 'Сведения об ошибке или причине отклонения действия' |
					| 'Задержка на этапе каждые $$СлучайноеЧисло$$' | '$$Клиент$$' | 'Зарегистрировано' | '*'      | '*'            | ''                 | 'Новая продажа № *' | 'Поставить задачу сотруднику' | 'Фитнес плюс'         | '$$Шаблон$$ (не выполнена)' | ''                                                   |
					Тогда я прерываю цикл
		И таблица "Список" содержит строки по шаблону:
					| 'Триггерное событие'                          | 'Контрагент' | 'Статус события'   | 'Период' | 'Часовой пояс' | 'Источник события' | 'Объект события'    | 'Действие (описание)'         | 'Структурная единица' | 'Взаимодействие (задача)'   | 'Сведения об ошибке или причине отклонения действия' |
					| 'Задержка на этапе каждые $$СлучайноеЧисло$$' | '$$Клиент$$' | 'Зарегистрировано' | '*'      | '*'            | ''                 | 'Новая продажа № *' | 'Поставить задачу сотруднику' | 'Фитнес плюс'         | '$$Шаблон$$ (не выполнена)' | ''                                                   |			
		И Я деактивировал триггер
	Если переменная "ИмяКонфигурации" имеет значение "Стоматология" Тогда
//Проверка триггера - Задержка на этапе.	
		Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице 'Список' я перехожу к строке:
			| "Наименование"                         |
			| "Задержка на этапе $$СлучайноеЧисло$$" |
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
		Если в таблице "Список" количество строк "равно" 0 Тогда
			Тогда в течение 300 секунд я выполняю
				И я выполняю код встроенного языка на сервере
				"""bsl
					ТриггерныеСобытия.Регламент_ВыполнитьРегистрациюТриггерныхСобытий();
				"""
				И я нажимаю сочетание клавиш "F5"
				Если в таблице "Список" количество строк "равно" 1 Тогда
					Тогда я прерываю цикл
			И таблица "Список" содержит строки по шаблону:
				| 'Триггерное событие'                   | 'Действие (описание)'         | 'Статус события'   | 'Контрагент'   | 'Взаимодействие (задача)'   | 'Объект события'         |
				| 'Задержка на этапе $$СлучайноеЧисло$$' | 'Поставить задачу сотруднику' | 'Зарегистрировано' | '$$Пациент$$ ' | '$$Шаблон$$ (не выполнена)' | 'Постоянный пациент № *' |
			И Я деактивировал триггер
//Проверка триггера - Переход с этапа на этап.
		Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
		И в таблице 'Список' я перехожу к строке:
			| "Наименование"                               |
			| "Переход с этапа на этап $$СлучайноеЧисло$$" |
		И в таблице "Список" я выбираю текущую строку
		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'		
		И таблица "Список" содержит строки по шаблону:
			| 'Триггерное событие'                         | 'Действие (описание)'         | 'Статус события'   | 'Контрагент'   | 'Взаимодействие (задача)'   | 'Объект события'         |
			| 'Переход с этапа на этап $$СлучайноеЧисло$$' | 'Поставить задачу сотруднику' | 'Зарегистрировано' | '$$Пациент$$ ' | '$$Шаблон$$ (не выполнена)' | 'Постоянный пациент № *' |
		И Я деактивировал триггер
//Проверка триггера - Задержка на этапе каждые.(Держать закоменченным до первых правок или же отработок)
//		Дано я открываю основную форму списка справочника "ТриггерныеСобытия"
//		И в таблице 'Список' я перехожу к строке:
//			| "Наименование"                                |
//			| "Задержка на этапе каждые $$СлучайноеЧисло$$" |
//		И в таблице "Список" я выбираю текущую строку
//		И В текущем окне я нажимаю кнопку командного интерфейса 'Журнал событий триггера'
