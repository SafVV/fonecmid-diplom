
#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)  
	
	СформироватьДвижения();
	
	РассчитатьОклад();
	
	РассчитатьОтпуск();
	
	РассчитатьНДФЛ();
	
	РассчитатьЗарплатуКВыплате();
	
КонецПроцедуры

Процедура СформироватьДвижения() 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.Сотрудник,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ВидРасчета,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаНачала КАК ПериодДействияНачало,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаОкончания КАК ПериодДействияОкончание,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ГрафикРаботы,
	|	МАКСИМУМ(ВКМ_УсловияОплатыСотрудников.Период) КАК Период
	|ПОМЕСТИТЬ ВТ_ДанныеПоОкладам
	|ИЗ
	|	Документ.ВКМ_НачислениеЗарплаты.ОсновныеНачисления КАК ВКМ_НачислениеЗарплатыОсновныеНачисления
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ВКМ_УсловияОплатыСотрудников КАК ВКМ_УсловияОплатыСотрудников
	|		ПО ВКМ_НачислениеЗарплатыОсновныеНачисления.Сотрудник = ВКМ_УсловияОплатыСотрудников.Сотрудник
	|		И ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаНачала >= ВКМ_УсловияОплатыСотрудников.Период
	|ГДЕ
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.Ссылка = &Ссылка
	|	И ВКМ_НачислениеЗарплатыОсновныеНачисления.ВидРасчета = &Оклад
	|СГРУППИРОВАТЬ ПО
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.Сотрудник,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ВидРасчета,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаНачала,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаОкончания,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ГрафикРаботы
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ДанныеПоОкладам.Сотрудник,
	|	ВТ_ДанныеПоОкладам.ВидРасчета,
	|	ВТ_ДанныеПоОкладам.ПериодДействияНачало КАК ПериодДействияНачало,
	|	ВТ_ДанныеПоОкладам.ПериодДействияОкончание КАК ПериодДействияКонец,
	|	ВТ_ДанныеПоОкладам.ГрафикРаботы,
	|	ВКМ_УсловияОплатыСотрудников.Оклад КАК Показатель,
	|	NULL КАК БазовыйПериодНачало,
	|	NULL КАК БазовыйПериодКонец
	|ИЗ
	|	РегистрСведений.ВКМ_УсловияОплатыСотрудников КАК ВКМ_УсловияОплатыСотрудников
	|		ПРАВОЕ СОЕДИНЕНИЕ ВТ_ДанныеПоОкладам КАК ВТ_ДанныеПоОкладам
	|		ПО ВТ_ДанныеПоОкладам.Сотрудник = ВКМ_УсловияОплатыСотрудников.Сотрудник
	|		И ВТ_ДанныеПоОкладам.Период = ВКМ_УсловияОплатыСотрудников.Период
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|//Расчет отпуска
	|ВЫБРАТЬ
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.Сотрудник,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ВидРасчета,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаНачала,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаОкончания,
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.ГрафикРаботы,
	|	NULL,
	|	НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаНачала, МЕСЯЦ, -12), МЕСЯЦ),
	|	КОНЕЦПЕРИОДА(ДОБАВИТЬКДАТЕ(ВКМ_НачислениеЗарплатыОсновныеНачисления.ДатаНачала, МЕСЯЦ, -1), МЕСЯЦ)
	|ИЗ
	|	Документ.ВКМ_НачислениеЗарплаты.ОсновныеНачисления КАК ВКМ_НачислениеЗарплатыОсновныеНачисления
	|ГДЕ
	|	ВКМ_НачислениеЗарплатыОсновныеНачисления.Ссылка = &Ссылка
	|	И ВКМ_НачислениеЗарплатыОсновныеНачисления.ВидРасчета = &Отпуск";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Оклад", ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Оклад); 
	Запрос.УстановитьПараметр("Отпуск", ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск); 
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл 
		
		Движение                      = Движения.ВКМ_ОсновныеНачисления.Добавить();
		Движение.ПериодРегистрации    = Дата;
		Движение.ПериодДействияНачало = Выборка.ПериодДействияНачало;
		Движение.ПериодДействияКонец  = Выборка.ПериодДействияКонец;
		Движение.ВидРасчета           = Выборка.ВидРасчета;
		Движение.Сотрудник            = Выборка.Сотрудник;
		Движение.ГрафикРаботы         = Выборка.ГрафикРаботы;
		Движение.Показатель           = Выборка.Показатель;
		
		Если Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск Тогда
			
			Движение.БазовыйПериодНачало = НачалоМесяца(ДобавитьМесяц(Движение.ПериодДействияНачало, -12));
			Движение.БазовыйПериодКонец  = КонецМесяца(ДобавитьМесяц(Движение.БазовыйПериодНачало, 11));
			
		КонецЕсли;
		
		Движение                      = Движения.ВКМ_Удержания.Добавить();
		Движение.Сторно               = Ложь;
		Движение.ВидРасчета           = ПланыВидовРасчета.ВКМ_Удержания.НДФЛ;
		Движение.ПериодДействияНачало = Выборка.ПериодДействияНачало;
		Движение.ПериодДействияКонец  = Выборка.ПериодДействияКонец;
		Движение.БазовыйПериодНачало  = НачалоМесяца(Дата);
		Движение.БазовыйПериодКонец   = КонецМесяца(Дата);
		Движение.ПериодРегистрации    = Дата;
		Движение.Сотрудник            = Выборка.Сотрудник;
		
	КонецЦикла;
	
	Движения.ВКМ_ОсновныеНачисления.Записать();
	Движения.ВКМ_Удержания.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИфункции

Процедура РассчитатьОклад() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВКМ_ОсновныеНачисленияДанныеГрафика.НомерСтроки КАК НомерСтроки,
	|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеПериодДействия, 0) КАК План,
	|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеФактическийПериодДействия, 0) КАК Факт
	|ИЗ
	|	РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика(
	|			ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.Оклад)
	|				И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияДанныеГрафика";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_ОсновныеНачисления[Выборка.НомерСтроки -1];
		
		Если Выборка.План = 0 Тогда
			
			#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
				ОбщегоНазначения.СообщитьПользователю("Не заполнен план графика сотрудника");
			#Иначе
				ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
			#КонецЕсли
			Возврат;
			
		Иначе
			Движение.Результат = Движение.Показатель * Выборка.Факт / Выборка.План; 
		КонецЕсли;
		
		Движение.ОтработаноДней = Выборка.Факт/8;
		
	КонецЦикла;
	
	Движения.ВКМ_ОсновныеНачисления.Записать(, Истина);
	
КонецПроцедуры

Процедура РассчитатьОтпуск()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВКМ_ОсновныеНачисления.НомерСтроки КАК НомерСтроки,
	|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.РезультатБаза, 0) КАК РезультатБаза,
	|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.ОтработаноДнейБаза, 0) КАК ОтработаноДнейБаза,
	|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеФактическийПериодДействия, 0) КАК Факт
	|ИЗ
	|	РегистрРасчета.ВКМ_ОсновныеНачисления КАК ВКМ_ОсновныеНачисления
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.БазаВКМ_ОсновныеНачисления(&Измерения, &Измерения,,
	|			ВидРасчета = &Отпуск
	|		И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления
	|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.НомерСтроки
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика(ВидРасчета = &Отпуск
	|		И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияДанныеГрафика
	|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияДанныеГрафика.НомерСтроки
	|ГДЕ
	|	ВКМ_ОсновныеНачисления.ВидРасчета = &Отпуск
	|	И ВКМ_ОсновныеНачисления.Регистратор = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Отпуск", ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск);
	
	Измерения = Новый Массив; 
	Измерения.Добавить("Сотрудник");
	Запрос.УстановитьПараметр("Измерения", Измерения);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_ОсновныеНачисления[Выборка.НомерСтроки -1];
		Движение.КалендарныеДни = Выборка.Факт/8;
		Движение.Результат = Выборка.РезультатБаза / Выборка.ОтработаноДнейБаза * Движение.КалендарныеДни;  
		
		Если Движение.Сторно Тогда
			Движение.ОтработаноДней = - Движение.ОтработаноДней;
			Движение.Результат = - Движение.Результат;
		КонецЕсли;
		
	КонецЦикла;
	
	Движения.ВКМ_ОсновныеНачисления.Записать(, Истина);
	
КонецПроцедуры

Процедура РассчитатьНДФЛ() 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.НомерСтроки КАК НомерСтроки,
	               |	ЕСТЬNULL(ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.НДФЛ, 0) КАК НДФЛ,
	               |	ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.РезультатБаза КАК РезультатБаза,
	               |	ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.Регистратор КАК Регистратор
	               |ИЗ
	               |	РегистрРасчета.ВКМ_Удержания.БазаВКМ_ОсновныеНачисления(
	               |			&Измерение,
	               |			&Измерение,
	               |			&Разрез,
	               |			ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_Удержания.НДФЛ)
	               |				И Регистратор = &Регистратор) КАК ВКМ_УдержанияБазаВКМ_ОсновныеНачисления
	               |ГДЕ
	               |ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.Регистратор = &Регистратор";
	            
	Запрос.УстановитьПараметр("Регистратор", Ссылка);
	
	Измерение = Новый Массив;
	Измерение.Добавить("Сотрудник");
	Запрос.УстановитьПараметр("Измерение", Измерение);
	
	Разрез = Новый Массив;
	Разрез.Добавить("Регистратор");
	Запрос.УстановитьПараметр("Разрез", Разрез);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Запись = Движения.ВКМ_Удержания[Выборка.НомерСтроки - 1];
		Запись.НДФЛ =(Выборка.РезультатБаза * 13) / 100;
		
	КонецЦикла;
	
	Движения.ВКМ_Удержания.Записать(, Истина);
	
КонецПроцедуры

Процедура РассчитатьЗарплатуКВыплате() 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВКМ_ОсновныеНачисления.Сотрудник КАК Сотрудник,
	|	ЕСТЬNULL(ВКМ_ОсновныеНачисления.Результат, 0) КАК Результат
	|ПОМЕСТИТЬ ВТ_Начисления
	|ИЗ
	|	РегистрРасчета.ВКМ_ОсновныеНачисления КАК ВКМ_ОсновныеНачисления
	|ГДЕ
	|	ВКМ_ОсновныеНачисления.Регистратор = &Ссылка
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВКМ_ДополнительныеНачисления.Сотрудник,
	|	ЕСТЬNULL(ВКМ_ДополнительныеНачисления.Результат, 0)
	|ИЗ
	|	РегистрРасчета.ВКМ_ДополнительныеНачисления КАК ВКМ_ДополнительныеНачисления
	|ГДЕ
	|	ВКМ_ДополнительныеНачисления.Регистратор = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_Начисления.Сотрудник КАК Сотрудник,
	|	СУММА(ВТ_Начисления.Результат) КАК Результат
	|ПОМЕСТИТЬ ВТ_ГРуппировка
	|ИЗ
	|	ВТ_Начисления КАК ВТ_Начисления
	|СГРУППИРОВАТЬ ПО
	|	ВТ_Начисления.Сотрудник
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ГРуппировка.Сотрудник КАК Сотрудник,
	|	ВТ_ГРуппировка.Результат КАК Результат,
	|	СУММА(ВКМ_Удержания.НДФЛ) КАК НДФЛ
	|ИЗ
	|	ВТ_ГРуппировка КАК ВТ_ГРуппировка
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_Удержания КАК ВКМ_Удержания
	|		ПО ВТ_ГРуппировка.Сотрудник = ВКМ_Удержания.Сотрудник
	|ГДЕ
	|	ВКМ_Удержания.Регистратор = &Ссылка
	|СГРУППИРОВАТЬ ПО
	|	ВТ_ГРуппировка.Сотрудник,
	|	ВТ_ГРуппировка.Результат";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Движение             = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период      = Дата;
		Движение.Сотрудник   = Выборка.Сотрудник;
		Движение.Сумма       = Выборка.Результат - Выборка.НДФЛ;
		
	КонецЦикла;
	
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записать();
	
КонецПроцедуры
#КонецОбласти



