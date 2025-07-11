﻿#language: ru

@tree

Функционал: Формирование отчета Анализ выставленных актов

Как Бухгалтер я хочу
сформировать отчет Анализ выставленных актов  

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий:Формирование отчета Анализ выставленных актов

* И я открываю форму отчета Анализ выставленных актов
И В командном интерфейсе я выбираю 'Добавленные объекты' 'Анализ выставленных актов'
Тогда открылось окно 'Анализ выставленных актов'

* И я устанавливаю период
И я нажимаю кнопку выбора у поля с именем "Период1ДатаНачала"
И в поле с именем 'Период1ДатаНачала' я ввожу текст '01.08.2024'
И я нажимаю кнопку выбора у поля с именем "Период1ДатаОкончания"
И в поле с именем 'Период1ДатаОкончания' я ввожу текст '31.08.2024'

* И я формирую отчет
И я нажимаю на кнопку с именем 'СформироватьОтчет'
