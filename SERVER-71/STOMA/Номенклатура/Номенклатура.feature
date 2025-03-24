﻿#language: ru

@tree

Функционал: Номенклатура

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Номенклатура
Переменные
	// --- Объявление переменных ---
	И я удаляю все переменные
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "Товар"
	И Я запоминаю значение выражения '"Товар" + Формат($Товар$, "ЧГ=0")' в переменную "Товар"
	И я запоминаю случайное число в переменную "Артикул1"
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "Материал"
	И Я запоминаю значение выражения '"Материал" + Формат($Материал$, "ЧГ=0")' в переменную "Материал"
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "Услуга"
	И Я запоминаю значение выражения '"Услуга" + Формат($Услуга$, "ЧГ=0")' в переменную "Услуга"
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "Сертификат"
	И Я запоминаю значение выражения '"Сертификат" + Формат($Сертификат$, "ЧГ=0")' в переменную "Сертификат"
	И я запоминаю случайное число в диапазоне от "100" до "999" в переменную "СерияСерт"
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "Имущество"
	И Я запоминаю значение выражения '"Имущество" + Формат($Имущество$, "ЧГ=0")' в переменную "Имущество"

Создание элемента Товар
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму справочника "Номенклатура"
	//Левая колонка
	И в поле с именем 'Наименование' я ввожу текст "$Товар$"
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Товар"
	И в поле с именем 'Артикул1' я ввожу текст "$Артикул1$"
	И я нажимаю кнопку выбора у поля с именем 'Специализация'
	И Я закрываю окно "Специализации"
	И я нажимаю кнопку выбора у поля с именем 'ЕдиницаИзмерения'
	И Я закрываю окно "Классификатор единиц измерения"
	И я нажимаю кнопку выбора у поля с именем 'УпаковкаПоУмолчанию'
	И я изменяю флаг с именем 'ИспользоватьПартии'
	И я изменяю флаг с именем 'ИспользоватьПартии'
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'Родитель'
	И Я закрываю окно "Номенклатура"
	И я нажимаю кнопку выбора у поля с именем 'ГруппаНалогообложения'
	И Я закрываю окно "Группы налогообложения"
	//Правая колонка
	И я нажимаю на кнопку с именем 'ДобавитьЦенуНоменклатуры'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст "100,00"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'ДобавитьЦенуНоменклатуры'
	И из выпадающего списка с именем 'ВидЦен' я выбираю по строке "закупочная"
	И в поле с именем 'Цена' я ввожу текст "10,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я изменяю флаг с именем 'СкидкиЗапрещены'
	И я изменяю флаг с именем 'СкидкиЗапрещены'
	//Командная панель
	И я нажимаю на кнопку с именем 'КнопкаВывестиНастройкаФормы'
	И Я закрываю окно "Настройка формы"
	И я нажимаю на кнопку с именем 'КнопкаИстория'
	И Я закрываю окно "История"
	И я нажимаю на кнопку с именем 'РедактироватьСоставСвойств'
	И Я закрываю окно "Доп. свойства справочника \"Номенклатура\" (Набор свойств)"
	И я нажимаю на кнопку с именем 'ДопСведения'
	И Я закрываю окно "Дополнительные сведения: $Товар$: Редактирование значений свойств"
	И я нажимаю на кнопку с именем 'ПодключаемыеКоманды_Авто_8F1EFAB8833959A7E3F4EEDE5AB201D4'
	//Вкладки
	И В текущем окне я нажимаю кнопку командного интерфейса "Сотрудники по услуге"
	И В текущем окне я нажимаю кнопку командного интерфейса "Нормы списания материалов"
	И В текущем окне я нажимаю кнопку командного интерфейса "Характеристики, серии"
	И В текущем окне я нажимаю кнопку командного интерфейса "Штрихкоды"
	И я нажимаю на кнопку с именем 'Создать'
	И я нажимаю на кнопку с именем 'НовыйШтрихкод'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И В текущем окне я нажимаю кнопку командного интерфейса "Упаковки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Остатки "
	И в табличном документе 'ОтчетТабличныйДокумент' я перехожу к ячейке "R1C1:R2C1"
	И я нажимаю на кнопку с именем 'Сформировать'
	И В текущем окне я нажимаю кнопку командного интерфейса "Сегменты"
	И В текущем окне я нажимаю кнопку командного интерфейса "Крит. остатки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Изменяемые состояния зубной формулы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Создание элемента Материал
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму справочника "Номенклатура"
	//Левая колонка
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Материал"
	И в поле с именем 'Наименование' я ввожу текст "$Материал$"
	И в поле с именем 'Артикул1' я ввожу текст "$Артикул1$"
	И я нажимаю кнопку выбора у поля с именем 'Специализация'
	И Я закрываю окно "Специализации"
	И я нажимаю кнопку выбора у поля с именем 'ЕдиницаИзмерения'
	И Я закрываю окно "Классификатор единиц измерения"
	И я нажимаю кнопку выбора у поля с именем 'УпаковкаПоУмолчанию'
	И я нажимаю кнопку выбора у поля с именем 'УпаковкаДляОтчета'
	И я изменяю флаг с именем 'ИспользоватьПартии'
	И я изменяю флаг с именем 'ИспользоватьПартии'
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'Родитель'
	И Я закрываю окно "Номенклатура"
	И я нажимаю кнопку выбора у поля с именем 'ГруппаНалогообложения'
	И Я закрываю окно "Группы налогообложения"
	//Правая колонка
	И я нажимаю на кнопку с именем 'ДобавитьЦенуНоменклатуры'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И из выпадающего списка с именем 'ВидЦен' я выбираю точное значение "Закупочная цена"
	И в поле с именем 'Цена' я ввожу текст "10,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я изменяю флаг с именем 'СкидкиЗапрещены'
	И я изменяю флаг с именем 'СкидкиЗапрещены'
	//вкладки
	И В текущем окне я нажимаю кнопку командного интерфейса "Сотрудники по услуге"
	И В текущем окне я нажимаю кнопку командного интерфейса "Нормы списания материалов"
	И В текущем окне я нажимаю кнопку командного интерфейса "Характеристики, серии"
	И В текущем окне я нажимаю кнопку командного интерфейса "Штрихкоды"
	//Упаковка
	И В текущем окне я нажимаю кнопку командного интерфейса "Упаковки"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "Упаковка для материала 100шт"
	И в поле с именем 'Коэффициент' я ввожу текст "100,000"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	//остальные вкладки
	И В текущем окне я нажимаю кнопку командного интерфейса "Остатки "
	И в табличном документе 'ОтчетТабличныйДокумент' я перехожу к ячейке "R1C1:R2C1"
	И я нажимаю на кнопку с именем 'Сформировать'
	И В текущем окне я нажимаю кнопку командного интерфейса "Сегменты"
	И В текущем окне я нажимаю кнопку командного интерфейса "Крит. остатки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Изменяемые состояния зубной формулы"
	//заполнение упаковки в основной инф-ции
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю кнопку выбора у поля с именем 'УпаковкаПоУмолчанию'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И из выпадающего списка с именем 'УпаковкаДляОтчета' я выбираю точное значение "Упаковка для материала 100шт"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Создание элемента Услуга
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму справочника "Номенклатура"
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Услуга"
	И в поле с именем 'Наименование' я ввожу текст "$Услуга$"
	И я нажимаю кнопку выбора у поля с именем 'Специализация'
	И в таблице 'Список' я выбираю текущую строку
	И я меняю значение переключателя с именем 'КодУслуги' на "№1 (недорогостоящие)"
	И я меняю значение переключателя с именем 'КодУслуги' на "№2 (дорогостоящие)"
	И я меняю значение переключателя с именем 'КодУслуги' на "Нет"
	И я меняю значение переключателя с именем 'КодУслуги' на "№1 (недорогостоящие)"
	И я нажимаю кнопку выбора у поля с именем 'НоменклатураМедицинскихУслуг'
	И Я закрываю окно "Классификатор номенклатуры медицинских услуг"
	И в поле с именем 'Гарантия' я ввожу текст "3"
	И из выпадающего списка с именем 'НормаВремени' я выбираю точное значение "60"
	И я устанавливаю флаг с именем 'УчитыватьЛучевуюНагрузку'
	И я снимаю флаг с именем 'УчитыватьЛучевуюНагрузку'
	И я устанавливаю флаг с именем 'ОбязательноУказаниеАссистента'
	И я снимаю флаг с именем 'ОбязательноУказаниеАссистента'
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'Родитель'
	И Я закрываю окно "Номенклатура"
	И я нажимаю кнопку выбора у поля с именем 'ГруппаНалогообложения'
	И Я закрываю окно "Группы налогообложения"
	И я нажимаю на кнопку с именем 'ДобавитьЦенуНоменклатуры'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст "100,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я устанавливаю флаг с именем 'СкидкиЗапрещены'
	И я снимаю флаг с именем 'СкидкиЗапрещены'
	И я устанавливаю флаг с именем 'ОнлайнЗапись'
	И я перехожу к закладке с именем 'ГруппаНастройкаОнлайнЗаписи'
	И я перехожу к закладке с именем 'ГруппаНастройкаОнлайнЗаписи'
	И я нажимаю кнопку выбора у поля с именем 'ГруппаОнлайнЗаписи'
	И Я закрываю окно "Группы онлайн-записи"
	И я снимаю флаг с именем 'ОнлайнЗапись'
	И я нажимаю на кнопку с именем 'ДобавитьУстанавливаемыеСостояния'
	И в таблице 'УстанавливаемыеСостоянияЗубнойФормулы' я нажимаю кнопку выбора у реквизита с именем 'УстанавливаемыеСостоянияЗубнойФормулыСостояниеЗубнойФормулы'
	И Я закрываю окно "Состояния зубной формулы"
	И в таблице 'УстанавливаемыеСостоянияЗубнойФормулы' я завершаю редактирование строки
	И в таблице 'УстанавливаемыеСостоянияЗубнойФормулы' я удаляю строку
	И я нажимаю на кнопку с именем 'ДобавитьСнимаемыеСостояния'
	И в таблице 'СнимаемыеСостоянияЗубнойФормулы' я нажимаю кнопку выбора у реквизита с именем 'СнимаемыеСостоянияЗубнойФормулыСостояниеЗубнойФормулы'
	И Я закрываю окно "Состояния зубной формулы"
	И в таблице 'СнимаемыеСостоянияЗубнойФормулы' я завершаю редактирование строки
	И в таблице 'СнимаемыеСостоянияЗубнойФормулы' я удаляю строку
	И В текущем окне я нажимаю кнопку командного интерфейса "Сотрудники по услуге"
	//Нормы списания
	И В текущем окне я нажимаю кнопку командного интерфейса "Нормы списания материалов"
	И я нажимаю на кнопку с именем 'Создать'
	И в таблице 'ТаблицаНормыСписанияМатериалов' из выпадающего списка с именем 'ТаблицаНормыСписанияМатериаловМатериал' я выбираю по строке "$Материал$"
	И в таблице 'ТаблицаНормыСписанияМатериалов' я активизирую поле с именем 'ТаблицаНормыСписанияМатериаловКоличество'
	И в таблице 'ТаблицаНормыСписанияМатериалов' в поле с именем 'ТаблицаНормыСписанияМатериаловКоличество' я ввожу текст "2,000"
	И в таблице 'ТаблицаНормыСписанияМатериалов' я активизирую поле с именем 'ТаблицаНормыСписанияМатериаловНеЗависитОтКоличестваУслуг'
	И в таблице 'ТаблицаНормыСписанияМатериалов' я изменяю флаг с именем 'ТаблицаНормыСписанияМатериаловНеЗависитОтКоличестваУслуг'
	И в таблице 'ТаблицаНормыСписанияМатериалов' я активизирую поле с именем 'ТаблицаНормыСписанияМатериаловСписыватьМатериал'
	И в таблице 'ТаблицаНормыСписанияМатериалов' я выбираю текущую строку
	И в таблице 'ТаблицаНормыСписанияМатериалов' из выпадающего списка с именем 'ТаблицаНормыСписанияМатериаловСписыватьМатериал' я выбираю точное значение "Склада"
	И в таблице 'ТаблицаНормыСписанияМатериалов' я активизирую поле с именем 'ТаблицаНормыСписанияМатериаловВключатьВСтоимостьУслуги'
	И в таблице 'ТаблицаНормыСписанияМатериалов' я изменяю флаг с именем 'ТаблицаНормыСписанияМатериаловВключатьВСтоимостьУслуги'
	И в таблице 'ТаблицаНормыСписанияМатериалов' я активизирую поле с именем 'ТаблицаНормыСписанияМатериаловВидЦен'
	И В текущем окне я нажимаю кнопку командного интерфейса "Характеристики, серии"
	И В текущем окне я нажимаю кнопку командного интерфейса "Штрихкоды"
	И В текущем окне я нажимаю кнопку командного интерфейса "Упаковки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Остатки "
	И в табличном документе 'ОтчетТабличныйДокумент' я перехожу к ячейке "R1C1:R2C1"
	И В текущем окне я нажимаю кнопку командного интерфейса "Сегменты"
	И В текущем окне я нажимаю кнопку командного интерфейса "Крит. остатки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Изменяемые состояния зубной формулы"
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	И я нажимаю кнопку выбора у поля с именем 'СостояниеЗубнойФормулы'
	И Я закрываю окно "Состояния зубной формулы"
	И Я закрываю окно "Изменяемые состояния зубной формулы (создание)"
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	Когда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Создание элемента Подарочный сертификат
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму справочника "Номенклатура"
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Подарочный сертификат"
	И в поле с именем 'Наименование' я ввожу текст "$Сертификат$"
	И из выпадающего списка с именем 'ВидНоминала' я выбираю точное значение "Фиксированный"
	И в поле с именем 'Номинал' я ввожу текст "1 000,00"
	И я изменяю флаг с именем 'ВестиСерийныеНомера'
	И я нажимаю на гиперссылку с именем 'ПерейтиНаСерииСертификатов'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "$СерияСерт$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я изменяю флаг с именем 'СертификатМногоразовоеИспользование'
	И я изменяю флаг с именем 'ЭтоИменнойСертификат'
	И из выпадающего списка с именем 'СрокДействия' я выбираю точное значение "Без ограничения срока"
	И я нажимаю кнопку выбора у поля с именем 'Специализация'
	И Я закрываю окно "Специализации"
	И я нажимаю кнопку выбора у поля с именем 'ЕдиницаИзмерения'
	И Я закрываю окно "Классификатор единиц измерения"
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'Родитель'
	И Я закрываю окно "Номенклатура"
	И я нажимаю на кнопку с именем 'ДобавитьЦенуНоменклатуры'
	И в поле с именем 'Цена' я ввожу текст "1 000,00"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я изменяю флаг с именем 'СкидкиЗапрещены'
	И я изменяю флаг с именем 'СкидкиЗапрещены'
	И я нажимаю на кнопку с именем 'Бесплатно'
	И я нажимаю на кнопку с именем 'Бесплатно'
	И я нажимаю на гиперссылку с именем 'ИсторияИзмененияСтатуса'
	И Я закрываю окно "Статусы продаж номенклатуры"
	И я изменяю флаг с именем 'СтатусПродажиНоменклатуры'
	И я изменяю флаг с именем 'СтатусПродажиНоменклатуры'
	//Вкладки
	И В текущем окне я нажимаю кнопку командного интерфейса "Сотрудники по услуге"
	И В текущем окне я нажимаю кнопку командного интерфейса "Нормы списания материалов"
	И я меняю значение переключателя с именем 'ОбщиеНормыСписания' на "Общие нормы"
	И я меняю значение переключателя с именем 'ОбщиеНормыСписания' на "Индивидуальные нормы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Характеристики, серии"
	И В текущем окне я нажимаю кнопку командного интерфейса "Штрихкоды"
	И я нажимаю на кнопку с именем 'Создать'
	И я нажимаю на кнопку с именем 'НовыйШтрихкод'
	И в поле с именем 'ПартииНоменклатуры' я ввожу текст "$СерияСерт$"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И В текущем окне я нажимаю кнопку командного интерфейса "Упаковки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Остатки "
	И в табличном документе 'ОтчетТабличныйДокумент' я перехожу к ячейке "R1C1:R2C1"
	И я нажимаю на кнопку с именем 'Сформировать'
	И В текущем окне я нажимаю кнопку командного интерфейса "Сегменты"
	И я нажимаю на кнопку с именем 'ДобавитьВСегмент'
	И Я закрываю окно "Сегменты номенклатуры"
	И В текущем окне я нажимаю кнопку командного интерфейса "Крит. остатки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Изменяемые состояния зубной формулы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	//Командная панель
	И я нажимаю на кнопку с именем 'КнопкаВывестиНастройкаФормы'
	И Я закрываю окно "Настройка формы"
	И я нажимаю на кнопку с именем 'КнопкаИстория'
	И Я закрываю окно "История"
	И я нажимаю на кнопку с именем 'РедактироватьСоставСвойств'
	И Я закрываю окно "Доп. свойства справочника \"Номенклатура\" (Набор свойств)"
	И я нажимаю на кнопку с именем 'ДопСведения'
	И Я закрываю окно "Дополнительные сведения: $Сертификат$: Редактирование значений свойств"
	И я нажимаю на кнопку с именем 'ПодключаемыеКоманды_Авто_8F1EFAB8833959A7E3F4EEDE5AB201D4'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Создание элемента Имущество
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму справочника "Номенклатура"
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Имущество"
	И в поле с именем 'Наименование' я ввожу текст "$Имущество$"
	И в поле с именем 'Артикул1' я ввожу текст "$Артикул1$"
	И я нажимаю кнопку выбора у поля с именем 'Специализация'
	И Я закрываю окно "Специализации"
	И я нажимаю кнопку выбора у поля с именем 'ЕдиницаИзмерения'
	И Я закрываю окно "Классификатор единиц измерения"
	И я нажимаю кнопку выбора у поля с именем 'УпаковкаПоУмолчанию'
	И я изменяю флаг с именем 'ИспользоватьПартии'
	И я изменяю флаг с именем 'ИспользоватьПартии'
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'Родитель'
	И Я закрываю окно "Номенклатура"
	И я нажимаю кнопку выбора у поля с именем 'ГруппаНалогообложения'
	И Я закрываю окно "Группы налогообложения"
	И я нажимаю на кнопку с именем 'Бесплатно'
	И я нажимаю на кнопку с именем 'Бесплатно'
	И я изменяю флаг с именем 'СтатусПродажиНоменклатуры'
	И я изменяю флаг с именем 'СтатусПродажиНоменклатуры'
	И я нажимаю на кнопку с именем 'ДобавитьЦенуНоменклатуры'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И в поле с именем 'Цена' я ввожу текст "100,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на гиперссылку с именем 'ИсторияИзмененияСтатуса'
	И Я закрываю окно "Статусы продаж номенклатуры"
	//Вкладки
	И В текущем окне я нажимаю кнопку командного интерфейса "Сотрудники по услуге"
	И В текущем окне я нажимаю кнопку командного интерфейса "Нормы списания материалов"
	И В текущем окне я нажимаю кнопку командного интерфейса "Характеристики, серии"
	И В текущем окне я нажимаю кнопку командного интерфейса "Штрихкоды"
	И В текущем окне я нажимаю кнопку командного интерфейса "Упаковки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Остатки "
	И в табличном документе 'ОтчетТабличныйДокумент' я перехожу к ячейке "R1C1:R2C1"
	И В текущем окне я нажимаю кнопку командного интерфейса "Сегменты"
	И В текущем окне я нажимаю кнопку командного интерфейса "Крит. остатки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Изменяемые состояния зубной формулы"
	//Командная панель
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю на кнопку с именем 'КнопкаВывестиНастройкаФормы'
	И Я закрываю окно "Настройка формы"
	И я нажимаю на кнопку с именем 'КнопкаИстория'
	И Я закрываю окно "История"
	И я нажимаю на кнопку с именем 'РедактироватьСоставСвойств'
	И Я закрываю окно "Доп. свойства справочника \"Номенклатура\" (Набор свойств)"
	И я нажимаю на кнопку с именем 'ДопСведения'
	И Я закрываю окно "Дополнительные сведения: $Имущество$: Редактирование значений свойств"
	И я нажимаю на кнопку с именем 'ПодключаемыеКоманды_Авто_8F1EFAB8833959A7E3F4EEDE5AB201D4'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Создание элемента Набор услуг
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму справочника "Номенклатура"
	Когда открылось окно "Номенклатура (создание)"
	И из выпадающего списка с именем 'ТипНоменклатуры' я выбираю точное значение "Набор услуг"
	И в поле с именем 'Наименование' я ввожу текст "НаборУслуг"
	И я нажимаю на кнопку с именем 'СкрытьПоказатьДополнительно'
	И я нажимаю кнопку выбора у поля с именем 'Родитель'
	Тогда открылось окно "Номенклатура"
	И Я закрываю окно "Номенклатура"
	Тогда открылось окно "Номенклатура (создание) *"
	И я нажимаю на кнопку с именем 'ДобавитьСтрокуНабора'
	И из выпадающего списка с именем 'НоменклатураСН_0' я выбираю по строке "Услуга"
	И в поле с именем 'КоличествоСН_0' я ввожу текст "2"
	И я нажимаю на кнопку с именем 'ДобавитьСтрокуНабора'
	И я нажимаю на кнопку с именем 'УдалитьСН_1'
	И я нажимаю на кнопку с именем 'КнопкаВывестиНастройкаФормы'
	И Я закрываю окно "Настройка формы"
	И я нажимаю на кнопку с именем 'КнопкаИстория'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	Тогда открылось окно "История"
	И Я закрываю окно "История"
	Тогда открылось окно "НаборУслуг (Номенклатура)"
	И я нажимаю на кнопку с именем 'РедактироватьСоставСвойств'
	Тогда открылось окно "Доп. свойства справочника \"Номенклатура\" (Набор свойств)"
	И Я закрываю окно "Доп. свойства справочника \"Номенклатура\" (Набор свойств)"
	Тогда открылось окно "НаборУслуг (Номенклатура)"
	И я нажимаю на кнопку с именем 'ДопСведения'
	Тогда открылось окно "Дополнительные сведения: НаборУслуг: Редактирование значений свойств"
	И Я закрываю окно "Дополнительные сведения: НаборУслуг: Редактирование значений свойств"
	Тогда открылось окно "НаборУслуг (Номенклатура)"
	И В текущем окне я нажимаю кнопку командного интерфейса "Сотрудники по услуге"
	И В текущем окне я нажимаю кнопку командного интерфейса "Нормы списания материалов"
	И В текущем окне я нажимаю кнопку командного интерфейса "Характеристики, серии"
	И В текущем окне я нажимаю кнопку командного интерфейса "Штрихкоды"
	И В текущем окне я нажимаю кнопку командного интерфейса "Упаковки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Остатки "
	И в табличном документе 'ОтчетТабличныйДокумент' я перехожу к ячейке "R1C1:R2C1"
	И В текущем окне я нажимаю кнопку командного интерфейса "Сегменты"
	И В текущем окне я нажимаю кнопку командного интерфейса "Крит. остатки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Изменяемые состояния зубной формулы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
		

