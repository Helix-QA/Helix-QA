﻿#language: ru

@tree

Функционал: Автоматизация тестирования ролей в салоне красоты.

Контекст:
	И я закрываю все окна клиентского приложения

Сценарий: Создание пользователей
Дано я подключаю TestClient "Админ" логин "Админ" пароль ""
Переменные
	// --- Объявление переменных ---
	И я удаляю все переменные
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "МастерСК"
	И Я запоминаю значение выражения '"МастерСК" + Формат($МастерСК$, "ЧГ=0")' в переменную "$$МастерСК$$"

Включаем настройку использовать заявки
	И В командном интерфейсе я выбираю "Настройки" "Продажи и маркетинг"
	И я устанавливаю флаг "ИспользоватьЗаявки"
	И Я закрываю окно "Продажи и маркетинг"

Создание элемента Администратор салона красоты
	И Я удаляю пользователя "Администратор салона красоты"
	Дано я открываю основную форму списка справочника "Сотрудники"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "Администратор салона красоты"
	И я жду, что в таблице "Список" количество строк будет "больше или равно" 0 в течении 20 секунд
	Если в таблице "Список" количество строк "больше" 0 Тогда
		И в таблице "Список" я выбираю текущую строку
		И я устанавливаю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "Администратор салона красоты"
		И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Администратор салона красоты"
		И из выпадающего списка с именем 'ПериодОтборовАдминистратора' я выбираю точное значение "Начало текущей недели"
		//права на отчеты
		Если В таблице "Роли" поле с именем 'РолиСиноним' доступно не только для просмотра Тогда
			И я нажимаю на гиперссылку с именем 'РасширеннаяНастройкаПрав'
		И в таблице 'Роли' я активизирую поле с именем 'РолиСиноним'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"   |
			| "Нет"     | "Добавление и изменение заявок" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"                 |
			| "Нет"     | "Использование отчетов по денежным средствам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"      |
			| "Нет"     | "Использование отчетов по запасам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"       |
			| "Нет"     | "Использование отчетов по клиентам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"        |
			| "Нет"     | "Использование отчетов по персоналу" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"       |
			| "Нет"     | "Использование отчетов по продажам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"       |
			| "Нет"     | "Использование отчетов по финансам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	Если в таблице "Список" количество строк 'равно' 0 Тогда
		И я нажимаю на кнопку с именем 'Создать'
		И в поле с именем 'Фамилия' я ввожу текст "Администратор салона красоты"
		И из выпадающего списка с именем 'РольПользователяВОсновнойИнформацие' я выбираю точное значение "Администратор салона красоты"
		И я нажимаю на кнопку с именем 'ПоказатьГруппаДоступныеКассыВсплывающая'
		И в таблице 'ПодборДоступныеКассы' я активизирую поле с именем 'ПодборДоступныеКассыВыгружать'
		И в таблице 'ПодборДоступныеКассы' я изменяю флаг с именем 'ПодборДоступныеКассыВыгружать'
		И в таблице 'ПодборДоступныеКассы' я завершаю редактирование строки
		И я перехожу к закладке с именем 'ГруппаДоступныеКассыВсплывающая'
		И я устанавливаю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "Администратор салона красоты"
		И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Администратор салона красоты"
		И из выпадающего списка с именем 'ПериодОтборовАдминистратора' я выбираю точное значение "Начало текущей недели"
		//права на отчеты
		И я нажимаю на гиперссылку с именем 'РасширеннаяНастройкаПрав'
		И в таблице 'Роли' я активизирую поле с именем 'РолиСиноним'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"   |
			| "Нет"     | "Добавление и изменение заявок" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"                 |
			| "Нет"     | "Использование отчетов по денежным средствам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"      |
			| "Нет"     | "Использование отчетов по запасам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"       |
			| "Нет"     | "Использование отчетов по клиентам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"        |
			| "Нет"     | "Использование отчетов по персоналу" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"       |
			| "Нет"     | "Использование отчетов по продажам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И в таблице 'Роли' я перехожу к строке:
			| "Пометка" | "Разрешенное действие (роль)"       |
			| "Нет"     | "Использование отчетов по финансам" |
		И в таблице 'Роли' я устанавливаю флаг с именем 'РолиПометка'
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'


Создание элемента Мастер салона красоты		
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму справочника "Сотрудники"
	//Создание сотрудника
	И в поле с именем 'Фамилия' я ввожу текст "$$МастерСК$$"
	И из выпадающего списка с именем 'РольПользователяВОсновнойИнформацие' я выбираю точное значение "Мастер салона красоты"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И В командном интерфейсе я выбираю "Персонал" "Сотрудники"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$МастерСК$$"
	И я жду, что в таблице "Список" количество строк будет "больше" 0 в течении 20 секунд
	И в таблице 'Список' я выбираю текущую строку
	И я изменяю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
	И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
	И в поле с именем 'ПользовательИБИмя2' я ввожу текст "$$МастерСК$$"
	И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
	И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Мастер салона красоты"
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

    И Я создаю Услугу_Салон

Создание элемента Товаровед	
	И Я удаляю пользователя "Товаровед"	
	Дано я открываю основную форму списка справочника "Сотрудники"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "Товаровед"
	И я жду, что в таблице "Список" количество строк будет "больше или равно" 0 в течении 20 секунд
	Если в таблице "Список" количество строк "больше" 0 Тогда
		И в таблице "Список" я выбираю текущую строку
		И я устанавливаю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "Товаровед"
		И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Товаровед"
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'	
	Если в таблице "Список" количество строк 'равно' 0 Тогда
		И я нажимаю на кнопку с именем 'Создать'
		И в поле с именем 'Фамилия' я ввожу текст "Товаровед"
		И из выпадающего списка с именем 'РольПользователяВОсновнойИнформацие' я выбираю точное значение "Товаровед"
		И я устанавливаю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "Товаровед"
		И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Товаровед"
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	
		
Создание элемента Бухгалтер		
	И Я удаляю пользователя "Бухгалтер"	
	Дано я открываю основную форму списка справочника "Сотрудники"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "Бухгалтер"
	И я жду, что в таблице "Список" количество строк будет "больше или равно" 0 в течении 20 секунд
	Если в таблице "Список" количество строк "больше" 0 Тогда
		И в таблице "Список" я выбираю текущую строку
		И я устанавливаю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "Бухгалтер"
		И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Бухгалтер"
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	Если в таблице "Список" количество строк 'равно' 0 Тогда
		И я нажимаю на кнопку с именем 'Создать'
		И в поле с именем 'Фамилия' я ввожу текст "Бухгалтер"
		И из выпадающего списка с именем 'РольПользователяВОсновнойИнформацие' я выбираю точное значение "Бухгалтер"
		И я нажимаю на кнопку с именем 'ПоказатьГруппаДоступныеКассыВсплывающая'
		И в таблице 'ПодборДоступныеКассы' я активизирую поле с именем 'ПодборДоступныеКассыВыгружать'
		И в таблице 'ПодборДоступныеКассы' я изменяю флаг с именем 'ПодборДоступныеКассыВыгружать'
		И в таблице 'ПодборДоступныеКассы' я завершаю редактирование строки
		И я перехожу к закладке с именем 'ГруппаДоступныеКассыВсплывающая'
		И я устанавливаю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "Бухгалтер"
		И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Бухгалтер"
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
					
Создание элемента Руководитель	
	И Я удаляю пользователя "Руководитель"	
	Дано я открываю основную форму списка справочника "Сотрудники"
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "Руководитель"
	И я жду, что в таблице "Список" количество строк будет "больше или равно" 0 в течении 20 секунд
	Если в таблице "Список" количество строк "больше" 0 Тогда
		И в таблице "Список" я выбираю текущую строку
		И я устанавливаю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "Руководитель"
		И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Руководитель"
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	Если в таблице "Список" количество строк 'равно' 0 Тогда
		И я нажимаю на кнопку с именем 'Создать'
		И в поле с именем 'Фамилия' я ввожу текст "Руководитель"
		И из выпадающего списка с именем 'РольПользователяВОсновнойИнформацие' я выбираю точное значение "Руководитель"
		И я нажимаю на кнопку с именем 'ПоказатьГруппаДоступныеКассыВсплывающая'
		И в таблице 'ПодборДоступныеКассы' я активизирую поле с именем 'ПодборДоступныеКассыВыгружать'
		И в таблице 'ПодборДоступныеКассы' я изменяю флаг с именем 'ПодборДоступныеКассыВыгружать'
		И в таблице 'ПодборДоступныеКассы' я завершаю редактирование строки
		И я перехожу к закладке с именем 'ГруппаДоступныеКассыВсплывающая'
		И я устанавливаю флаг с именем 'ДоступКИнформационнойБазеРазрешен'
		И я нажимаю на кнопку с именем '_СвойстваПользователяИБ'
		И в поле с именем 'ПользовательИБИмя2' я ввожу текст "Руководитель"
		И я перехожу к закладке с именем 'ИмяСОтметкойНезаполненного'
		И из выпадающего списка с именем 'РольПользователя' я выбираю точное значение "Руководитель"
		И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'


Сценарий: Проверка на создание элемента.
	И Остановка если была ошибка в прошлом сценарии

Дано я подключаю TestClient "Администратор салона красоты" логин "Администратор салона красоты" пароль ""
Если открылось окно "Информация" Тогда
	И я закрываю окно "Информация"
Проверка отчетов
	И я закрываю все окна клиентского приложения
	//Отчеты CRM
	И В командном интерфейсе я выбираю "CRM" "Отчеты"
<<<<<<< HEAD
	Когда открылось окно "Отчеты CRM"
	И я нажимаю на кнопку с именем 'Вариант_4f5fd60ebbad11efbbdc0050568bbe81_Подсистема_48c06221bbad11efbbdc0050568bbe81'
	И я нажимаю на кнопку 'Конверсия первичных заявок:  Заявка ->Запись на визит -> Визит'	
	И я нажимаю на кнопку с именем 'Вариант_05bf7d7fa1c011efb5cfe89c25110e9c_Подсистема_0255b9a8a1c011efb5cfe89c25110e9c'
=======
	И я нажимаю на кнопку 'Конверсия первичных заявок:  Заявка ->Запись на визит -> Визит'
>>>>>>> 1a6d6c3d1246051811ac60f4f4fa7854c8b8aadf
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты CRM"
	  //Отчет по рассылкам
	И я нажимаю на кнопку 'Отчет по рассылкам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И я закрываю все окна клиентского приложения
	//Отчеты по продажам
	И В командном интерфейсе я выбираю "Продажи" "Отчеты"
	 //Оказанные услуги
	И я нажимаю на кнопку 'Оказанные услуги'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Оперативные записи
	И я нажимаю на кнопку 'Оперативные записи'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'InputFld' я ввожу текст "22.03.2025"
	И я нажимаю на кнопку с именем 'OK'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Оплата визитов
	И я нажимаю на кнопку 'Оплата визитов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Оплата визитов по видам оплат
	И я нажимаю на кнопку 'Оплата визитов по видам оплат'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Продажи и оплаты
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Заказы покупателей
	И я нажимаю на кнопку 'Заказы покупателей'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Оказанные услуги, продажи
	И я нажимаю на кнопку 'Оказанные услуги, продажи'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	  //Оказанные услуги, продажи по годам
	И я нажимаю на кнопку 'Оказанные услуги, продажи по годам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	  //Отгрузка и оплата по заказам
	И я нажимаю на кнопку 'Отгрузка и оплата по заказам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'InputFld' я ввожу текст "21.03.2025"
	И я нажимаю на кнопку с именем 'OK' 
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Продажи и оплаты
	И я нажимаю на кнопку 'Продажи и оплаты'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Средний чек
	И я нажимаю на кнопку 'Средний чек'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//маркетинговые акции
	И В панели открытых я выбираю "Отчеты по продажам"
	  //Движения по бонусным счетам
	И я нажимаю на кнопку 'Движения по бонусным счетам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Предоставленные скидки
	И я нажимаю на кнопку 'Предоставленные скидки'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Анализ клиентской базы
	И В панели открытых я выбираю "Отчеты по продажам"
	  //Диаграмма статусов клиентов
	И я нажимаю на кнопку 'Диаграмма статусов клиентов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	  //Отмены визитов
	И я нажимаю на кнопку 'Отмены визитов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Соотношение притока и оттока клиентов
	И я нажимаю на кнопку 'Соотношение притока и оттока клиентов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Список клиентов
	И я нажимаю на кнопку 'Список клиентов'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Статистика визитов
	И я нажимаю на кнопку 'Статистика визитов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Клиенты
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Ведомость по реализованным сертификатам
	И я нажимаю на кнопку 'Ведомость по реализованным сертификатам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Движения по лицевым счетам
	И я нажимаю на кнопку 'Движения по лицевым счетам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Оценки визитов и продаж с динамикой
	И я нажимаю на кнопку 'Оценки визитов и продаж с динамикой'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Маркетинг
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Анализ источников привлечения клиентов
	И я нажимаю на кнопку 'Анализ источников привлечения клиентов'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Салон
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Загруженность салона по часам
	И я нажимаю на кнопку 'Загруженность салона по часам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Загрузка ресурсов
	И я нажимаю на кнопку 'Загрузка ресурсов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Первичные клиенты для салона
	И я нажимаю на кнопку 'Первичные клиенты для салона'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Курсы и пакеты услуг
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Ведомость по пакетам услуг
	И я нажимаю на кнопку 'Ведомость по пакетам услуг'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по продажам"
	 //Курсы
	И я нажимаю на кнопку 'Курсы'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Планирование
	И В панели открытых я выбираю "Отчеты по продажам"
	 //План-фактный анализ продаж
	И я нажимаю на кнопку 'План-фактный анализ продаж'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Отчеты по Запасам	
	И я закрываю все окна клиентского приложения
	И В командном интерфейсе я выбираю "Запасы" "Отчеты"
	 //Заказы поставщикам
	И я нажимаю на кнопку 'Заказы поставщикам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по запасам"
	 //Критические остатки - необходимо обеспечить
	И я нажимаю на кнопку 'Критические остатки - необходимо обеспечить'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'InputFld' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'OK'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по запасам"
	 //Оборачиваемость запасов
	И я нажимаю на кнопку 'Оборачиваемость запасов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по запасам"
	 //Остатки запасов на складах в стоимостном выражении
	И я нажимаю на кнопку 'Остатки запасов на складах в стоимостном выражении'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'InputFld' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'OK'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по запасам"
	 //Товарный отчет ТОРГ-29
	И я нажимаю на кнопку 'Товарный отчет ТОРГ-29'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по запасам"
	 //Нормы списания материалов
	И я нажимаю на кнопку 'Нормы списания материалов'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по запасам"
	 //План-фактный анализ расходования материалов
	И я нажимаю на кнопку 'План-фактный анализ расходования материалов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по запасам"
	 //Ведомость по сертификатам на складах
	И я нажимаю на кнопку 'Ведомость по сертификатам на складах'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Отчеты по финансам
	И я закрываю все окна клиентского приложения	
	И В командном интерфейсе я выбираю "Финансы" "Отчеты"
	 //Анализ оплат по новым, постоянным и потерянным клиентам
	И я нажимаю на кнопку 'Анализ оплат по новым, постоянным и потерянным клиентам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по финансам"
	 //Доходы и расходы (кассовый метод)
	И я нажимаю на кнопку 'Доходы и расходы (кассовый метод)'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по финансам"
	 //Ведомость по денежным средствам
	И я нажимаю на кнопку 'Ведомость по денежным средствам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по финансам"
	 //Денежный поток
	И я нажимаю на кнопку 'Денежный поток'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по финансам"
	 //Отчет по выручке
	И я нажимаю на кнопку 'Отчет по выручке'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'InputFld' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'OK'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	//Отчеты по персоналу
	И я закрываю все окна клиентского приложения
	И В командном интерфейсе я выбираю "Персонал" "Отчеты"
	 //Расчеты с персоналом
	И я нажимаю на кнопку 'Расчеты с персоналом'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по персоналу"
	 //Расшифровка начислений и удержаний
	И я нажимаю на кнопку 'Расшифровка начислений и удержаний'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по персоналу"
	 //Сводный отчет по зарплате
	И я нажимаю на кнопку 'Сводный отчет по зарплате'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по персоналу"
	 //Загрузка рабочего времени сотрудников
	И я нажимаю на кнопку 'Загрузка рабочего времени сотрудников'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по персоналу"
	 //План-фактный анализ отработанного времени
	И я нажимаю на кнопку 'План-фактный анализ отработанного времени'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по персоналу"
	 //Возвратность клиентов
	И я нажимаю на кнопку 'Возвратность клиентов'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по персоналу"
	 //Сводный отчет по сотрудникам
	И я нажимаю на кнопку 'Сводный отчет по сотрудникам'
	И я нажимаю на гиперссылку с именем 'ПредставлениеПериода'
	И в поле с именем 'DateBegin' я ввожу текст "01.03.2025"
	И я нажимаю на кнопку с именем 'Select'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'Сформировать'
	И В панели открытых я выбираю "Отчеты по персоналу"
	 //Список сотрудников
	И я нажимаю на кнопку 'Список сотрудников'
	И я нажимаю на кнопку с именем 'Сформировать'
			
Создание Заявки
	И я закрываю все окна клиентского приложения
	Дано Я открываю основную форму справочника "Заявки"	
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "ФЗаявки"
	И Я запоминаю значение выражения '"ФЗаявки" + Формат($ФЗаявки$, "ЧГ=0")' в переменную "ФЗаявки"
	И в поле с именем 'Фамилия' я ввожу текст "$ФЗаявки$"
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "ИмяЗаявки"
	И Я запоминаю значение выражения '"ИмяЗаявки" + Формат($ИмяЗаявки$, "ЧГ=0")' в переменную "ИмяЗаявки"
	И в поле с именем 'Имя' я ввожу текст "$ИмяЗаявки$"
	И я запоминаю случайное число в диапазоне от "1000" до "9999" в переменную "ОтчетствоЗаявки"
	И Я запоминаю значение выражения '"ОтчетствоЗаявки" + Формат($ОтчетствоЗаявки$, "ЧГ=0")' в переменную "ОтчетствоЗаявки"
	И в поле с именем 'Отчество' я ввожу текст "$ОтчетствоЗаявки$"
	И Я запоминаю случайное число в переменную "НомерТелефона"
	И в поле с именем 'ПредставлениеКИ_0' я ввожу текст "$НомерТелефона$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Email '
	И я запоминаю случайное число в переменную "Email"
	И Я запоминаю значение выражения 'Формат($Email$, "ЧГ=0") + "@mail.com"' в переменную "Email"
	И в поле с именем 'ПредставлениеКИ_1' я ввожу текст "$Email$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Адрес '
	И в поле с именем 'ПредставлениеКИ_2' я  ввожу текст "город"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Skype '
	И в поле с именем 'ПредставлениеКИ_3' я ввожу текст "скайп"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьКонтактнуюИнформацию'
	И в меню формы я выбираю 'Социальная сеть '
	И в поле с именем 'ПредставлениеКИ_4' я ввожу текст "соцсеть"
	И я нажимаю кнопку выбора у поля с именем 'КаналПривлечения'
	И Я закрываю окно "Каналы привлечения"
	И я нажимаю кнопку выбора у поля с именем 'РекламныйИсточник'
	И Я закрываю окно "Рекламные источники"
	И в поле с именем 'Комментарий' я ввожу текст "Комментарий"
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И я нажимаю на кнопку с именем 'КнопкаДополнительно'
	И я нажимаю на кнопку с именем 'ВзаимодействиеЗадачаВыбрать'
	И я нажимаю на кнопку с именем 'Button0'
	И Я закрываю окно "Без темы. (Звонок исходящий) (создание)"
	И я нажимаю на кнопку с именем 'СоздатьЗаметку'
	И Я закрываю окно "Редактирование заметки"
	И я нажимаю на кнопку с именем 'СоздатьСообщение'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'СоздатьПисьмо'
	И Я закрываю окно ""
	И я нажимаю на кнопку с именем 'СтатусОбработана'
	И в меню формы я выбираю 'Создать клиента и запланировать визит'
	И Я закрываю текущее окно
	И я нажимаю на кнопку с именем 'ИзменитьФорму'
	И Я закрываю окно "Настройка формы"
	И я нажимаю на кнопку с именем 'ИсторияОбъекта'
	И Я закрываю окно "История"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

Создание клиента и Визита
	И Я создаю Клиента
 	Дано Я открываю основную форму документа "Визит"
	И в поле с именем 'ИмяКонтрагента' я ввожу текст "$$Клиент$$"
	И из выпадающего списка с именем 'ИмяКонтрагента' я выбираю точное значение "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ФормаПровести'
	И я сохраняю навигационную ссылку текущего окна в переменную "$Визит$"
	И я нажимаю на кнопку с именем 'ФормаСохранить'
	И Я открываю навигационную ссылку "$Визит$"
	И В текущем окне я нажимаю кнопку командного интерфейса "Клиент"
	И В текущем окне я нажимаю кнопку командного интерфейса "Статистика клиента"
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И я нажимаю на кнопку с именем 'ДобавитьТег'
	И в таблице 'Список' я перехожу к строке:
			| "Наименование"        |
			| "Запрет обслуживания" |
	И в таблице 'Список' я выбираю текущую строку
	И я нажимаю на кнопку с именем 'ФормаСохранить'
	И Я открываю навигационную ссылку "$Визит$"
	И я нажимаю кнопку выбора у поля с именем 'ПолеФормы_Номенклатура_ТЧ_Запасы_0'
	И я активизирую дополнение формы с именем 'СтрокаПоиска'
	И в дополнение формы с именем 'СтрокаПоиска' я ввожу текст "$$Услуга$$"
	И я жду, что в таблице "_ПодборНоменклатур1" количество строк будет "больше" 0 в течение 30 секунд
	И я нажимаю на кнопку с именем 'Выбрать'
	И я нажимаю на кнопку с именем 'ФормаСохранить'
	Тогда в логе сообщений TestClient есть строка "В строке 1 не указан сотрудник"
	И из выпадающего списка с именем 'ПолеФормы_Сотрудник_ТЧ_Запасы_0' я выбираю по строке "$$МастерСК$$"
	И я нажимаю на кнопку с именем 'ФормаСохранить'
	И открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И Я открываю навигационную ссылку "$Визит$"
	И я нажимаю на кнопку с именем 'Пришел'
	И я нажимаю на кнопку с именем 'ФормаСохранить'
	И Я открываю навигационную ссылку "$Визит$"
	И я нажимаю на кнопку с именем 'Окончен'
	И я нажимаю на кнопку с именем 'ФормаСохранить'
	И Я открываю навигационную ссылку "$Визит$"

Создание взноса на лицевой счет
	И Я открываю навигационную ссылку "$$СсылкаКлиента$$"
	И я нажимаю на кнопку с именем 'КнопкаДобавитьЛицевыеСчета'
	И я нажимаю кнопку выбора у поля с именем 'ВидЛицевогоСчета'
	И я нажимаю на кнопку с именем 'КнопкаВыбрать'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст "100,00"
	И я перехожу к следующему реквизиту
	И я нажимаю на кнопку с именем 'Оплатить'
	Если открылось окно "Внимание" Тогда
		И я нажимаю на кнопку с именем 'Button0'
		И я нажимаю на гиперссылку с именем 'ZОтчет_0'
		И я нажимаю на кнопку с именем 'ПодтвердитьЗакрытиеСмены'
	
Создание Заказа покупателя
	И я открываю основную форму документа "ЗаказПокупателя"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыНоменклатура'
	И в таблице 'Запасы' я выбираю текущую строку
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$Услуга$$"
	И я нажимаю на кнопку с именем 'ФормаКнопкаПровестиИЗакрыть'
	И я закрываю сеанс текущего клиента тестирования

Выключаем настройку использовать заявки
	Дано я подключаю TestClient "Админ" логин "Админ" пароль ""
	И В командном интерфейсе я выбираю "Настройки" "Продажи и маркетинг"
	И я снимаю флаг "ИспользоватьЗаявки"
	И Я закрываю окно "Продажи и маркетинг"	