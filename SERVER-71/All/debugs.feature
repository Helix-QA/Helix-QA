﻿#language: ru

@tree

Функционал: тест


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий



Сценарий: тест


И я запоминаю имя конфигурации как "ИмяПеременной"
Если переменная "ИмяПеременной" имеет значение "ФитнесКлуб_КОРП" Тогда
	И я вывожу сообщение в менеджер тестирования "ЭТО ФИТНЕС КЛУБ"
Если переменная "ИмяПеременной" имеет значение "Стоматология" Тогда
	И я вывожу сообщение в менеджер тестирования "ЭТО СТОМАТОЛОГИЯ"
И пауза 3
		