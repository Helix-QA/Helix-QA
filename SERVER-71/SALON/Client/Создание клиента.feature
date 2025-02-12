﻿#language: ru

@tree

Функционал: Создание клиента

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Создание клиента

	И я удаляю все переменные
 
	// Переменные ФИО
	И Я запоминаю случайное число в переменную "Имя"
	Дано я запоминаю значение выражения '"Имя" + Формат($Имя$, "ЧГ=0")' в переменную "$$Имя$$"
	И Я запоминаю случайное число в переменную "Фамилия"
	Дано я запоминаю значение выражения '"Фамилия" + Формат($Фамилия$, "ЧГ=0")' в переменную "$$Фамилия$$"
	И Я запоминаю случайное число в переменную "Отчество"
	Дано я запоминаю значение выражения '"Отчество" + Формат($Отчество$, "ЧГ=0")' в переменную "$$Отчество$$"
	
	// Переменная даты рождения
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата())' в переменную "Сегодня"
	
	// СНИЛС и ИНН
	И я запоминаю случайное число в диапазоне от "100" до "999" в переменную "СНИЛС"
	И я запоминаю случайное число в диапазоне от "10000" до "99999" в переменную "ИНН"
	
	// Переменные номера телефона
	И я запоминаю случайное число в диапазоне от "100" до "999" в переменную "Код"
	И я запоминаю случайное число в диапазоне от "100" до "999" в переменную "Доб"
	И я запоминаю случайное число в диапазоне от "10000000" до "99999999" в переменную "НомерТел"

	//Переменные контакты
	И Я запоминаю случайное число в переменную "Email"
	Дано я запоминаю значение выражения 'Формат($Email$, "ЧГ=0") + "@mail.ru" ' в переменную "$$Email$$"
	И Я запоминаю случайное число в переменную "Skype"
	И Я запоминаю случайное число в переменную "SOC"

	//Тег 
	И я запоминаю случайное число в диапазоне от "100" до "999" в переменную "Тег "

	// Удостоверение личности

	И я запоминаю случайное число в диапазоне от "10000" до "99999" в переменную "Серия"
	И я запоминаю случайное число в диапазоне от "10000" до "99999" в переменную "Номер"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата()-86400)' в переменную "Вчера"

	// Тек.Дата

	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=дд")' в переменную "День"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=ММ")' в переменную "Месяц"
	Дано Я запоминаю значение выражения 'Формат(ТекущаяДата(), "ДФ=гггг")' в переменную "Год"
	Дано Я запоминаю значение выражения '$День$.$Месяц$.$Год$' в переменную "ТекДата"

///////////////////////////////////////////////////ЗАПОЛНЕНИЕ////////////////////////////////////////////////////////////////////////////////////////////////
	
	Дано Я открываю основную форму справочника "Контрагенты"
	
	// ФИО
	И в поле с именем 'Имя' я ввожу текст '$$Имя$$'
	И в поле с именем 'Фамилия' я ввожу текст '$$Фамилия$$'
	И в поле с именем 'Отчество' я ввожу текст '$$Отчество$$'
	
	// Дата рождения
	И в поле с именем 'ДатаРождения' я ввожу текст "$Сегодня$"
	
	// СНИЛС
	И в поле с именем 'СтраховойНомерПФР' я ввожу текст "123-321-123   "
	
	// ИНН
	И в поле с именем 'ИНН' я ввожу текст "$ИНН$"
	
	// Контакты			
	И я нажимаю кнопку выбора у поля с именем "ПредставлениеКИ_0"
	И в поле с именем 'КодСтраны' я ввожу текст "7"
	И в поле с именем 'КодГорода' я ввожу текст '$Код$'
	И в поле с именем 'НомерТелефона' я ввожу текст '$НомерТел$'
	И в поле с именем 'Добавочный' я ввожу текст '$Доб$'
	И я нажимаю на кнопку с именем 'КомандаОК'			
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Email '
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Адрес '
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Skype '
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Социальная сеть '	
	И в поле с именем 'ПредставлениеКИ_1' я ввожу текст "$$Email$$"
	И в поле с именем 'ПредставлениеКИ_2' я ввожу текст "Москва"
	И я нажимаю кнопку выбора у поля с именем 'ПредставлениеКИ_2'
	И я нажимаю на кнопку с именем 'ФормаКомандаОК'

		
	И в поле с именем 'ПредставлениеКИ_3' я ввожу текст "$Skype$"
	И в поле с именем 'ПредставлениеКИ_4' я ввожу текст "$SOC$"
	
	// Тег
	И в поле с именем 'Тег' я ввожу текст "$Тег$"
	И я нажимаю на кнопку создать поля с именем 'Тег'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	
	И в поле с именем 'Тег' я ввожу текст ""

	
	// Рекламный источник
	И из выпадающего списка с именем 'ИсточникИнформации' я выбираю по строке "Работает в салоне"

	// Карта
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКарту'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'СгенерироватьКодКарты'
	И я нажимаю на кнопку с именем 'КартаДобавить'
	
	// Получаем ссылку
	И я сохраняю навигационную ссылку текущего окна в переменную "СсылкаКлиент"
	
	// Лицевые счета, авансы
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЛицевыеСчета'
	И Я закрываю окно "Взнос на лицевой счет"
	
	// Бонусные счета
	И я нажимаю на кнопку с именем 'КнопкаДобавитьБонусныеСчета'
	И Я закрываю окно "Взнос на бонусный счет"
	
	// Скидки
	И я нажимаю на кнопку с именем 'ДобавитьСкидку'
	И Я закрываю окно "Маркетинговые акции"
	
	//Реферальные промокоды
	
//	И я нажимаю на кнопку с именем 'ДобавитьПромокод'
//	И в меню формы я выбираю 'Приложение'
		
	// Удостоверение личности
	И я нажимаю на кнопку с именем 'КнопкаДобавитьУдостоверениеЛичности'
	И из выпадающего списка с именем 'ВидДокумента' я выбираю точное значение "Водительское удостоверение "	
	И в поле с именем 'Серия' я ввожу текст "$Серия$"
	И в поле с именем 'Номер' я ввожу текст "$Номер$"
	И в поле с именем 'ДатаВыдачи' я ввожу текст "$Вчера$"
	И я перехожу к следующему реквизиту
	И в поле с именем 'ДатаОкончания' я ввожу текст "$Сегодня$"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'

	// Родсвтиенники 
	И я нажимаю на кнопку с именем 'КнопкаДобавитьРодственника'
	И Я закрываю окно "Родственники (создание)"
		
	// Комментарий
	И в поле с именем 'Комментарий' я ввожу текст "тест"
	И я нажимаю на кнопку с именем 'Записать'

	// Переключаемся по ссылкам в шапке
	И В текущем окне я нажимаю кнопку командного интерфейса "Статистика"
	И В текущем окне я нажимаю кнопку командного интерфейса "Оценки и отзывы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Договоры"
	И В текущем окне я нажимаю кнопку командного интерфейса "Файлы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Пакеты услуг"
	И В текущем окне я нажимаю кнопку командного интерфейса "Курсы"
	И В текущем окне я нажимаю кнопку командного интерфейса "Медицинские карты"
	Если в текущем окне есть кнопка командного интерфейса "История звонков" Тогда 
		И В текущем окне я нажимаю кнопку командного интерфейса "История звонков"
	И В текущем окне я нажимаю кнопку командного интерфейса "Отчеты"
	И В текущем окне я нажимаю кнопку командного интерфейса "Промокоды"
	// Для Админа СК
	Если в текущем окне есть кнопка командного интерфейса "Сообщения" Тогда 
		И В текущем окне я нажимаю кнопку командного интерфейса "Сообщения" 
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
			

	// Переключаемся по ссыклам в взаимодействии
	И я нажимаю на кнопку с именем 'ЗаписатьсяНаВизит'
	И Я закрываю окно "Журнал *"
	И я нажимаю на кнопку с именем 'СоздатьЗаказ'
	И Я закрываю окно "Заказ покупателя (создание)"
	И я нажимаю на кнопку с именем 'СоздатьЗаметку'
	И Я закрываю окно "Редактирование заметки"
	И я нажимаю на кнопку с именем 'СоздатьПисьмо'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'СоздатьSMSPush'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'СоздатьЗадачуПрочее'
	И я нажимаю на кнопку с именем 'ДобавитьВЛистОжидания'
	И Я закрываю окно "Запись в лист ожидания"
	И я нажимаю на кнопку с именем 'ПоказатьФильтры'
	И Я закрываю окно "Фильтры:"

	// Нажимаем на фото
	И я нажимаю на гиперссылку с именем 'АдресКартинки'
	И я жду, что в сообщениях пользователю будет подстрока "Не заданы настройки веб-камеры!" в течение 5 секунд
	
	// Проверяем Согласие
	И я нажимаю на кнопку с именем 'СогласиеНаОбработкуПерсональныхДанных'
	И элемент формы с именем 'ВариантПечатиСогласия' стал равен "ВыводитьПоСубъектам"
	И элемент формы с именем 'ДатаСогласия' стал равен "$ТекДата$"
	И у элемента формы с именем 'ДатаСогласия' текст редактирования стал равен "$ТекДата$"
	И элемент формы с именем 'ДекорацияПечать' стал равен "Декорация печать"
	И элемент формы с именем 'ИнформационнаяНадписьДанныеСубъектов' стал равен "Данные субъектов можно будет заполнить непосредственно в печатной форме"
	И элемент формы с именем 'Организация' стал равен по шаблону "* "
	И элемент формы с именем 'ОтветственныйЗаОбработкуПерсональныхДанных' стал равен по шаблону "*"
	И таблица 'СубъектыПерсональныхДанных' стала равной:
		| 'Фамилия, имя, отчество'           | 'Адрес'    | 'Паспортные данные' |
		| '$$Фамилия$$ $$Имя$$ $$Отчество$$' | 'Москва' | ''                  |
	
	И Я закрываю окно "Согласие на обработку персональных данных (в соответствии с требованиями 152-ФЗ)"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	
	


	

	
			