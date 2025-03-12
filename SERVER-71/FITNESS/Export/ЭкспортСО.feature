﻿#language: ru

@tree
@ExportScenarios
@IgnoreOnCIMainBuild

Функционал: Экспортные сценарии для Смешанных оплат

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: СО_Я создаю модификатор
	И Я запоминаю случайное число в переменную "Номер"
	Дано я запоминаю значение выражения '"Модификатор" + Формат($Номер$, "ЧГ=0")' в переменную "$$Модификатор$$"
	И В командном интерфейсе я выбираю "Справочники" "Номенклатура"
	И я нажимаю на кнопку с именем 'Создать'
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Модификатор членства, пакета услуг"
	И в поле с именем 'Наименование' я ввожу текст "$$Модификатор$$"
	И из выпадающего списка с именем 'МодификаторВидМодификатора' я выбираю точное значение "Изменение срока заморозок"
	И я меняю значение переключателя с именем 'МодификаторГВСЗПризнакКоличествоУказывается' на "При продаже"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЦену'
	И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст "200,00"
	И в поле с именем 'Период' я ввожу текст "01.01.2025"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'


Сценарий: СО_Я создаю менеджера 
	Дано я запоминаю строку 'МенеджерОП_Тест' в переменную "$$Менеджер$$"
	И В командном интерфейсе я выбираю "Персонал" "Сотрудники"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Фамилия' я ввожу значение выражения "$$Менеджер$$"
	И из выпадающего списка с именем 'РольПользователяВОсновнойИнформацие' я выбираю точное значение "Менеджер отдела продаж"
	И я нажимаю на кнопку с именем 'СписокДоступныеКассыКнопкаДобавить'
	И в меню формы я выбираю 'Основная касса (касса)'		
	И я нажимаю на кнопку с именем 'Записать'
	И я сохраняю навигационную ссылку текущего окна в переменную "$$СсылкаМенеджер$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Сценарий: СО_Я создаю пробный пакет услуг
	И Я запоминаю случайное число в переменную "Номер"
	Дано я запоминаю значение выражения '"ПробныйПакет" + Формат($Номер$, "ЧГ=0")' в переменную "$$ПробныйПакет$$"
	Дано Я открываю основную форму справочника "Номенклатура"
	И в поле с именем 'Наименование' я ввожу текст '$$ПробныйПакет$$'
	И из выпадающего списка с именем "ТипНоменклатуры" я выбираю точное значение 'Пакет'
	И я нажимаю кнопку выбора у поля с именем "ЧленствоПакетУслугСоставУслугУслугаСегментПолемСтрока_0"
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$УслугаПерсональная$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И в таблице "Список" я выбираю текущую строку
	И в поле с именем 'ЧленствоПакетУслугСоставУслугКоличествоПолемСтрока_0' я ввожу текст '5,00'
	И в поле с именем 'СрокДествияЧленстваПакетаУслуг' я ввожу текст '1'
	И я устанавливаю флаг с именем 'ПереключательПробныйПакетУслуг'	
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЦену'
	И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст '500'
	И в поле с именем 'Период' я ввожу текст "01.01.2000"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'

Сценарий: СО_Я создаю пробное членство
	Дано Я открываю основную форму справочника "Номенклатура"
	И Я запоминаю случайное число в переменную "Членство"
	Дано я запоминаю значение выражения '"Пробное" + Формат($Членство$, "ЧГ=0")' в переменную "$$ПробноеЧленство$$"
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Членство"
	И в поле с именем 'Наименование' я ввожу текст "$$ПробноеЧленство$$"
	И я нажимаю кнопку выбора у поля с именем 'ЧленствоПакетУслугСоставУслугУслугаСегментПолемСтрока_0'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$УслугаПерсональная$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И в поле с именем 'ЧленствоПакетУслугСоставУслугКоличествоПолемСтрока_0' я ввожу текст "10"
	И в поле с именем 'КоличествоДнейВЗаморозкеЧленстваПакетаУслуг' я ввожу текст "10"
	И в поле с именем 'ЧленствоПакетУслугКоличествоГостевыхПосещений' я ввожу текст "10"
	И в поле с именем 'СрокДествияЧленстваПакетаУслуг' я ввожу текст "2"
	И из выпадающего списка с именем 'ТипСрокаДействияЧленстваПакетаУслуг' я выбираю точное значение "День"
	И я устанавливаю флаг с именем 'ПереключательПробныйПакетУслуг'
	И я устанавливаю флаг с именем 'ЧленствоОграниченКоличествомПосещений'
	И в поле с именем 'ЧленствоКоличествоПосещений' я ввожу текст "10"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЦену'
	И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст "555"
	И в поле с именем 'Период' я ввожу текст "01.01.2000"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'

Сценарий: СО_Я создаю секцию
	И Я открываю основную форму справочника "ГруппыКлиентов"
	И Я запоминаю случайное число в переменную "Секция"
	Дано я запоминаю значение выражения '"Секция" + Формат($Секция$, "ЧГ=0")' в переменную "$$Секция$$"
	И в поле с именем 'Наименование' я ввожу текст "$$Секция$$"
	И я меняю значение переключателя с именем 'Статус' на "Активна"
	И я нажимаю на кнопку с именем '_Расписание'
	И я нажимаю кнопку выбора у поля с именем 'ПолеУслуга_0'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$УслугаГрупповая$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 5 секунд
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Сценарий: СО_Я создаю дорогую услугу
	И Я запоминаю случайное число в переменную "УслугаДорогая"
	Дано я запоминаю значение выражения '"УслугаДорогая" + Формат($УслугаДорогая$, "ЧГ=0")' в переменную "$$УслугаДорогая$$"
	Дано Я открываю основную форму справочника "Номенклатура"
	И в поле с именем 'Наименование' я ввожу текст '$$УслугаДорогая$$'
	И из выпадающего списка с именем "НормаВремениУслуг" я выбираю точное значение '30'
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЦену'
	И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст '15000'
	И в поле с именем 'Период' я ввожу текст "01.01.2000"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я сохраняю навигационную ссылку текущего окна в переменную "$$СсылкаУслугаДорогая$$"
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		
Сценарий: СО_Я создаю секционный пакет
	И Я запоминаю случайное число в переменную "Номер"
	Дано я запоминаю значение выражения '"СекционныйПакет" + Формат($Номер$, "ЧГ=0")' в переменную "$$СекционныйПакет$$"
	Дано Я открываю основную форму справочника "Номенклатура"
	И в поле с именем 'Наименование' я ввожу текст '$$СекционныйПакет$$'
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Пакет"
	И из выпадающего списка с именем 'ПакетУслугТипОпределенияКоличества' я выбираю точное значение "определяются секцией"
	И я нажимаю на кнопку с именем 'ДобавитьСтрочкуГруппыКлиентов'
	И я нажимаю кнопку выбора у поля с именем 'ГруппаКлиентовСтрока_0'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$Секция$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 5 секунд
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И в поле с именем 'СрокДествияЧленстваПакетаУслуг' я ввожу текст "1"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЦену'
	Если открылось окно "1С:Предприятие"
		И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст '2000'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	
Сценарий: СО_Я создаю рекуррентное членство
	Дано Я открываю основную форму справочника "Номенклатура"
	И Я запоминаю случайное число в переменную "Членство"
	Дано я запоминаю значение выражения '"РекуррентноеЧленство" + Формат($Членство$, "ЧГ=0")' в переменную "$$РекуррентноеЧленство$$"
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Членство"
	И в поле с именем 'Наименование' я ввожу текст "$$РекуррентноеЧленство$$"
	И я нажимаю кнопку выбора у поля с именем 'ЧленствоПакетУслугСоставУслугУслугаСегментПолемСтрока_0'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$УслугаПерсональная$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течение 20 секунд
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И в поле с именем 'ЧленствоПакетУслугСоставУслугКоличествоПолемСтрока_0' я ввожу текст "10"
	И в поле с именем 'КоличествоДнейВЗаморозкеЧленстваПакетаУслуг' я ввожу текст "10"
	И в поле с именем 'ЧленствоПакетУслугКоличествоГостевыхПосещений' я ввожу текст "10"
	И в поле с именем 'СрокДествияЧленстваПакетаУслуг' я ввожу текст "2"
	И из выпадающего списка с именем 'ТипСрокаДействияЧленстваПакетаУслуг' я выбираю точное значение "День"
	И я устанавливаю флаг с именем 'ЧленствоОграниченКоличествомПосещений'
	И в поле с именем 'ЧленствоКоличествоПосещений' я ввожу текст "10"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЦену'
	И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст "555"
	И в поле с именем 'Период' я ввожу текст "01.01.2000"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я устанавливаю флаг с именем 'ЧленствоПакетУслугРекуррентностьИспользовать'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'		

Сценарий: СО_Я проверяю xml реализации услуги "НаименованиеУслуги"
	И я закрываю все окна клиентского приложения
	И Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "[НаименованиеУслуги]"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "[НаименованиеУслуги]"
// В случае, когда продается модификатор/секционный пакет/рекуррентное членство
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$Модификатор$$"' Истинно Тогда
		И в поле с именем 'Количество' я ввожу текст "1"
		И я нажимаю на кнопку с именем 'ФормаВыбратьДанные'
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$СекционныйПакет$$"' Истинно Тогда
		И я меняю значение переключателя с именем 'ФильтрГруппПоКлиенту' на "Все"
		И в таблице 'СписокГруппыКлиентов' я выбираю текущую строку
		И я нажимаю на кнопку с именем 'ФормаВыбрать'
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$РекуррентноеЧленство$$"' Истинно Тогда
		И из выпадающего списка с именем 'СервисПлатежей' я выбираю точное значение "\'SRP: ЮКасса\'"
		И я изменяю флаг с именем 'ПлатежиОплачиваютсяВручную'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_1x0'
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_1x0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_1x0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И я проверяю закрытие смены

	И элемент формы с именем 'XML' стал равен по шаблону
	| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                                                           |
	| '<CheckPackage>'                                                                                                                                                                                                                                                                                       |
	| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                                                                       |
	| '		<AgentData/>'                                                                                                                                                                                                                                                                                       |
	| '		<VendorData/>'                                                                                                                                                                                                                                                                                      |
	| '		<CustomerDetail/>'                                                                                                                                                                                                                                                                                  |
	| '		<OperationalAttribute/>'                                                                                                                                                                                                                                                                            |
	| '		<IndustryAttribute/>'                                                                                                                                                                                                                                                                               |
	| '	</Parameters>'                                                                                                                                                                                                                                                                                       |
	| '	<Positions>'                                                                                                                                                                                                                                                                                         |
	| '		<FiscalString Name=\" [НаименованиеУслуги]\" Quantity=\"1\" PriceWithDiscount=\"$Цена$\" AmountWithDiscount=\"$Цена$\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
	| '			<IndustryAttribute/>'                                                                                                                                                                                                                                                                              |
	| '			<AgentData/>'                                                                                                                                                                                                                                                                                      |
	| '			<VendorData/>'                                                                                                                                                                                                                                                                                     |
	| '		</FiscalString>'                                                                                                                                                                                                                                                                                    |
	| '	</Positions>'                                                                                                                                                                                                                                                                                        |
	| '	<Payments Cash=\"0\" ElectronicPayment=\"0\" PrePayment=\"$Цена$\" PostPayment=\"0\" Barter=\"0\"/>'                                                                                                                                                                                       |
	| '</CheckPackage>'                                                                                                                                                                                                                                                                                      |

Сценарий: СО_Я проверяю xml реализации услуги "НаименованиеУслуги" (оплата нал и лс)
	И Я запоминаю значение выражения 'Формат(Число($Наличные$)+Число($ЛС$), "ЧГ=0")' в переменную "Цена"
	И я закрываю все окна клиентского приложения
	И Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "[НаименованиеУслуги]"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "[НаименованиеУслуги]"
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$Модификатор$$"' Истинно Тогда
		И в поле с именем 'Количество' я ввожу текст "1"
		И я нажимаю на кнопку с именем 'ФормаВыбратьДанные'
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$СекционныйПакет$$"' Истинно Тогда
		И я меняю значение переключателя с именем 'ФильтрГруппПоКлиенту' на "Все"
		И в таблице 'СписокГруппыКлиентов' я выбираю текущую строку
		И я нажимаю на кнопку с именем 'ФормаВыбрать'
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$РекуррентноеЧленство$$"' Истинно Тогда
		И из выпадающего списка с именем 'СервисПлатежей' я выбираю точное значение "\'SRP: ЮКасса\'"
		И я изменяю флаг с именем 'ПлатежиОплачиваютсяВручную'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_1x0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_1x0' я ввожу текст "100,00"
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_1x0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_1x0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я проверяю закрытие смены

	И элемент формы с именем 'XML' стал равен по шаблону:
	| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                                                           |
	| '<CheckPackage>'                                                                                                                                                                                                                                                                                       |
	| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                                                                       |
	| '		<AgentData/>'                                                                                                                                                                                                                                                                                       |
	| '		<VendorData/>'                                                                                                                                                                                                                                                                                      |
	| '		<CustomerDetail/>'                                                                                                                                                                                                                                                                                  |
	| '		<OperationalAttribute/>'                                                                                                                                                                                                                                                                            |
	| '		<IndustryAttribute/>'                                                                                                                                                                                                                                                                               |
	| '	</Parameters>'                                                                                                                                                                                                                                                                                       |
	| '	<Positions>'                                                                                                                                                                                                                                                                                         |
	| '		<FiscalString Name=\" [НаименованиеУслуги]\" Quantity=\"1\" PriceWithDiscount=\"$Цена$\" AmountWithDiscount=\"$Цена$\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
	| '			<IndustryAttribute/>'                                                                                                                                                                                                                                                                              |
	| '			<AgentData/>'                                                                                                                                                                                                                                                                                      |
	| '			<VendorData/>'                                                                                                                                                                                                                                                                                     |
	| '		</FiscalString>'                                                                                                                                                                                                                                                                                    |
	| '	</Positions>'                                                                                                                                                                                                                                                                                        |
	| '	<Payments Cash=\"$Наличные$\" ElectronicPayment=\"0\" PrePayment=\"$ЛС$\" PostPayment=\"0\" Barter=\"0\"/>'                                                                                                                                                                                       |
	| '</CheckPackage>'                                                                                                                                                                                                                                                                                      |

Сценарий: СО_Я проверяю xml реализации услуги "НаименованиеУслуги" (оплата нал и бонусы)
	// Объявление и вычисление значений переменных для проверки таблиц и xml
	Дано Я запоминаю значение выражения 'Формат(Число($Цена$)-100, "ЧГ=0")' в переменную "ЦенаСоСкидкой"
	Дано Я запоминаю значение выражения 'Формат(Число($Цена$), "ЧДЦ=2")' в переменную "ЦенаТаблица"
	Дано Я запоминаю строку '100' в переменную "СуммаСкидки"
	Дано Я запоминаю значение выражения 'Формат(Число($ЦенаСоСкидкой$), "ЧДЦ=2")' в переменную "ЦенаСоСкидкойТаблица"
	Дано Я запоминаю значение выражения '"$СуммаСкидки$" + ",00"' в переменную "СуммаСкидкиТаблица"

	И я закрываю все окна клиентского приложения
	И Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "[НаименованиеУслуги]"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "[НаименованиеУслуги]"
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$Модификатор$$"' Истинно Тогда
		И в поле с именем 'Количество' я ввожу текст "1"
		И я нажимаю на кнопку с именем 'ФормаВыбратьДанные'
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$СекционныйПакет$$"' Истинно Тогда
		И я меняю значение переключателя с именем 'ФильтрГруппПоКлиенту' на "Все"
		И в таблице 'СписокГруппыКлиентов' я выбираю текущую строку
		И я нажимаю на кнопку с именем 'ФормаВыбрать'
	Если выражение внутреннего языка '"[НаименованиеУслуги]" = "$$РекуррентноеЧленство$$"' Истинно Тогда
		И из выпадающего списка с именем 'СервисПлатежей' я выбираю точное значение "\'SRP: ЮКасса\'"
		И я изменяю флаг с именем 'ПлатежиОплачиваютсяВручную'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_2x0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_2x0' я ввожу текст "100,00"
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_2x0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_2x0'
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_2x0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И Я проверяю закрытие смены

	И элемент формы с именем 'XML' стал равен по шаблону
	| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                                                           |
	| '<CheckPackage>'                                                                                                                                                                                                                                                                                       |
	| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                                                                       |
	| '		<AgentData/>'                                                                                                                                                                                                                                                                                       |
	| '		<VendorData/>'                                                                                                                                                                                                                                                                                      |
	| '		<CustomerDetail/>'                                                                                                                                                                                                                                                                                  |
	| '		<OperationalAttribute/>'                                                                                                                                                                                                                                                                            |
	| '		<IndustryAttribute/>'                                                                                                                                                                                                                                                                               |
	| '	</Parameters>'                                                                                                                                                                                                                                                                                       |
	| '	<Positions>'                                                                                                                                                                                                                                                                                         |
	| '		<FiscalString Name=\" [НаименованиеУслуги]\" Quantity=\"1\" PriceWithDiscount=\"$ЦенаСоСкидкой$\" AmountWithDiscount=\"$ЦенаСоСкидкой$\" DiscountAmount=\"100\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"4\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
	| '			<IndustryAttribute/>'                                                                                                                                                                                                                                                                              |
	| '			<AgentData/>'                                                                                                                                                                                                                                                                                      |
	| '			<VendorData/>'                                                                                                                                                                                                                                                                                     |
	| '		</FiscalString>'                                                                                                                                                                                                                                                                                    |
	| '	</Positions>'                                                                                                                                                                                                                                                                                        |
	| '	<Payments Cash=\"$ЦенаСоСкидкой$\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"0\" Barter=\"0\"/>'                                                                                                                                                                                       |
	| '</CheckPackage>'                                                                                                                                                                                                                                                                                      |

	И таблица 'ПозицииЧека' стала равной:
	| 'Наименование'          | 'Количество' | 'Сумма скидок'         | 'Цена'          | 'Цена со скидками'       | 'Сумма'                  | 'Номер секции' | 'Признак предмета расчета' | 'Ставка НДС' | 'Сумма НДС' | 'Штрихкод' | 'Признак способа расчета'   |
	| ' [НаименованиеУслуги]' | '1,00'       | '$СуммаСкидкиТаблица$' | '$ЦенаТаблица$' | '$ЦенаСоСкидкойТаблица$' | '$ЦенаСоСкидкойТаблица$' | '1'            | 'Услуга'                   | ''           | ''          | ''         | 'Передача с полной оплатой' |

	И таблица 'ТаблицаОплат' стала равной:
	| 'Тип оплаты'      | 'Сумма'                  |
	| 'Наличная оплата' | '$ЦенаСоСкидкойТаблица$' |

Сценарий: СО_Я проверяю оплату с рассрочкой
	И я закрываю все окна клиентского приложения
	И Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$УслугаПерсональная$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$УслугаПерсональная$$"		
	И я нажимаю на кнопку с именем '_СхемаРассрочки'
	И из выпадающего списка с именем 'ШаблонРассрочки' я выбираю по строке "$$ШаблонРассрочки$$"
	И я нажимаю на кнопку с именем 'КнопкаОплатитьРеализацию'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' заполнено
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И я проверяю закрытие смены

	Тогда элемент формы с именем 'XML' стал равен по шаблону:
		| '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'                                                                                                                                                                                                                        |
		| '<CheckPackage>'                                                                                                                                                                                                                                                    |
		| '	<Parameters CashierName=\"*\" OperationType=\"1\" TaxationSystem=\"0\" CustomerEmail=\"\" CustomerPhone=\"\">'                                                                                                                                                    |
		| '		<AgentData/>'                                                                                                                                                                                                                                                    |
		| '		<VendorData/>'                                                                                                                                                                                                                                                   |
		| '		<CustomerDetail/>'                                                                                                                                                                                                                                               |
		| '		<OperationalAttribute/>'                                                                                                                                                                                                                                         |
		| '		<IndustryAttribute/>'                                                                                                                                                                                                                                            |
		| '	</Parameters>'                                                                                                                                                                                                                                                    |
		| '	<Positions>'                                                                                                                                                                                                                                                      |
		| '		<FiscalString Name=\" $$УслугаПерсональная$$\" Quantity=\"1\" PriceWithDiscount=\"250\" AmountWithDiscount=\"250\" DiscountAmount=\"0\" Department=\"1\" VATRate=\"none\" PaymentMethod=\"5\" CalculationSubject=\"4\" MeasureOfQuantity=\"0\">' |
		| '			<IndustryAttribute/>'                                                                                                                                                                                                                                           |
		| '			<AgentData/>'                                                                                                                                                                                                                                                   |
		| '			<VendorData/>'                                                                                                                                                                                                                                                  |
		| '		</FiscalString>'                                                                                                                                                                                                                                                 |
		| '	</Positions>'                                                                                                                                                                                                                                                     |
		| '	<Payments Cash=\"125\" ElectronicPayment=\"0\" PrePayment=\"0\" PostPayment=\"125\" Barter=\"0\"/>'                                                                                                                                                               |
		| '</CheckPackage>'                                                                                                                                                                                                                                                   |
	И таблица 'ПозицииЧека' стала равной:
		| 'Наименование'            | 'Количество' | 'Сумма скидок' | 'Цена'   | 'Цена со скидками' | 'Сумма'  | 'Номер секции' | 'Признак предмета расчета' | 'Ставка НДС' | 'Сумма НДС' | 'Штрихкод' | 'Признак способа расчета'      |
		| ' $$УслугаПерсональная$$' | '1,00'       | ''             | '250,00' | '250,00'           | '250,00' | '1'            | 'Услуга'                   | ''           | ''          | ''         | 'Передача с частичной оплатой' |
	И таблица 'ТаблицаОплат' стала равной:
		| 'Тип оплаты'          | 'Сумма'  |
		| 'Наличная оплата'     | '125,00' |
		| 'Постоплата (кредит)' | '125,00' |


	
		

