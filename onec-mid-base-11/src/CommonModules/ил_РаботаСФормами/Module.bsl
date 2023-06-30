
#Область ПрограммныйИнтерфейс

// Определяет место размещения на форме нового элемента в зависимости от документа 
Процедура ДополнитьФорму(Форма) Экспорт 
	
	ИмяФормы = Форма.ИмяФормы;
	
	Если ИмяФормы = "Документ.ЗаказПокупателя.Форма.ФормаДокумента" Или
		 ИмяФормы = "Документ.ПоступлениеТоваровУслуг.Форма.ФормаДокумента" Или
		 ИмяФормы = "Документ.РеализацияТоваровУслуг.Форма.ФормаДокумента" Тогда
		
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма)	
		
	ИначеЕсли ИмяФормы = "Документ.ОплатаОтПокупателя.Форма.ФормаДокумента" Или
			  ИмяФормы = "Документ.ОплатаПоставщику.Форма.ФормаДокумента" Тогда 
		
		ВставитьПолеКонтактноеЛицоПередДоговор(Форма)
		
	КонецЕсли;
	
	Если ИмяФормы = "Документ.ЗаказПокупателя.Форма.ФормаДокумента" Тогда
		
		ДобавитьПолеИКнопкуВГруппаШапкаЛево(Форма)
		
	КонецЕсли;
	
КонецПроцедуры		
	
#КонецОбласти 

#Область СлужебныйПрограммныйИнтерфейс

// Добавляет на форму поле КонтактноеЛицо в конец группы ГруппаШапкаПраво 
Процедура ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма) 
	
	ПолеВвода = Форма.Элементы.Добавить("ил_КонтактноеЛицо", Тип("ПолеФормы"), Форма.Элементы.ГруппаШапкаПраво);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ил_КонтактроеЛицо";

КонецПроцедуры 

// Добавляет на форму поле КонтактноеЛицо перед полем Договор  
Процедура ВставитьПолеКонтактноеЛицоПередДоговор(Форма) 
	
	ПолеВвода = Форма.Элементы.Вставить("ил_КонтактноеЛицо", Тип("ПолеФормы"), , Форма.Элементы.Договор);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ил_КонтактроеЛицо";	

КонецПроцедуры

// Добавляет поле ввода Скидка с возможностью пересчета таблицы с учетом введенных данных
// добавляет кнопку Пересчет для пересчета таблицы с учетом введенной Скидки
Процедура ДобавитьПолеИКнопкуВГруппаШапкаЛево(Форма)  
	
	// Добавление команды для пересчета таблицы на форму
	КомандаПересчет = Форма.Команды.Добавить("ил_КомандаПересчет");
	КомандаПересчет.Заголовок = "Пересчитать таблицу";
	КомандаПересчет.Действие = "ил_ПересчитатьТаблицуНажатие";
		
	// Добавление группы на форму
	ГруппаСкидка = Форма.Элементы.Добавить("ил_ГруппаСкидка", Тип("ГруппаФормы"), Форма.Элементы.ГруппаШапкаЛево);
	ГруппаСкидка.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаСкидка.ОтображатьЗаголовок = ЛОЖЬ;	
			 
	// Добавление поля в добавленную группу на форму
	ПолеВвода = Форма.Элементы.Добавить("ил_Скидка", Тип("ПолеФормы"), ГруппаСкидка);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ил_Скидка";
	ПолеВвода.УстановитьДействие("ПриИзменении", "ил_ПриИзменениСкидка");	
	
	// Добавление кнопки в добавленную группу на форму
	КнопкаПересчет = Форма.Элементы.Добавить("ил_КнопкаПересчет", Тип("КнопкаФормы"), ГруппаСкидка);
	КнопкаПересчет.ИмяКоманды = "ил_КомандаПересчет";
	КнопкаПересчет.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
    
КонецПроцедуры

#КонецОбласти

