﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТипРодителя     = Параметры.ТипРодителя;
	ТипМД           = Параметры.ТипМД;
	ДляМакрошага    = Параметры.ДляМакрошага;
	ВставитьГруппу  = Параметры.ВставитьГруппу;
	
	Если ВставитьГруппу Тогда
		ЗаполнитьТаблицуВыбораГруппы(ТипРодителя);
	Иначе
		ЗаполнитьТаблицуВыбора(ТипРодителя, ТипМД, ДляМакрошага);
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьТаблицуВыбора(ТипРодителя, ТипМД, ДляМакрошага)
	
	Если    ТипРодителя = Неопределено
		ИЛИ ТипРодителя = "Группа"
		ИЛИ ТипРодителя = "Повторение"
		ИЛИ ТипРодителя = "Условие" Тогда
		
		Если НЕ ДляМакрошага Тогда
			ТекстЗаголовка = НСтр("ru = 'Общие шаги проверки бизнес-логики'");
			РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
			
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьЗапрос");
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьПроцедуру");
		КонецЕсли;
		
		ТекстЗаголовка = НСтр("ru = 'Общие интерактивные шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НажатьКнопкуКИ");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивнуюКоманду");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивныйСкрипт");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьКлиентскуюПроцедуру");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ПроверитьТекстОшибки");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗавершитьРаботуТестируемогоКлиента");
		
		ТекстЗаголовка = НСтр("ru = 'Общие шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьВРучную");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Комментарий");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Пауза");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьМакрошаг");
		
	ИначеЕсли ТипРодителя = "АвтоГруппа" Тогда
		
		Если НЕ ДляМакрошага Тогда
			// Шаги бизнес-логики
			Если НЕ ПустаяСтрока(ТипМД) Тогда
				
				ТекстЗаголовка = НСтр("ru = 'Шаги проверки бизнес-логики'");
				РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
				
				СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Воспроизвести");
				СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "СравнитьСЭталоном");
				
				Если ТипМД = "Документы" Тогда
					СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "СравнитьДвижения");
				КонецЕсли;
				
			КонецЕсли;
			
			ТекстЗаголовка = НСтр("ru = 'Общие шаги проверки бизнес-логики'");
			РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
			
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьЗапрос");
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьПроцедуру");
		КонецЕсли;
		
		ТекстЗаголовка = НСтр("ru = 'Общие интерактивные шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НажатьКнопкуКИ");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивнуюКоманду");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивныйСкрипт");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьКлиентскуюПроцедуру");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ПроверитьТекстОшибки");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗавершитьРаботуТестируемогоКлиента");
		
		ТекстЗаголовка = НСтр("ru = 'Общие шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьВРучную");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Комментарий");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Пауза");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьМакрошаг");
		
		
	ИначеЕсли ТипРодителя = "ИнтерактивнаяАвтоГруппа" Тогда
		
		ТекстЗаголовка = НСтр("ru = 'Интерактивные шаги для работы с формой'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НайтиФорму");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ПроверитьФорму");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗаполнитьОдинРеквизитФормы");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗаполнитьРеквизитыФормы");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НажатьКнопку");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НайтиЭлементФормы");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗакрытьКлиентскоеОкноФормы");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыбратьСообщениеПользователю");
		
		
		Если НЕ ДляМакрошага Тогда
			ТекстЗаголовка = НСтр("ru = 'Общие шаги проверки бизнес-логики'");
			РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
			
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьЗапрос");
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьПроцедуру");
		КонецЕсли;
		
		ТекстЗаголовка = НСтр("ru = 'Общие интерактивные шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НажатьКнопкуКИ");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивнуюКоманду");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивныйСкрипт");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьКлиентскуюПроцедуру");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ПроверитьТекстОшибки");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗавершитьРаботуТестируемогоКлиента");
		
		ТекстЗаголовка = НСтр("ru = 'Общие шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьВРучную");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Комментарий");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Пауза");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьМакрошаг");
		
	ИначеЕсли ТипРодителя = "АвтоГруппаТаблицаФормы" Тогда
		
		ТекстЗаголовка = НСтр("ru = 'Интерактивные шаги для работы с таблицей'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		// Заполнить типы шагов для таблицы формы
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ДействиеСТаблицей");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НайтиСтрокуТаблицы");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗаполнитьКолонкуТаблицы");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗаполнитьСтрокуТаблицы");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НажатьКнопку");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НайтиЭлементФормы");
		
		Если НЕ ДляМакрошага Тогда
			ТекстЗаголовка = НСтр("ru = 'Общие шаги проверки бизнес-логики'");
			РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
			
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьЗапрос");
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьПроцедуру");
		КонецЕсли;
		
		ТекстЗаголовка = НСтр("ru = 'Общие интерактивные шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НажатьКнопкуКИ");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивнуюКоманду");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивныйСкрипт");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьКлиентскуюПроцедуру");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ПроверитьТекстОшибки");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗавершитьРаботуТестируемогоКлиента");
		
		ТекстЗаголовка = НСтр("ru = 'Общие шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьВРучную");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Комментарий");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Пауза");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьМакрошаг");
		
	ИначеЕсли ТипРодителя = "АвтоГруппаТабличныйДокумент" Тогда
		
		ТекстЗаголовка = НСтр("ru = 'Интерактивные шаги для работы с табличным документом'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		// Заполнить типы шагов для табличного документа
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ДействиеСТабДокументом");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ДействиеСЯчейкойТД");
		
		Если НЕ ДляМакрошага Тогда
			ТекстЗаголовка = НСтр("ru = 'Общие шаги проверки бизнес-логики'");
			РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
			
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьЗапрос");
			СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьПроцедуру");
		КонецЕсли;
		
		ТекстЗаголовка = НСтр("ru = 'Общие интерактивные шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "НажатьКнопкуКИ");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивнуюКоманду");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьИнтерактивныйСкрипт");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьКлиентскуюПроцедуру");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ПроверитьТекстОшибки");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ЗавершитьРаботуТестируемогоКлиента");
		
		ТекстЗаголовка = НСтр("ru = 'Общие шаги'");
		РодУзел = ДобавитьЗаголовок(ТекстЗаголовка);
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьВРучную");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Комментарий");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "Пауза");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодУзел, "ВыполнитьМакрошаг");
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуВыбораГруппы(ТипРодителя)
	
	СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(ТипыШагов, "Группа");
	СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(ТипыШагов, "АвтоГруппа");
	СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(ТипыШагов, "ИнтерактивнаяАвтоГруппа");
	
	Если ТипРодителя = "ИнтерактивнаяАвтоГруппа" Тогда
		
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(ТипыШагов, "АвтоГруппаТаблицаФормы");
		СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(ТипыШагов, "АвтоГруппаТабличныйДокумент");
		
	КонецЕсли;
	
	СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(ТипыШагов, "Повторение");
	СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(ТипыШагов, "Условие");
	
КонецПроцедуры



&НаСервере
Функция ДобавитьЗаголовок(ТекстЗаголовка)
	
	ТС = ТипыШагов.ПолучитьЭлементы().Добавить();
	
	ТС.ДанныеКартинки = 25;
	ТС.ТипШага        = "Заголовок";
	ТС.Представление  = ТекстЗаголовка;
	ТС.Описание       = "";
	ТС.ЭтоЗаголовок   = Истина;
	
	Возврат ТС;
	
КонецФункции

&НаСервере
Процедура СцТ_ДобавитьВСписокВыбораТипШага_НаКлиенте(РодительскийУзел, ТипШага)
	
	ТС = РодительскийУзел.ПолучитьЭлементы().Добавить();
	
	Если ТипШага = "Группа" Тогда
		ТС.ДанныеКартинки = 0;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Пользовательская группа'");
		ТС.Описание       = НСтр("ru = 'Позволяет повысить наглядность и читаемость сценария.'");
		
	ИначеЕсли ТипШага = "АвтоГруппа" Тогда
		ТС.ДанныеКартинки = 1;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Проверка бизнес-логики'");
		ТС.Описание       = НСтр("ru = 'Групповой шаг для работы с объектом информационной базы или записью регистра сведений.
							|В этом шаге задается и хранится правило поиска объекта информационной базы или записи регистра сведений.'");
		
	ИначеЕсли ТипШага = "ИнтерактивнаяАвтоГруппа" Тогда
		ТС.ДанныеКартинки = 2;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Форма'");
		ТС.Описание       = НСтр("ru = 'Групповой шаг для работы с формами и размещенными на них элементами.
							|В этом шаге хранится привязка к тестирумемой форме при создании подчиненных шагов и при их выполнении.'");
		
	ИначеЕсли ТипШага = "АвтоГруппаТаблицаФормы" Тогда
		ТС.ДанныеКартинки = 3;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Таблица формы'");
		ТС.Описание       = НСтр("ru = 'Групповой шаг для работы с таблицей (списком, деревом) формы.
							|В этом шаге хранится правило поиска таблицы на форме, а также привязка к таблице при создании подчиненных шагов или их выполнении.'");
		
	ИначеЕсли ТипШага = "АвтоГруппаТабличныйДокумент" Тогда
		ТС.ДанныеКартинки = 4;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Табличный документ'");
		ТС.Описание       = НСтр("ru = 'Групповой шаг для работы с табличным документом, размещенным на форме.
							|В этом шаге хранится правило поиска табличного документа, как элемента тестируемой формы, а также содержание эталонного табличного документа. При создании или выполнении подчиненных шагов в этом шаге хранится привязка к тестируемому табличному документу'");
		
	ИначеЕсли ТипШага = "Повторение" Тогда
		ТС.ДанныеКартинки = 5;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Повторение'");
		ТС.Описание       = НСтр("ru = 'Групповой шаг имитирующий цикл. Подчиненные элементы будут повторяться до тех пор пока справедливо условие, заданное в этом шаге'");
		
	ИначеЕсли ТипШага = "Условие" Тогда
		ТС.ДанныеКартинки = 6;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Условие'");
		ТС.Описание       = НСтр("ru = 'Групповой шаг, подчиненные шаги которого будут выполняться только в том случае, если справедливо условие, заданное в этом шаге'");
		
		////////////////////////////////////////
	
	ИначеЕсли ТипШага = "ВыполнитьЗапрос" Тогда
		ТС.ДанныеКартинки = 12;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Выполнить запрос'");
		ТС.Описание       = НСтр("ru = 'Выполнить запрос и сравнить результат его выполнения с эталонным значением, хранимым в данном шаге'");
		
	ИначеЕсли ТипШага = "ВыполнитьПроцедуру" Тогда
		ТС.ДанныеКартинки = 14;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Выполнить серверную процедуру'");
		ТС.Описание       = НСтр("ru = 'Выполнить на сервере код на языке 1С. Допускается обращение к серверным экспортным процедурам. Результатом выполнения шага можно управлять программно'");
		
	ИначеЕсли ТипШага = "НажатьКнопкуКИ" Тогда
		ТС.ДанныеКартинки = 18;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Нажать кнопку командного интерфейса'");
		ТС.Описание       = НСтр("ru = 'Имитация нажатия кнопки командного интерфейса'");
		
	ИначеЕсли ТипШага = "ВыполнитьИнтерактивнуюКоманду" Тогда
		ТС.ДанныеКартинки = 21;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Перейти по навигационной ссылке'");
		ТС.Описание       = НСтр("ru = 'Перейти по навигационной ссылке, указанной в данных шага'");
		
	ИначеЕсли ТипШага = "ВыполнитьИнтерактивныйСкрипт" Тогда
		ТС.ДанныеКартинки = 21;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Выполнить действия журнала'");
		ТС.Описание       = НСтр("ru = 'Выполнить действия ""Журнала действий пользователя"", записанного средствами платформы.'");
		
	ИначеЕсли ТипШага = "ВыполнитьКлиентскуюПроцедуру" Тогда
		ТС.ДанныеКартинки = 15;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Выполнить клиентскую процедуру'");
		ТС.Описание       = НСтр("ru = 'Выполнить на клиенте код на языке 1С. Допускается обращение к тестируемому приложению. Результатом выполнения шага можно управлять программно.'");
		
	ИначеЕсли ТипШага = "ЗавершитьРаботуТестируемогоКлиента" Тогда
		ТС.ДанныеКартинки = 23;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Закрыть тестируемое приложение'");
		ТС.Описание       = НСтр("ru = 'Сымитировать нажатие на ""крестик"" в основном окне тестируемого приложения'");
		
	ИначеЕсли ТипШага = "ВыполнитьВРучную" Тогда
		ТС.ДанныеКартинки = 8;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Ручная операция'");
		ТС.Описание       = НСтр("ru = 'Шаг, который пользователь должен выполнить вручную по описанию в шаге'");
		
	ИначеЕсли ТипШага = "Комментарий" Тогда
		ТС.ДанныеКартинки = 7;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Комментарий'");
		ТС.Описание       = НСтр("ru = 'Комментарий. Неисполняемый шаг, который содержит замечания во время написания сценария'");
		
	ИначеЕсли ТипШага = "Пауза" Тогда
		ТС.ДанныеКартинки = 16;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Пауза'");
		ТС.Описание       = НСтр("ru = 'Пауза при выполнении сценария.'");
		
	ИначеЕсли ТипШага = "ПроверитьТекстОшибки" Тогда
		ТС.ДанныеКартинки = 13;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Проверить сообщение об ошибке'");
		ТС.Описание       = НСтр("ru = 'Проверка сообщения об ошибке, отображаемого в виде отдельного диалогового окна'");
		
	ИначеЕсли ТипШага = "ВыполнитьМакрошаг" Тогда
		ТС.ДанныеКартинки = 17;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Выполнить макрошаг'");
		ТС.Описание       = НСтр("ru = 'Выполнить макрошаг. Допускается установка параметров'");
		
	ИначеЕсли ТипШага = "Воспроизвести" Тогда
		ТС.ДанныеКартинки = 9;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Воспроизвести объект'");
		ТС.Описание       = НСтр("ru = 'Воспроизвести объект информационной базы или запись регистра сведений по эталонным данным, хранящимся в шаге'");
		
	ИначеЕсли ТипШага = "СравнитьСЭталоном" Тогда
		ТС.ДанныеКартинки = 10;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Сравнить объект с эталоном'");
		ТС.Описание       = НСтр("ru = 'Сравнить объект информационной базы или запись регистра сведений с эталонным значением, хранящимся в шаге'");
		
	ИначеЕсли ТипШага = "СравнитьДвижения" Тогда
		ТС.ДанныеКартинки = 11;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Сравнить движения с эталоном'");
		ТС.Описание       = НСтр("ru = 'Сравнить движения документа с эталонными, хранящимися в шаге'");
		
	ИначеЕсли ТипШага = "НайтиФорму" Тогда
		ТС.ДанныеКартинки = 22;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Найти форму'");
		ТС.Описание       = НСтр("ru = 'Найти тестируемую форму и привязать ее к групповому шагу или проверить отсутствие (закрытие) формы. Критерии поиска формы можно настраивать'");
		
	ИначеЕсли ТипШага = "ПроверитьФорму" Тогда
		ТС.ДанныеКартинки = 21;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Выполнить действие с текущей формой'");
		ТС.Описание       = НСтр("ru = 'Выполнить заданное действие с формой: проверить, что форма открыта или закрыта; активизировать форму; сравнить заголовок или модифицированность формы с эталонными значениями; перейти к предыдущему или следующему элементу; проверить отсутствие сообщений; закрыть окно(панель) сообщений пользователю'");
		
	ИначеЕсли ТипШага = "ЗаполнитьОдинРеквизитФормы" Тогда
		ТС.ДанныеКартинки = 19;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Поле формы'");
		ТС.Описание       = НСтр("ru = 'Задать значение для элемента формы или выполнить иное действие, обычно связанное с проверкой или изменением данных. Выполняемое действие с элементом формы может сопровождаться открытием новых окон.'");
		
	ИначеЕсли ТипШага = "ЗаполнитьРеквизитыФормы" Тогда
		ТС.ДанныеКартинки = 20;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Все поля формы'");
		ТС.Описание       = НСтр("ru = 'Нескольким или всем элементам формы установить значения или проверить значения. Ни одно из действий не должно приводить к открытию новых окон.'");
		
	ИначеЕсли ТипШага = "НажатьКнопку" Тогда
		ТС.ДанныеКартинки = 18;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Кнопка, флажок, надпись, картинка'");
		ТС.Описание       = НСтр("ru = 'Сымитировать нажатие на одном из элементов формы: кнопка, флажок, надпись - гиперссылка, картинка - гиперссылка'");
		
	//ИначеЕсли ТипШага = "ПроверитьТабличныйДокумент" Тогда
	//	ТС.ДанныеКартинки = 21;
	//	ТС.ТипШага        = ТипШага;
	//	ТС.Представление  = НСтр("ru = ''");
	//	ТС.Описание       = НСтр("ru = ''");
		
	ИначеЕсли ТипШага = "НайтиЭлементФормы" Тогда
		ТС.ДанныеКартинки = 19;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Выполнить действие с элементом формы'");
		ТС.Описание       = НСтр("ru = 'С элементом формы выполнить одно из следующих действий: проверить, что это текущий элемент; найти элемент и проверить его существование или отстуствие; проверить свойства элемента формы (заголовок, видимость, доступность); активизировать; нажать кнопку на командной панели или в контекстном меню'");
		
	ИначеЕсли ТипШага = "ЗакрытьКлиентскоеОкноФормы" Тогда
		ТС.ДанныеКартинки = 23;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Закрыть окно текущей формы'");
		ТС.Описание       = НСтр("ru = 'Закрыть окно текущей формы. Если текущее окно является основным, то будет закрыто тестируемое приложение'");
		
	ИначеЕсли ТипШага = "ВыбратьСообщениеПользователю" Тогда
		ТС.ДанныеКартинки = 21;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Выбрать сообщение пользователю'");
		ТС.Описание       = НСтр("ru = 'Сымитировать выбор сообщения пользователю. Выбор сообщения выполняется по тексту'");
		
	ИначеЕсли ТипШага = "ДействиеСТаблицей" Тогда
		ТС.ДанныеКартинки = 24;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Действие с таблицей'");
		ТС.Описание       = НСтр("ru = 'Выполнить одно из действий с тестируемой таблицей формы: перейти в начало таблицы или в конец; перейти к следующей или предыдущей строке; перейти на уровень иерархии вверх или вниз; развернуть или свернуть строку; перейти к следующей или предыдущей ячейке; выбрать, добавить или удалить строку; начать или завершить редактирование строки; выделить все или несколько строк; сортировать таблицу; сравнить несколько строк с эталонными значениями'");
		
	ИначеЕсли ТипШага = "НайтиСтрокуТаблицы" Тогда
		ТС.ДанныеКартинки = 22;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Найти строку таблицы'");
		ТС.Описание       = НСтр("ru = 'Найти строку таблицы по заданным значениям ячеек. Поиск можно выполнять вверх или вниз, от начала, конца таблицы или от текущей строки'");
		
	ИначеЕсли ТипШага = "ЗаполнитьКолонкуТаблицы" Тогда
		ТС.ДанныеКартинки = 19;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Ячейка текущей строки'");
		ТС.Описание       = НСтр("ru = 'Задать значение в ячейке таблицы или выполнить иное действие, обычно связанное с проверкой или изменением данных. Выполняемое действие с ячейкой таблицы может сопровождаться открытием новых окон.'");
		
	ИначеЕсли ТипШага = "ЗаполнитьСтрокуТаблицы" Тогда
		ТС.ДанныеКартинки = 20;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Все ячейки текущей строки'");
		ТС.Описание       = НСтр("ru = 'Нескольким или всем ячейкам текущей строки установить или проверить значения. Ни одно из действий не должно приводить к открытию новых окон.'");
		
	ИначеЕсли ТипШага = "ДействиеСТабДокументом" Тогда
		ТС.ДанныеКартинки = 21;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Действие с табличным документом'");
		ТС.Описание       = НСтр("ru = 'Выполнить действие с табличным документом, не приводящее к открытию новых форм'");
		
	ИначеЕсли ТипШага = "ДействиеСЯчейкойТД" Тогда
		ТС.ДанныеКартинки = 19;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Ячейка табличного документа'");
		ТС.Описание       = НСтр("ru = 'Выполнить действие с ячейкой табличного документа, в том числе, которое может вызвать открытие новых форм.'");
		
		
	Иначе
		ТС.ДанныеКартинки = 21;
		ТС.ТипШага        = ТипШага;
		ТС.Представление  = НСтр("ru = 'Неизвестное действие'");
		ТС.Описание       = НСтр("ru = ''");
		
		
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры


&НаКлиенте
Процедура ОК(Команда)
	
	ОбработатьВыбор();
	
КонецПроцедуры


&НаКлиенте
Процедура ТипыШаговВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОбработатьВыбор();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВыбор()
	
	// Проверки
	ТекущееДействие = Элементы.ТипыШагов.ТекущиеДанные;
	
	Если ТекущееДействие = Неопределено Тогда
		ТС = НСтр("ru = 'Не выбран тип шага'");
		ПоказатьПредупреждение(, ТС);
		Возврат;
	КонецЕсли;
	
	Если ТекущееДействие.ЭтоЗаголовок Тогда
		ТС = НСтр("ru = 'Выбран раздел. Нужно выбрать тип шага'");
		ПоказатьПредупреждение(, ТС);
		Возврат;
	КонецЕсли;
	
	ВыбранноеДействие = ТекущееДействие.ТипШага;
	
	Закрыть(ВыбранноеДействие);
	
КонецПроцедуры



