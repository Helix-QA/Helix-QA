﻿#language: ru

@tree

Функционал: Проверка заполнения первоначальной настройки при обновлении 

Контекст:
	// Нужно ПОМЕНЯТЬ параметры: 'Порт', 'Строка соединения'
	Дано Я подключаю клиент тестирования с параметрами:
		| 'Имя' | 'Синоним' | 'Тип клиента' | 'Порт' | 'Строка соединения'           | 'Логин' | 'Пароль' | 'Запускаемая обработка' | 'Дополнительные параметры строки запуска' |
		| 'AvtotestQA' | ''        | 'Тонкий'      | ''     | 'Srvr="localhost";Ref="AvtotestQA";' | ''      | ''       | ''                      | ''                                        |

Сценарий: 01. Проверка заполнения
	И я удаляю все переменные
	// Ждём процесс обновления по заверщению или до 1 часа
	И я жду открытия окна "Первоначальная настройка" в течение 3600 секунд
	И в поле с именем 'ПользовательИмя' я ввожу текст "Админ"

	// Часовой пояс
	И я нажимаю на кнопку с именем 'ВремяТекущегоСеанса'
	И я нажимаю на кнопку с именем 'Button0'
	И из выпадающего списка с именем 'ЧасовойПоясПрограммы' я выбираю точное значение "Europe/Moscow"
	И я нажимаю на кнопку с именем 'OK'
		
	// Страна (создание)

	И в поле с именем 'Наименование' я ввожу текст "Россия"
	И в поле с именем 'НаименованиеПолное' я ввожу текст "Российская Федерация"
	И в поле с именем 'МеждународноеНаименование' я ввожу текст "The Russian Federation"
	И я запоминаю случайное число в диапазоне от "111" до "999" в переменную "КодСтраны"	
	И в поле с именем 'Код' я ввожу значение выражения "$КодСтраны$"
	И в поле с именем 'КодАльфа2' я ввожу текст "RU"
	И в поле с именем 'КодАльфа3' я ввожу текст "RUS"
	И в поле с именем 'ТелефонныйКод' я ввожу текст "+7"
	И я устанавливаю флаг с именем 'УчастникЕАЭС'

	// Валютаx
	И из выпадающего списка с именем 'ВалютаУчета' я выбираю точное значение "RUR"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	// Название клуба
	И в поле с именем 'НазваниеФитнесЦентра' я ввожу текст "Фитнес плюс"
	
	// Ставка НДС
	И из выпадающего списка с именем 'СтавкаНДС' я выбираю точное значение "Без НДС"

	// График работы клуба
	И из выпадающего списка с именем 'ВремяНачалаРаботы' я выбираю точное значение "00:30"
	И из выпадающего списка с именем 'ВремяОкончанияРаботы' я выбираю точное значение "23:30"

	// --- DANGER DANGER DANGER --- ОСТОРОЖНО СОХРАНЕНИЕ :)
	И я нажимаю на кнопку с именем 'Вперед'	
		
	
		

		