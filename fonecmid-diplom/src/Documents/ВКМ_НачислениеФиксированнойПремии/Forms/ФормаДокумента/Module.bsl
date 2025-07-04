
&НаСервере
Процедура ЗаполнитьПремиюЗаВыполненныеРаботыНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВКМ_ВыполненныеСотрудникомРаботыОбороты.Сотрудник КАК Сотрудник,
	|	СУММА(ВКМ_ВыполненныеСотрудникомРаботыОбороты.СуммаКОплатеПриход) КАК СуммаКОплатеПриход
	|ИЗ
	|	РегистрНакопления.ВКМ_ВыполненныеСотрудникомРаботы.Обороты(&НачалоПериода, &КонецПериода, , ) КАК ВКМ_ВыполненныеСотрудникомРаботыОбороты
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВКМ_ФизическиеЛица КАК ВКМ_ФизическиеЛица
	|		ПО ВКМ_ВыполненныеСотрудникомРаботыОбороты.Сотрудник = ВКМ_ФизическиеЛица.Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ВКМ_ВыполненныеСотрудникомРаботыОбороты.Сотрудник";
	
	Запрос.УстановитьПараметр("НачалоПериода", (НачалоМесяца(КонецДня(Объект.Дата))));
	Запрос.УстановитьПараметр("КонецПериода", (КонецМесяца(КонецДня(Объект.Дата))));
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрока                 = Объект.СписокСотрудников.Добавить();
		НоваяСтрока.Сотрудник       = Выборка.Сотрудник;
		НоваяСтрока.СуммаНачисления = Выборка.СуммаКОплатеПриход;
		НоваяСтрока.ВидРасчета      = ПланыВидовРасчета.ВКМ_ДополнительныеНачисления.ВКМ_ПремияОтПродаж;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПремиюЗаВыполненныеРаботы(Команда)
	
	ЗаполнитьПремиюЗаВыполненныеРаботыНаСервере();
	
КонецПроцедуры


