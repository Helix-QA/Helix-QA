# ___Автоматизация тестирования ролей в Стоматологии.___
Для автотестирования созданы следующие сценарии:
- 01_СозданиеПользователей
- 02_Сестра-хозяйка
- 03_Врач
- 04_Регистратура
- 05_Бухгалтер
## __Описание автотеста 01_СозданиеПользователей__
_Сценарий: Создание пользователей._ Я удаляю переменные, Создаю пользователей:
Регистратура (права на все отчеты и период отборов Начало текущей недели + доступ к кассе)
Сестра-хозяйка
Врач
Бухгалтер
Директор (не тестируется)
## __Описание автотеста 02_Сестра-хозяйка__
_Сценарий: Сестра-хозяйка. Создание номенклатуры_
Я удаляю переменные. Создаю Товар, Материал, Услугу, Подарочный сертификат, Имущество, Набор услуг.
_Сценарий: Заказ поставщику, поступление. Опиходование. Инвентаризация_
Делаю заказ поставщику на товар и материал (в котором создаю поставщика). На его основании создаю поступление запасов и услуг. Создаю оприходование сертификата. Делаю инвентаризацию этих товара, материала и сертификата.
## __Описание автотеста 03_Врач__
_Сценарий: Врач. Создание пациента_
Удаляю переменные, создаю карточку пациента. Врач не должен видеть данные удостоверения личности. этот пункт при заполнении карточки пропущен.
_Сценарий: Врач. Создание плана лечения_
Лечение - Планы лечения, создаю на этого пациента план лечения. (без оплат)
_Сценарий: Врач. Создание приема_
Лечение - Приемы, на этого пациента создаю прием с услугой, не оплачиваю его.
## __Описание автотеста 04_Регистратура__
_Сценарий: Регистратура. Проверка отчетов_
Захожу в каждый отчет и проверяю отработку отбора Начало предыдущего дня, формирую отчет.
_Сценарий: Оплата долга от врача_
На рабочем столе выбираю пациента врача и делаю оплату долгового приема.
_Сценарий: Регистратура. Пациент. Прием и реализация_
Удаляю переменные, создаю карточку пациента.
Оформляю пациенту прием с услугой, оплачиваю его. Делаю реализацию товара и оплачиваю. Делаю реализацию сертификата и оплачиваю.
## __Описание автотеста 05_Бухгалтер__
Я удаляю переменные. Выдаю аванс сотруднику (Врачу) за апрель.