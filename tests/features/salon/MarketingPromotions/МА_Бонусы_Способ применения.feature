﻿#language: ru

@tree

Функционал: Проверка работы "Способ применения" маркетенговых акций

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И я закрываю все окна клиентского приложения

Сценарий: Первоначальная настройка
	И я удаляю все переменные
	И Я создаю Мастера
	И Я создаю ПакетУслугСуммовой
	И Я создаю Клиента
	И Я генерирую СлучайноеЧисло
	И Я создаю даты
	И я удаляю объекты "Справочники.СкидкиНаценки" без контроля ссылок

Сценарий: Проверка выпадающий список "СпособПредоставленияСкидки" (Способ применения)
	И Остановка если была ошибка в прошлом сценарии
	Дано Я открываю основную форму списка справочника "СкидкиНаценки"
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "Бонусы"       |
	И я нажимаю на кнопку с именем 'Создать'
	И выпадающий список "СпособПредоставленияСкидки" стал равен:
		| 'Суммой'              |
		| 'Процентом'           |
		| 'Суммой на документ ' |

Сценарий: Создание МА способ - Суммой
	Дано Я открываю основную форму списка справочника "СкидкиНаценки"
	И в таблице 'Список' я перехожу к строке:
		| "Наименование" |
		| "Бонусы"       |
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Наименование' я ввожу текст "Условие - Всегда; Способ - Суммой $$СлучайноеЧисло$$"
	И из выпадающего списка с именем 'УсловиеПредоставленияСкидки' я выбираю точное значение "Всегда"
	И из выпадающего списка с именем 'СпособПредоставленияСкидки' я выбираю точное значение "Суммой"
	И в поле с именем 'ЗначениеСкидкиНаценки' я ввожу текст "111,11"
	И в поле с именем 'ЗначениеСкидкиНаценкиВидБонусногоСчета' я ввожу текст "Бонус$$СлучайноеЧисло$$"
	И я нажимаю на кнопку создать поля с именем 'ЗначениеСкидкиНаценкиВидБонусногоСчета'
	И я меняю значение переключателя с именем 'Именной' на "Именной"
	И в поле с именем 'СуммаПриветственногоНачисления' я ввожу текст "100,00"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранить'
	И я сохраняю навигационную ссылку текущего окна в переменную "$$МА_УсловияПрименения$$"

Сценарий: Проверка МА способ - Суммой
	И Остановка если была ошибка в прошлом сценарии
	И В командном интерфейсе я выбираю "Продажи" "Продажи"
	И я нажимаю на кнопку с именем 'Создать'
	И в поле с именем 'Контрагент' я ввожу текст "$$Клиент$$"
	И из выпадающего списка с именем 'Контрагент' я выбираю по строке "$$Клиент$$"
	И в таблице 'Запасы' я активизирую поле с именем 'ЗапасыНоменклатура'
	И в таблице 'Запасы' в поле с именем 'ЗапасыНоменклатура' я ввожу текст "$$ПакетУслугСуммовой$$"
	И в таблице 'Запасы' из выпадающего списка с именем 'ЗапасыНоменклатура' я выбираю по строке "$$ПакетУслугСуммовой$$"
	И пауза 1
	И элемент формы с именем 'Дек_МаркетинговыеАкции' стал равен "Маркетинговые акции (1 из 1)"
	И я нажимаю на кнопку с именем '_МаркетинговыеАкции'
	И элемент формы с именем 'НачисленоБонусовИтогСумма' стал равен "111,11"
	И у элемента формы с именем 'НачисленоБонусовИтогСумма' текст редактирования стал равен "111,11"

Сценарий: Создание МА способ - Процентом
	Дано Я открываю навигационную ссылку "$$МА_УсловияПрименения$$"
	И в поле с именем 'Наименование' я ввожу текст "Условие - Всегда; Способ - Процентом $$СлучайноеЧисло$$"
	И из выпадающего списка с именем 'СпособПредоставленияСкидки' я выбираю точное значение "Процентом"
	И в поле с именем 'ЗначениеСкидкиНаценки' я ввожу текст "77,77"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранить'

Сценарий: Проверка МА способ - Процентом
	И Я проверяю маркетинговую акции
	И элемент формы с именем 'НачисленоБонусовИтогСумма' стал равен "388,85"
	И у элемента формы с именем 'НачисленоБонусовИтогСумма' текст редактирования стал равен "388,85"

Сценарий: Создание МА способ - Суммой на документ
	Дано Я открываю навигационную ссылку "$$МА_УсловияПрименения$$"
	И в поле с именем 'Наименование' я ввожу текст "Условие - Всегда; Способ - Суммой на документ $$СлучайноеЧисло$$"
	И из выпадающего списка с именем 'СпособПредоставленияСкидки' я выбираю точное значение "Суммой на документ"
	И в поле с именем 'ЗначениеСкидкиНаценки' я ввожу текст "77,77"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранить'

Сценарий: Проверка МА способ - Суммой на документ
	И Я проверяю маркетинговую акции
	И элемент формы с именем 'НачисленоБонусовИтогСумма' стал равен "77,77"
	И у элемента формы с именем 'НачисленоБонусовИтогСумма' текст редактирования стал равен "77,77"

Сценарий: Создание МА способ - Суммой на документ
	Дано Я открываю навигационную ссылку "$$МА_УсловияПрименения$$"
	И в поле с именем 'Наименование' я ввожу текст "Условие - Всегда; Способ - Подарком $$СлучайноеЧисло$$"
	И из выпадающего списка с именем 'СпособПредоставленияСкидки' я выбираю точное значение "Суммой на документ"
	И в поле с именем 'ЗначениеСкидкиНаценки' я ввожу текст "89,89"
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранить'

Сценарий: Проверка МА способ - Суммой на документ
	И Я проверяю маркетинговую акции
	И элемент формы с именем 'НачисленоБонусовИтогСумма' стал равен "89,89"
	И у элемента формы с именем 'НачисленоБонусовИтогСумма' текст редактирования стал равен "89,89"

Сценарий: Отключил МА
	Дано Я открываю навигационную ссылку "$$МА_УсловияПрименения$$"
	И я нажимаю на кнопку с именем 'КомандаУдалить'
	И я нажимаю на кнопку с именем 'Button0'
	И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'