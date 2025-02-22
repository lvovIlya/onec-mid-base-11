
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

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
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
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
Процедура УслугиСкидкаПриИзменении(Элемент)
		
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();

КонецПроцедуры

&НаКлиенте
Процедура ил_ПриИзменениСкидка(Элемент) 
	
	// ++Lvov:
	// Добавление обработки изменения нового поля ввода формы "Скидка"
	// проверка заполнения таблицы для применения изменения
	Если Объект.Товары.Количество() <> 0 Или 
		Объект.Услуги.Количество() <> 0 Тогда
						
		ил_ВопросПримененияСкидки();	
		
	КонецЕсли;	
	// --Lvov
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	
	// ++Lvov:
	// Добавление расчета суммы строки таблицы с учетом данных из добавленного поля ввода формы "Скидка"
	//
	// Исходный код:
	// ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	//
	// Новый код:	
	КоэффициентСогласованнойСкидки = 1 - Объект.ил_Скидка / 100; 
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество
												 * КоэффициентСкидки * КоэффициентСогласованнойСкидки;	
		 
	РассчитатьСуммуДокумента();				 
					 
	// --Lvov:
		
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ил_ВопросПримененияСкидки() 
	
	// ++Lvov: 
	// Добавление вопроса пользователю (Да/Нет) 
	// о необходимости пересчета таблицы формы при изменении поля ввода "Скидка" 
    ЧастьВопроса1 = Новый ФорматированнаяСтрока ("Подтвердите",
															Новый Шрифт(,,,Истина),
															Новый Цвет(255,0,0));	
	ТекстВопроса = Новый ФорматированнаяСтрока (ЧастьВопроса1, " применение скидки
	|к номенклатуре таблиц !"); 
	
	Ответ = Ждать ВопросАсинх (ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		
		ил_ПересчитатьТаблицу();
		
	КонецЕсли;		
	// --Lvov
	
КонецПроцедуры


&НаКлиенте
Процедура ил_ПересчитатьТаблицу()
	
	// ++Lvov: 
	// Добавление проверки заполнености таблиц Товары и Услуги 	
	Если Объект.Товары.Количество() <> 0 Тогда
		
		ТабЧасть = Объект.Товары;					
		ил_ПересчетТЧ(ТабЧасть);
		
	КонецЕсли;	
		
	Если Объект.Услуги.Количество() <> 0 Тогда
		
		ТабЧасть = Объект.Услуги;	
		ил_ПересчетТЧ(ТабЧасть);
		
	КонецЕсли;
	// --Lvov
	
КонецПроцедуры

&НаКлиенте
Процедура ил_ПересчетТЧ(ТабЧасть)
	
	// ++Lvov:
	// Добавление пересчета строк таблицы
	Для Каждого СтрокаТЧ Из ТабЧасть Цикл
		
		РассчитатьСуммуСтроки(СтрокаТЧ);
		
	КонецЦикла;
    // --Lvov

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

&НаКлиенте
Процедура ил_ПересчитатьТаблицуНажатие(Команда)
	
	// ++Lvov: команда пересчета таблицы формы с учетом введенной скидки
	ил_ПересчитатьТаблицу();
	// --Lvov**
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
