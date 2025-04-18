﻿#language: ru

@tree
@IgnoreOnCIMainBuild

Функционал: Проверка первоначального заполнения 

Контекст:
	// Нужно ПОМЕНЯТЬ параметры: 'Порт', 'Строка соединения'
	Дано Я подключаю клиент тестирования с параметрами:
		| 'Имя'        | 'Синоним' | 'Тип клиента' | 'Строка соединения'                  | 'Логин' | 'Пароль' | 'Запускаемая обработка' | 'Дополнительные параметры строки запуска' |
		| 'AvtotestQA' | ''        | 'Тонкий'      | 'Srvr="localhost";Ref="AvtotestQA";' | ''      | ''       | ''                      | ''                                        |

Сценарий: 01. Первоначальная настройка
	И я удаляю все переменные
	// Ждём процесс обновления по заверщению или до 1 часа
	И я жду открытия окна "Помощник первоначального заполнения базы данных" в течение 3600 секунд
	И в поле с именем 'ПользовательИмя' я ввожу текст "Админ"

	// Часовой пояс
	И я нажимаю на кнопку с именем 'ВремяТекущегоСеанса'
	Тогда открылось окно "1С:Предприятие"
	И я нажимаю на кнопку с именем 'Button0'
	И из выпадающего списка с именем 'ЧасовойПоясПрограммы' я выбираю точное значение "Europe/Moscow"
	Если открылось окно "1С:Предприятие" Тогда
		Тогда я нажимаю на кнопку с именем 'OK'
			
	// Страна (создание)
	И я нажимаю на кнопку создать поля с именем 'СтранаУчета'
	И в поле с именем 'Наименование' я ввожу текст "Россия"
	И в поле с именем 'НаименованиеПолное' я ввожу текст "Россия"
	И в поле с именем 'МеждународноеНаименование' я ввожу текст "Российская Федерация"
	И в поле с именем 'КодАльфа2' я ввожу текст "RU"
	И в поле с именем 'КодАльфа3' я ввожу текст "RUS"
	И я устанавливаю флаг с именем 'УчастникЕАЭС'
	
	// Валюта
	И из выпадающего списка с именем 'ВалютаУчета' я выбираю точное значение "RUR"
	
	// Страна (продолжение)
	И в поле с именем 'ТелефонныйКод' я ввожу текст "7"	
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'

	// Название клиники
	И в поле с именем 'НазваниеСалона' я ввожу текст "Центр Стоматологической Имплантологии"

	// График работы клуба
	И из выпадающего списка с именем 'ВремяНачалаРаботы' я выбираю точное значение "00:30"
	И из выпадающего списка с именем 'ВремяОкончанияРаботы' я выбираю точное значение "23:30"

	// --- DANGER DANGER DANGER --- ОСТОРОЖНО СОХРАНЕНИЕ :)
	И я нажимаю на кнопку с именем 'Вперед'	
