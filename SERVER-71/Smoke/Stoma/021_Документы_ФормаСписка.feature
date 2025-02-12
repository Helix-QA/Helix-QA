﻿
#language: ru

@tree
@SmokeTest

Функциональность: Дымовые тесты - Документы - ФормаСписка
# Конфигурация: 1С:Медицина. Стоматологическая клиника, редакция 2.1
# Версия: 2.1.19.1

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И Я закрыл все окна клиентского приложения

Сценарий: Открытие формы списка документа "Авансовый отчет" (АвансовыйОтчет)

	Дано Я открываю основную форму списка документа "АвансовыйОтчет"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа АвансовыйОтчет"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа АвансовыйОтчет"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Акт оказания услуг" (АктОказанияУслуг)

	Дано Я открываю основную форму списка документа "АктОказанияУслуг"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа АктОказанияУслуг"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа АктОказанияУслуг"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Амбулаторная запись" (АмбулаторнаяЗапись)

	Дано Я открываю основную форму списка документа "АмбулаторнаяЗапись"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа АмбулаторнаяЗапись"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа АмбулаторнаяЗапись"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Ввод начальных остатков" (ВводНачальныхОстатков)

	Дано Я открываю основную форму списка документа "ВводНачальныхОстатков"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ВводНачальныхОстатков"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ВводНачальныхОстатков"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Взаимодействие" (Взаимодействие)

	Дано Я открываю основную форму списка документа "Взаимодействие"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Взаимодействие"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Взаимодействие"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Возврат от пациента" (ВозвратОтПокупателя)

	Дано Я открываю основную форму списка документа "ВозвратОтПокупателя"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ВозвратОтПокупателя"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ВозвратОтПокупателя"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Возврат поставщику" (ВозвратПоставщику)

	Дано Я открываю основную форму списка документа "ВозвратПоставщику"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ВозвратПоставщику"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ВозвратПоставщику"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Договор с пациентом" (Договоры)

	Дано Я открываю основную форму списка документа "Договоры"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Договоры"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Договоры"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Ежедневный отчет" (ЕжедневныйОтчет)

	Дано Я открываю основную форму списка документа "ЕжедневныйОтчет"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЕжедневныйОтчет"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЕжедневныйОтчет"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Заказ поставщику" (ЗаказПоставщику)

	Дано Я открываю основную форму списка документа "ЗаказПоставщику"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЗаказПоставщику"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЗаказПоставщику"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Закрытие дня" (ЗакрытиеДня)

	Дано Я открываю основную форму списка документа "ЗакрытиеДня"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЗакрытиеДня"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЗакрытиеДня"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Закрытие месяца" (ЗакрытиеМесяца)

	Дано Я открываю основную форму списка документа "ЗакрытиеМесяца"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЗакрытиеМесяца"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЗакрытиеМесяца"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Затраты" (Затраты)

	Дано Я открываю основную форму списка документа "Затраты"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Затраты"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Затраты"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Инвентаризация запасов" (ИнвентаризацияЗапасов)

	Дано Я открываю основную форму списка документа "ИнвентаризацияЗапасов"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ИнвентаризацияЗапасов"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ИнвентаризацияЗапасов"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Кассовая смена" (КассоваяСмена)

	Дано Я открываю основную форму списка документа "КассоваяСмена"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа КассоваяСмена"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа КассоваяСмена"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Кассовый чек коррекции" (КассовыйЧекКоррекции)

	Дано Я открываю основную форму списка документа "КассовыйЧекКоррекции"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа КассовыйЧекКоррекции"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа КассовыйЧекКоррекции"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Наряд-заказ" (НарядЗаказ)

	Дано Я открываю основную форму списка документа "НарядЗаказ"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа НарядЗаказ"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа НарядЗаказ"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Начисление зарплаты" (НачислениеЗарплаты)

	Дано Я открываю основную форму списка документа "НачислениеЗарплаты"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа НачислениеЗарплаты"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа НачислениеЗарплаты"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Операция по бонусному счету" (ОперацияПоБонусномуСчету)

	Дано Я открываю основную форму списка документа "ОперацияПоБонусномуСчету"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ОперацияПоБонусномуСчету"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ОперацияПоБонусномуСчету"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Оприходование запасов" (ОприходованиеЗапасов)

	Дано Я открываю основную форму списка документа "ОприходованиеЗапасов"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ОприходованиеЗапасов"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ОприходованиеЗапасов"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Отзыв согласия на обработку персональных данных" (ОтзывСогласияНаОбработкуПерсональныхДанных)

	Дано Я открываю основную форму списка документа "ОтзывСогласияНаОбработкуПерсональныхДанных"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ОтзывСогласияНаОбработкуПерсональныхДанных"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ОтзывСогласияНаОбработкуПерсональныхДанных"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Перемещение денег" (ПеремещениеДенежныхСредств)

	Дано Я открываю основную форму списка документа "ПеремещениеДенежныхСредств"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ПеремещениеДенежныхСредств"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ПеремещениеДенежныхСредств"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Перемещение запасов" (ПеремещениеЗапасов)

	Дано Я открываю основную форму списка документа "ПеремещениеЗапасов"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ПеремещениеЗапасов"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ПеремещениеЗапасов"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "План лечения" (ПланЛечения)

	Дано Я открываю основную форму списка документа "ПланЛечения"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ПланЛечения"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ПланЛечения"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Поступление запасов и услуг" (Поступление)

	Дано Я открываю основную форму списка документа "Поступление"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Поступление"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Поступление"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Поступление денег" (ПоступлениеДенежныхСредств)

	Дано Я открываю основную форму списка документа "ПоступлениеДенежныхСредств"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ПоступлениеДенежныхСредств"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ПоступлениеДенежныхСредств"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Приём" (Прием)

	Дано Я открываю основную форму списка документа "Прием"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Прием"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Прием"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Рассылка сообщений" (РассылкаСообщений)

	Дано Я открываю основную форму списка документа "РассылкаСообщений"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа РассылкаСообщений"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа РассылкаСообщений"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Реализация" (Реализация)

	Дано Я открываю основную форму списка документа "Реализация"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Реализация"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Реализация"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Предварительная запись" (Событие)

	Дано Я открываю основную форму списка документа "Событие"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Событие"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа Событие"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Согласие на обработку персональных данных" (СогласиеНаОбработкуПерсональныхДанных)

	Дано Я открываю основную форму списка документа "СогласиеНаОбработкуПерсональныхДанных"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СогласиеНаОбработкуПерсональныхДанных"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СогласиеНаОбработкуПерсональныхДанных"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Списание денег" (СписаниеДенежныхСредств)

	Дано Я открываю основную форму списка документа "СписаниеДенежныхСредств"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СписаниеДенежныхСредств"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СписаниеДенежныхСредств"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Списание задолженности" (СписаниеЗадолженности)

	Дано Я открываю основную форму списка документа "СписаниеЗадолженности"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СписаниеЗадолженности"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СписаниеЗадолженности"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Списание запасов" (СписаниеЗапасов)

	Дано Я открываю основную форму списка документа "СписаниеЗапасов"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СписаниеЗапасов"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СписаниеЗапасов"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Списание материалов" (СписаниеМатериалов)

	Дано Я открываю основную форму списка документа "СписаниеМатериалов"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СписаниеМатериалов"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СписаниеМатериалов"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Справка в налоговую" (СправкаВНалоговую)

	Дано Я открываю основную форму списка документа "СправкаВНалоговую"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СправкаВНалоговую"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СправкаВНалоговую"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Счет на оплату" (СчетНаОплату)

	Дано Я открываю основную форму списка документа "СчетНаОплату"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СчетНаОплату"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СчетНаОплату"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Счет-фактура" (СчетФактура)

	Дано Я открываю основную форму списка документа "СчетФактура"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СчетФактура"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа СчетФактура"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Табель учета рабочего времени" (ТабельУчетаРабочегоВремени)

	Дано Я открываю основную форму списка документа "ТабельУчетаРабочегоВремени"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ТабельУчетаРабочегоВремени"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ТабельУчетаРабочегоВремени"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Ручная операция" (ХозяйственныеОперации)

	Дано Я открываю основную форму списка документа "ХозяйственныеОперации"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ХозяйственныеОперации"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ХозяйственныеОперации"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Чек коррекции" (ЧекКоррекции)

	Дано Я открываю основную форму списка документа "ЧекКоррекции"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЧекКоррекции"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЧекКоррекции"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Электронное письмо входящее" (ЭлектронноеПисьмоВходящее)

	Дано Я открываю основную форму списка документа "ЭлектронноеПисьмоВходящее"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЭлектронноеПисьмоВходящее"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЭлектронноеПисьмоВходящее"
	И Я закрываю текущее окно

Сценарий: Открытие формы списка документа "Электронное письмо исходящее" (ЭлектронноеПисьмоИсходящее)

	Дано Я открываю основную форму списка документа "ЭлектронноеПисьмоИсходящее"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЭлектронноеПисьмоИсходящее"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть форму списка документа ЭлектронноеПисьмоИсходящее"
	И Я закрываю текущее окно
