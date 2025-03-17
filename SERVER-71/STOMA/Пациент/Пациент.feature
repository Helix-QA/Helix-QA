﻿#language: ru

@tree

Функционал: Пациент

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Пациент
Переменные
	// --- Объявление переменных ---
	И я удаляю все переменные
	// Основная информация
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "Имя"
	И Я запоминаю значение выражения '"Имя" + Формат($Имя$, "ЧГ=0")' в переменную "Имя"
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "Фамилия"
	И Я запоминаю значение выражения '"Фамилия" + Формат($Фамилия$, "ЧГ=0")' в переменную "Фамилия"
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "Отчество"
	И Я запоминаю значение выражения '"Отчество" + Формат($Отчество$, "ЧГ=0")' в переменную "Отчество"
	И я запоминаю случайную дату рождения в переменную "ДатаРождения"
	И я запоминаю случайный ИНН физического лица в переменную "$ИНН$"
	И я запоминаю случайный СНИЛС в переменную "$СтраховойНомерПФР$"
	И я запоминаю случайное число в переменную "$РеестровыйНомерОМС$"
	// Контактная информация
	И я запоминаю случайное число в переменную "Email"
	И Я запоминаю значение выражения 'Формат($Email$, "ЧГ=0") + "@mail.com"' в переменную "Email"
	И Я запоминаю случайное число в переменную "НомерТелефона"
	И Я запоминаю случайное число в переменную "Моб. приложение"
	// Удостоверение личности
	И я запоминаю случайное число в переменную "Серия"
	И Я запоминаю случайное число в переменную "КодПодразделения"
	И я запоминаю случайное число в переменную "Номер"
	И Я запоминаю значение выражения 'Формат(ТекущаяДата()-86400, "ДЛФ=Д")' в переменную "ДатаВыдачи"

Создание элемента
	И я закрываю все окна клиентского приложения
	И В командном интерфейсе я выбираю "Лечение" "Пациенты"
	И я нажимаю на кнопку с именем 'Создать'
	//ФИО, дата рождения
	И в поле с именем 'Фамилия' я ввожу текст "$Фамилия$"
	И в поле с именем 'Имя' я ввожу текст "$Имя$"
	И в поле с именем 'Отчество' я ввожу текст "$Отчество$"
	И в поле с именем 'ДатаРождения' я ввожу текст "$ДатаРождения$"
	// Контактная информация
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Email'
	И в поле с именем 'ПредставлениеКИ_2' я ввожу текст "$Email$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Моб. приложение'
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Телефон'
	И в поле с именем 'ПредставлениеКИ_0' я ввожу текст "$НомерТелефона$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Skype'
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Соц. сеть'
	И в поле с именем 'ПредставлениеКИ_1' я ввожу текст "город"
	И я нажимаю на кнопку с именем 'КнопкаМ_0'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	Тогда открылось окно " (Пациент)"
	И я изменяю флаг с именем 'НедееспособныйГражданин'
	//Удостоверение личности
	И из выпадающего списка с именем 'ВидДокумента' я выбираю точное значение "Паспорт гражданина Российской Федерации"
	И в поле с именем 'Серия' я ввожу текст "$Серия$"
	И в поле с именем 'КодПодразделения' я ввожу текст "$КодПодразделения$"
	И в поле с именем 'Номер' я ввожу текст "$Номер$"
	И в поле с именем 'ДатаВыдачи' я ввожу текст "$ДатаВыдачи$"
	И я перехожу к следующему реквизиту
	И в поле с именем 'КемВыдан' я ввожу текст "Отделом внутренних дел России"
	//ИНН, СНИЛС, место работы
	И в поле с именем 'ИНН' я ввожу текст "$ИНН$"
	И в поле с именем 'СтраховойНомерПФР' я ввожу текст "$СтраховойНомерПФР$"
	И в поле с именем 'МестоРаботы' я ввожу текст "работа"
	//медкарта, родственники,полисы,карты,скидки, ЛС
	И я нажимаю на кнопку с именем 'ДобавитьМедКарту'
	И Я закрываю окно "Медицинская карта (создание)"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьРодственника'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И Я закрываю окно "Родственники (создание)"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьПолис'
	И Я закрываю окно "Полис медицинского страхования (создание)"
	И я нажимаю на кнопку с именем 'ПоказатьВсеПолисы'
	И Я закрываю окно "Полисы медицинского страхования"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКарту'
	И Я закрываю окно "Карта (создание)"
	И я нажимаю на кнопку с именем 'ДобавитьСкидку'
	И Я закрываю окно "Маркетинговые акции"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЛицевыеБонусныеСчета'
	И Я закрываю окно "Взнос на лицевой счет"
	//соцстатус
	И я нажимаю кнопку выбора у поля с именем 'СоциальнаяГруппа'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю кнопку выбора у поля с именем 'СоциальныйСтатус'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И в поле с именем 'Организация' я ввожу текст "организация"
	//маркетинг
	И я нажимаю кнопку выбора у поля с именем 'Куратор'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю кнопку выбора у поля с именем 'ИсточникИнформации'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю кнопку выбора у поля с именем 'КаналПривлечения'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	//медпоказания
	И в поле с именем 'АллергическиеРеакции' я ввожу текст "нет"
	И из выпадающего списка с именем 'ГруппаКрови' я выбираю точное значение "1-ая группа крови, резус-фактор отрицательный"
	//Дополнительно
	И я разворачиваю группу с именем 'ГруппаДополнительно'
	И в поле с именем 'РеестровыйНомерОМС' я ввожу текст "$РеестровыйНомерОМС$"
	И в поле с именем 'Комментарий' я ввожу текст "комментарий"
	//Правая колонка
	И я нажимаю на кнопку с именем 'ДобавитьПредварительнуюЗапись'
	И Я закрываю окно "Журнал записи"
	И я нажимаю на кнопку с именем 'ЗаписатьсяНаПрием'
	И Я закрываю окно "Прием начат (Центр Стоматологической Имплантологии)"
	И я нажимаю на кнопку с именем 'ДобавитьВЛистОжидания'
	И Я закрываю окно "Запись в лист ожидания"
	И я нажимаю на кнопку с именем 'СоздатьПланЛечения'
	И Я закрываю окно "План лечения (создание)"
	И я нажимаю на кнопку с именем 'ДобавитьЗадачу'
	И в меню формы я выбираю 'Звонок входящий'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'ДобавитьЗадачу'
	И в меню формы я выбираю 'Звонок исходящий'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'ДобавитьЗадачу'
	И в меню формы я выбираю 'Онлайн-заявка'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'ДобавитьЗадачу'
	И в меню формы я выбираю 'Прочее'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'ДобавитьЗаметку'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'СоздатьSMSPush'
	И Я закрываю окно "Отправка сообщения"	
	И я нажимаю на кнопку с именем 'КнопкаСоздатьСделку'
	И в меню формы я выбираю 'Новый пациент'
	И я нажимаю на кнопку с именем 'КнопкаСоздатьСделку'
	И в меню формы я выбираю 'Постоянный пациент'
//командная панель	
	И я нажимаю на кнопку с именем 'ПечатьСправкиВНалоговую'
	И Я закрываю окно "Справки в налоговую (список)"
	И я нажимаю на кнопку с именем 'ФормаДокументаПечать'
	И Я закрываю окно "Печать документов"
	И я нажимаю на кнопку с именем 'КнопкаИстория'
	И Я закрываю окно "История"
	И я нажимаю на кнопку с именем 'КнопкаВывестиНастройкаФормы'
	И Я закрываю окно 'Настройка формы'
	И я нажимаю на кнопку с именем 'ОбязательныеПоля'
	И Я закрываю окно "Обязательные поля"
	И я нажимаю на кнопку с именем 'ОбъединениеКлиентов'
	И Я закрываю окно "Объединение пациентов"
	И я нажимаю на кнопку с именем 'РедактироватьСоставСвойств'
	И Я закрываю окно "Доп. свойства справочника \"Пациенты\" (Набор свойств)"
	И я нажимаю на кнопку с именем 'ДопСведения'
	И Я закрываю окно "Дополнительные сведения: $Фамилия$ $Имя$ $Отчество$: Редактирование значений свойств"
	//вкладки в карточке
	И В текущем окне я нажимаю кнопку командного интерфейса "Взаиморасчеты"
	И в табличном документе 'ТабличныйДокумент' я перехожу к ячейке "R1C1"
	И я нажимаю на кнопку с именем 'Сформировать'
	И В текущем окне я нажимаю кнопку командного интерфейса "Лицевой счет"
	И я нажимаю на кнопку с именем 'Сформировать'
	И В текущем окне я нажимаю кнопку командного интерфейса "История приемов"
	И я нажимаю кнопку выбора у поля с именем 'ОтборНаГлавнойЗуб'
	И я нажимаю кнопку выбора у поля с именем 'ОтборНаГлавнойСтрЕдиница'
	И Я закрываю окно "Выбор клиники"
	И В текущем окне я нажимаю кнопку командного интерфейса "Зубная формула"
	И В текущем окне я нажимаю кнопку командного интерфейса "Планы лечения"
	И В текущем окне я нажимаю кнопку командного интерфейса "Планируемые оплаты"
	И я нажимаю на кнопку с именем 'Сформировать'
	И В текущем окне я нажимаю кнопку командного интерфейса "Оценки и отзывы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Сегменты"
	И я нажимаю на кнопку с именем 'ДобавитьВСегмент'
	И Я закрываю окно "Сегменты пациентов"
	И В текущем окне я нажимаю кнопку командного интерфейса "Гарантии"
	И В текущем окне я нажимаю кнопку командного интерфейса "Договоры c пациентом"
	И я нажимаю на кнопку с именем 'ФормаКомандаСоздать'
	И Я закрываю окно "Договор с пациентом (создание)"
	И В текущем окне я нажимаю кнопку командного интерфейса "История звонков"
	И В текущем окне я нажимаю кнопку командного интерфейса "Снимки"
	И В текущем окне я нажимаю кнопку командного интерфейса "Файлы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	