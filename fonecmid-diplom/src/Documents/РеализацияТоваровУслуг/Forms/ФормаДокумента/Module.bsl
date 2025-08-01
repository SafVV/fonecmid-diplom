
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	//Начало вставки: Задача: ONEC-MID-DIPLOM.  Автор: Сафонов В.В.
	
	ПустойМассив = Новый Массив;
	Элементы.Договор.ПараметрыВыбора = Новый ФиксированныйМассив(ПустойМассив);
	
	
	НоваяКоманда = Команды.Добавить("Заполнить");
	НоваяКоманда.Действие = "Заполнить";
	НоваяКоманда.Заголовок = "Заполнить";
	
	НовыйЭлемент = Элементы.Добавить("ЭлементЗаполнить", Тип("КнопкаФормы"), ЭтаФорма.КоманднаяПанель);
	НовыйЭлемент.ИмяКоманды = "Заполнить";
	
	//Конец вставки
	
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры


//Начало вставки: Задача: ONEC-MID-DIPLOM.  Автор: Сафонов В.В.
&НаКлиенте
Процедура Заполнить(Команда)
	
	ВызватьМодульОбъекта();
	
КонецПроцедуры

&НаСервере
Процедура ВызватьМодульОбъекта()
	
	Если Не ЗначениеЗаполнено(Объект.Договор) Тогда 
		
		ОбщегоНазначения.СообщитьПользователю("Для автозаполнения необходимо заполнить ""Организация"", ""Контрагент"", ""Договор""");
		Отказ = Истина;
		Возврат
		
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ДоговорыКонтрагентов.Ссылка КАК Ссылка,
	|	ДоговорыКонтрагентов.ВидДоговора КАК ВидДоговора,
	|	ДоговорыКонтрагентов.ВКМ_ДатаНачалаДействияДоговора КАК ДатаНачалаДействияДоговора,
	|	ДоговорыКонтрагентов.ВКМ_ДатаОкончанияДействияДоговора КАК ДатаОкончанияДействияДоговора
	|ИЗ
	|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|ГДЕ
	|	ДоговорыКонтрагентов.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Объект.Договор);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	
	Если Объект.Дата >= Объект.Договор.ВКМ_ДатаНачалаДействияДоговора и 
		 Объект.Дата <= Объект.Договор.ВКМ_ДатаОкончанияДействияДоговора Тогда
		 
		
		Если Выборка.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание Тогда
			
			ТекущийОбъект = РеквизитФормыВЗначение("Объект");
			ТекущийОбъект.ВКМ_ВыполнитьАвтозаполнение();
			ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
			
		Иначе
			
			ОбщегоНазначения.СообщитьПользователю("Договор не соответствует типу ""Абонентское обслуживание""");
			Отказ = Истина;
			Возврат
			
		КонецЕсли;
		
	Иначе
		
		ОбщегоНазначения.СообщитьПользователю("Дата реализации не соответсвует периоду действия договора");
		Отказ = Истина;
		Возврат
	КонецЕсли;
	
КонецПроцедуры


   //Конец вставки

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи) 
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);  
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
