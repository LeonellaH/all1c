﻿
#Область ПеременныеФормы

&НаКлиенте
Перем СцТ_ГлавнаяФорма Экспорт;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	ТолькоДляВыделенныхШагов = Параметры.ТолькоВыделенные;
	
	ОбъектНаСервере = РеквизитФормыВЗначение("Объект");
	
	МакетЗаполнения = ОбъектНаСервере.ПолучитьМакет("МакетКонтрольногоПримера");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "СцТ_ПринудительноеЗакрытиеВсехФормОбработки" Тогда
		Модифицированность = Ложь;
		Если Открыта() Тогда
			Закрыть();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКоманд

&НаКлиенте
Процедура СформироватьКонтрольныйПример(Команда)
	
	СформироватьИВывестиКонтрольныйПример();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоУмолчанию(Команда)
	
	ЗаполнитьТаблицуНастройкиЗначениямиПоУмолчанию();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФлагиВКолонкеУВыделенныхСтрок(Команда)
	
	АктивнаяКолонка = Элементы.ТаблицаНастроек.ТекущийЭлемент;
	Если АктивнаяКолонка = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьЗначениеФлагаВКолонке(АктивнаяКолонка.Имя, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьФлагВКолонке(Команда)
	
	АктивнаяКолонка = Элементы.ТаблицаНастроек.ТекущийЭлемент;
	Если АктивнаяКолонка = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьЗначениеФлагаВКолонке(АктивнаяКолонка.Имя, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьНастройкиВФайл(Команда)
	
	ДВФ = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
		
		МаскаВсеФайлы = ПолучитьМаскуВсеФайлы();
		ДВФ.Фильтр = НСтр("ru = 'Файлы настройки (*.json)|*.json|Все файлы|" + МаскаВсеФайлы + "'");
		ДВФ.МножественныйВыбор          = Ложь;
		ДВФ.ПроверятьСуществованиеФайла = Истина;
		
		ДВФ.Расширение = "json";
	ДВФ.Показать(Новый ОписаниеОповещения("ПослеВыбораФайлаДляСохранения", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ПрочитатьНастройкиИзФайла(Команда)
	
	ДВФ = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
		
		МаскаВсеФайлы = ПолучитьМаскуВсеФайлы();
		ДВФ.Фильтр = НСтр("ru = 'Файлы настройки (*.json)|*.json|Все файлы|" + МаскаВсеФайлы + "'");
		ДВФ.МножественныйВыбор          = Ложь;
		ДВФ.ПроверятьСуществованиеФайла = Истина;
		
		ДВФ.Расширение = "json";
	ДВФ.Показать(Новый ОписаниеОповещения("ПослеВыбораФайлаДляОткрытия", ЭтотОбъект));

	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ТолькоДляВыделенныхШаговПриИзменении(Элемент)
	
	СцТ_ИзмененныйРезультат(Ложь);
	
КонецПроцедуры



#КонецОбласти


#Область ДополнительныеПроцедурыИФункции

#Область ЭкспортныеМетоды

// Формирование и вывод контрольного примера в соответствии с настройками
// заданными в этой форме
&НаКлиенте
Процедура СформироватьИВывестиКонтрольныйПример() Экспорт
	
	СтруктураНастроек = Новый Структура;
	
	Для каждого СтрТ Из ТаблицаНастроек Цикл
		СтруктураФлагов = Новый Структура;
		СтруктураФлагов.Вставить("Наименование"  , СтрТ.ОтображатьНаименование);
		СтруктураФлагов.Вставить("АвтоОписание"  , СтрТ.ОтображатьАвтоописание);
		СтруктураФлагов.Вставить("РучноеОписание", СтрТ.ОтображатьРучноеОписание);
		СтруктураФлагов.Вставить("ТаблицаДанных" , СтрТ.ОтображатьТаблицуДанных);
		СтруктураФлагов.Вставить("Комментарий"   , СтрТ.ОтображатьКомментарий);
		СтруктураФлагов.Вставить("Активность"    , СтрТ.Активность);
		
		СтруктураНастроек.Вставить(СтрТ.ТипШага, СтруктураФлагов);
	КонецЦикла;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ТолькоДляВыделенныхШагов", ТолькоДляВыделенныхШагов);
	СтруктураПараметров.Вставить("СтруктураНастроек"       , СтруктураНастроек);
	
	МассивСтруктур = СцТ_ГлавнаяФорма.СформироватьКонтрольныйПример(СтруктураПараметров);
	
	ЗаполнитьОтчетПоМассивуСтруктур(МассивСтруктур);
	
	СцТ_ИзмененныйРезультат(Истина);
	
КонецПроцедуры

// Заполнение таблицы настройки значениями по умолчанию
//
&НаКлиенте
Процедура ЗаполнитьТаблицуНастройкиЗначениямиПоУмолчанию() Экспорт
	
	ТаблицаНастроек.Очистить();
	
	Для каждого ЭлементСписка Из СцТ_ГлавнаяФорма.СписокТиповШагов Цикл
		СтрТ = ТаблицаНастроек.Добавить();
		СтрТ.ТипШага           = ЭлементСписка.Значение;
		СтрТ.ПредставлениеШага = ЭлементСписка.Представление;
		
		// Флаг Активность
		Если    ЭлементСписка.Значение = "АвтоГруппа"
			ИЛИ ЭлементСписка.Значение = "Воспроизвести"
			ИЛИ ЭлементСписка.Значение = "ИнтерактивнаяАвтоГруппа"
			ИЛИ ЭлементСписка.Значение = "ЗаполнитьОдинРеквизитФормы"
			ИЛИ ЭлементСписка.Значение = "ЗаполнитьРеквизитыФормы"
			ИЛИ ЭлементСписка.Значение = "АвтоГруппаТаблицаФормы"
			ИЛИ ЭлементСписка.Значение = "ЗаполнитьКолонкуТаблицы"
			ИЛИ ЭлементСписка.Значение = "АвтоГруппаТабличныйДокумент"
			ИЛИ ЭлементСписка.Значение = "ЗаполнитьСтрокуТаблицы" Тогда
			
			СтрТ.Активность = Истина;
		Иначе
			СтрТ.Активность = Ложь;
		КонецЕсли;
		
		Если ЭлементСписка.Значение = "Группа" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ВыполнитьЗапрос" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ВыполнитьПроцедуру" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "Комментарий" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Истина;
			
		ИначеЕсли ЭлементСписка.Значение = "ВыполнитьВРучную" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Истина;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ИнтерактивнаяАвтоГруппа" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "НайтиФорму" Тогда
			
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ПроверитьФорму" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "НайтиЭлементФормы" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "НажатьКнопку" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "НажатьКнопкуКИ" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ВыполнитьИнтерактивнуюКоманду" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ЗаполнитьОдинРеквизитФормы" ИЛИ ЭлементСписка.Значение = "ЗаполнитьКолонкуТаблицы" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Истина;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ЗаполнитьРеквизитыФормы" ИЛИ ЭлементСписка.Значение = "ЗаполнитьСтрокуТаблицы" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Истина;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "АвтоГруппаТаблицаФормы" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "АвтоГруппаТабличныйДокумент" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ДействиеСТаблицей" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "НайтиСтрокуТаблицы" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ПроверитьТабличныйДокумент" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ВыполнитьИнтерактивныйСкрипт" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ЗакрытьКлиентскоеОкноФормы" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ЗавершитьРаботуТестируемогоКлиента" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "Пауза" Тогда
			// Ничего не выводится
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ВыполнитьКлиентскуюПроцедуру" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "Повторение" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "Условие" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ВыполнитьМакрошаг" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ПроверитьТекстОшибки" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ВыбратьСообщениеПользователю" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "АвтоГруппаТабличныйДокумент" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ДействиеСТабДокументом" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ДействиеСЯчейкойТД" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "АвтоГруппа" Тогда
			СтрТ.ОтображатьНаименование   = Истина;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "Воспроизвести" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Истина;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "СравнитьСЭталоном" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Ложь;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Истина;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "СравнитьДвижения" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		ИначеЕсли ЭлементСписка.Значение = "ЗаменаСсылки" Тогда
			СтрТ.ОтображатьНаименование   = Ложь;
			СтрТ.ОтображатьАвтоописание   = Истина;
			СтрТ.ОтображатьРучноеОписание = Ложь;
			СтрТ.ОтображатьТаблицуДанных  = Ложь;
			СтрТ.ОтображатьКомментарий    = Ложь;
			
		Иначе
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Обработчик оповещения при событии выбора файла для сохранения настроек
//
&НаКлиенте
Процедура ПослеВыбораФайлаДляСохранения(СписокФайлов, ДопПараметры) Экспорт
	
	#Если не ВебКлиент Тогда
	Если СписокФайлов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	МассивСтруктур = Новый Массив;
	Для каждого СтрТ Из ТаблицаНастроек Цикл
		
		СтруктураНастройки = Новый Структура;
		СтруктураНастройки.Вставить("ТипШага", СтрТ.ТипШага);
		СтруктураНастройки.Вставить("ПредставлениеШага"       , СтрТ.ПредставлениеШага);
		СтруктураНастройки.Вставить("Активность"              , СтрТ.Активность);
		СтруктураНастройки.Вставить("ОтображатьНаименование"  , СтрТ.ОтображатьНаименование);
		СтруктураНастройки.Вставить("ОтображатьАвтоописание"  , СтрТ.ОтображатьАвтоописание);
		СтруктураНастройки.Вставить("ОтображатьРучноеОписание", СтрТ.ОтображатьРучноеОписание);
		СтруктураНастройки.Вставить("ОтображатьТаблицуДанных" , СтрТ.ОтображатьТаблицуДанных);
		СтруктураНастройки.Вставить("ОтображатьКомментарий"   , СтрТ.ОтображатьКомментарий);
		
		МассивСтруктур.Добавить(СтруктураНастройки);
		
	КонецЦикла;
	
	СцТ_JSONЗапись = Новый ЗаписьJSON;
	СцТ_JSONЗапись.УстановитьСтроку();
	ЗаписатьJSON(СцТ_JSONЗапись, МассивСтруктур);
	
	СтрокаJSON = СцТ_JSONЗапись.Закрыть();
	
	ЗаписьВФайлПротокола = Новый ЗаписьТекста(СписокФайлов[0], , , Истина);
	ЗаписьВФайлПротокола.ЗаписатьСтроку(СтрокаJSON);
	ЗаписьВФайлПротокола.Закрыть();
	
	#КонецЕсли
	
КонецПроцедуры

// Обработчик оповещения при событии чтения фала настроек
//
&НаКлиенте
Процедура ПослеВыбораФайлаДляОткрытия(СписокФайлов, ДопПараметры) Экспорт
	
	#Если не ВебКлиент Тогда
	Если СписокФайлов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СцТ_ЧтениеJSON = Новый ЧтениеJSON;
	СцТ_ЧтениеJSON.ОткрытьФайл(СписокФайлов[0]);
	МассивСтруктур = ПрочитатьJSON(СцТ_ЧтениеJSON);
	СцТ_ЧтениеJSON.Закрыть();
	
	
	Для каждого СтруктураДанных Из МассивСтруктур Цикл
		СтруктураОтбора = Новый Структура("ТипШага", СтруктураДанных.ТипШага);
		НужныеСтроки = ТаблицаНастроек.НайтиСтроки(СтруктураОтбора);
		Если НужныеСтроки.Количество() > 0 Тогда
			ДанныеСтроки = НужныеСтроки[0];
			
			ДанныеСтроки.Активность               = СтруктураДанных.Активность;
			ДанныеСтроки.ОтображатьНаименование   = СтруктураДанных.ОтображатьНаименование;
			ДанныеСтроки.ОтображатьАвтоописание   = СтруктураДанных.ОтображатьАвтоописание;
			ДанныеСтроки.ОтображатьРучноеОписание = СтруктураДанных.ОтображатьРучноеОписание;
			ДанныеСтроки.ОтображатьТаблицуДанных  = СтруктураДанных.ОтображатьТаблицуДанных;
			ДанныеСтроки.ОтображатьКомментарий    = СтруктураДанных.ОтображатьКомментарий;
			
			// Другие данные из файла загружать не нужно, так как структура данных на форме
			// имеет более актуальную информацию
			
		КонецЕсли;
	КонецЦикла;
	#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура СцТ_ИзмененныйРезультат(Актуален = Истина)
	
	Элементы.Результат.Доступность = Актуален;
	
КонецПроцедуры

// Процедура установки условного оформления формы
//
&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	// Недоступность поля данных
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента =  Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ТаблицаНастроек.ТипШага");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	
	СЗ = Новый СписокЗначений;
		СЗ.Добавить("Группа");
		СЗ.Добавить("ВыполнитьЗапрос");
		СЗ.Добавить("ВыполнитьПроцедуру");
		СЗ.Добавить("Комментарий");
		СЗ.Добавить("ВыполнитьВРучную");
		СЗ.Добавить("ИнтерактивнаяАвтоГруппа");
		СЗ.Добавить("НайтиФорму");
		СЗ.Добавить("ПроверитьФорму");
		СЗ.Добавить("НайтиЭлементФормы");
		СЗ.Добавить("НажатьКнопку");
		СЗ.Добавить("НажатьКнопкуКИ");
		СЗ.Добавить("ВыполнитьИнтерактивнуюКоманду");
		СЗ.Добавить("АвтоГруппаТаблицаФормы");
		СЗ.Добавить("ДействиеСТаблицей");
		СЗ.Добавить("НайтиСтрокуТаблицы");
		СЗ.Добавить("ПроверитьТабличныйДокумент");
		СЗ.Добавить("ВыполнитьИнтерактивныйСкрипт");
		СЗ.Добавить("ЗакрытьКлиентскоеОкноФормы");
		СЗ.Добавить("ЗавершитьРаботуТестируемогоКлиента");
		СЗ.Добавить("Пауза");
		СЗ.Добавить("ВыполнитьКлиентскуюПроцедуру");
		СЗ.Добавить("Повторение");
		СЗ.Добавить("Условие");
		СЗ.Добавить("ВыполнитьМакрошаг");
		СЗ.Добавить("ПроверитьТекстОшибки");
		СЗ.Добавить("ВыбратьСообщениеПользователю");
		СЗ.Добавить("АвтоГруппа");
		СЗ.Добавить("СравнитьДвижения");
		СЗ.Добавить("ЗаменаСсылки");
		СЗ.Добавить("АвтоГруппаТабличныйДокумент");
		СЗ.Добавить("ДействиеСТабДокументом");
		СЗ.Добавить("ДействиеСЯчейкойТД");
	
	ОтборЭлемента.ПравоеЗначение = СЗ;
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("ОтображатьТаблицуДанных");
	
	Элемент.Оформление.УстановитьЗначениеПараметра(
		"ТолькоПросмотр", Истина);
	
	Элемент.Использование = Истина;
	
	
	// Недоступность поля Автоописание
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента =  Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ТаблицаНастроек.ТипШага");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	
	СЗ = Новый СписокЗначений;
		СЗ.Добавить("Комментарий");
		СЗ.Добавить("ВыполнитьВРучную");
	
	ОтборЭлемента.ПравоеЗначение = СЗ;
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("ОтображатьАвтоописание");
	
	Элемент.Оформление.УстановитьЗначениеПараметра(
		"ТолькоПросмотр", Истина);
	
	Элемент.Использование = Истина;
	
	// Недоступность поля Ручного описания
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента =  Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ТаблицаНастроек.ТипШага");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	
	СЗ = Новый СписокЗначений;
		СЗ.Добавить("Комментарий");
	
	ОтборЭлемента.ПравоеЗначение = СЗ;
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("ОтображатьРучноеОписание");
	
	Элемент.Оформление.УстановитьЗначениеПараметра(
		"ТолькоПросмотр", Истина);
	
	Элемент.Использование = Истина;
	
	// Отметка неактивных серым
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента =  Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ТаблицаНастроек.Активность");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("ТаблицаНастроек");
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", Новый Цвет(127,127,127));
	
	Элемент.Использование = Истина;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОтчетПоМассивуСтруктур(МассивСтруктур)
	
	Результат.Очистить();
	
	Для каждого СтруктураМассива Из МассивСтруктур Цикл
		
		ТекстОбласти = СтруктураМассива.Текст;
		Если ТипЗнч(ТекстОбласти) = Тип("Строка") И ПустаяСтрока(ТекстОбласти) Тогда
			Продолжить;
		КонецЕсли;
		
		Если СтруктураМассива.Оформление = "Группа" Тогда
			НужнаяОбласть = МакетЗаполнения.ПолучитьОбласть("НазваниеГруппы");
			НужнаяОбласть.Параметры.Текст = ТекстОбласти;
			
		ИначеЕсли СтруктураМассива.Оформление = "Описание" Тогда
			НужнаяОбласть = МакетЗаполнения.ПолучитьОбласть("ОписаниеГруппы");
			НужнаяОбласть.Параметры.Текст = ТекстОбласти;
			
		ИначеЕсли СтруктураМассива.Оформление = "ЗаголовокТаблицы" Тогда
			НужнаяОбласть = МакетЗаполнения.ПолучитьОбласть("ЗаголовокТаблицы");
			
		ИначеЕсли СтруктураМассива.Оформление = "СтрокаТаблицы" Тогда
			НужнаяОбласть = МакетЗаполнения.ПолучитьОбласть("СтрокаТаблицы");
			НужнаяОбласть.Параметры.Название = ТекстОбласти.Название;
			НужнаяОбласть.Параметры.Значение = ТекстОбласти.Значение;
			НужнаяОбласть.Параметры.Способ   = ТекстОбласти.Способ;
			
		Иначе
			Продолжить;
			
		КонецЕсли;
		
		Результат.Вывести(НужнаяОбласть);
		
	КонецЦикла;
	
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗначениеФлагаВКолонке(ИмяКолонки, ЗначениеФлага)
	
	Если  ИмяКолонки <> "ОтображатьНаименование"
		И ИмяКолонки <> "ОтображатьАвтоописание"
		И ИмяКолонки <> "ОтображатьРучноеОписание"
		И ИмяКолонки <> "ОтображатьТаблицуДанных"
		И ИмяКолонки <> "ОтображатьКомментарий"
		И ИмяКолонки <> "Активность"
		Тогда
		
		ТекстСообщения = Нстр("ru = 'Не выбрана колонка для изменения значения флага.'");
		ПоказатьПредупреждение(, ТекстСообщения);
		
		Возврат;
		
	КонецЕсли;
	
	Если Элементы.ТаблицаНастроек.ВыделенныеСтроки.Количество() < 2 Тогда
		// Для всех строк
		Для каждого ДанныеСтроки Из ТаблицаНастроек Цикл
			
			УстановитьЗначениеФлагаВКолонкеВСтроке(ДанныеСтроки, ИмяКолонки, ЗначениеФлага);
			
		КонецЦикла;
		
	Иначе
		// Для выделенных строк
		Для каждого Идентификатор Из Элементы.ТаблицаНастроек.ВыделенныеСтроки Цикл
			ДанныеСтроки = ТаблицаНастроек.НайтиПоИдентификатору(Идентификатор);
			
			УстановитьЗначениеФлагаВКолонкеВСтроке(ДанныеСтроки, ИмяКолонки, ЗначениеФлага);
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗначениеФлагаВКолонкеВСтроке(ДанныеСтроки, ИмяКолонки, ЗначениеФлага)

	Если ИмяКолонки = "ОтображатьТаблицуДанных" И (
			    ДанныеСтроки.ТипШага = "Группа"
			ИЛИ ДанныеСтроки.ТипШага = "ВыполнитьЗапрос"
			ИЛИ ДанныеСтроки.ТипШага = "ВыполнитьПроцедуру"
			ИЛИ ДанныеСтроки.ТипШага = "Комментарий"
			ИЛИ ДанныеСтроки.ТипШага = "ВыполнитьВРучную"
			ИЛИ ДанныеСтроки.ТипШага = "ИнтерактивнаяАвтоГруппа"
			ИЛИ ДанныеСтроки.ТипШага = "НайтиФорму"
			ИЛИ ДанныеСтроки.ТипШага = "ПроверитьФорму"
			ИЛИ ДанныеСтроки.ТипШага = "НайтиЭлементФормы"
			ИЛИ ДанныеСтроки.ТипШага = "НажатьКнопку"
			ИЛИ ДанныеСтроки.ТипШага = "НажатьКнопкуКИ"
			ИЛИ ДанныеСтроки.ТипШага = "ВыполнитьИнтерактивнуюКоманду"
			ИЛИ ДанныеСтроки.ТипШага = "АвтоГруппаТаблицаФормы"
			ИЛИ ДанныеСтроки.ТипШага = "ДействиеСТаблицей"
			ИЛИ ДанныеСтроки.ТипШага = "НайтиСтрокуТаблицы"
			ИЛИ ДанныеСтроки.ТипШага = "ПроверитьТабличныйДокумент"
			ИЛИ ДанныеСтроки.ТипШага = "ВыполнитьИнтерактивныйСкрипт"
			ИЛИ ДанныеСтроки.ТипШага = "ЗакрытьКлиентскоеОкноФормы"
			ИЛИ ДанныеСтроки.ТипШага = "ЗавершитьРаботуТестируемогоКлиента"
			ИЛИ ДанныеСтроки.ТипШага = "Пауза"
			ИЛИ ДанныеСтроки.ТипШага = "ВыполнитьКлиентскуюПроцедуру"
			ИЛИ ДанныеСтроки.ТипШага = "Повторение"
			ИЛИ ДанныеСтроки.ТипШага = "Условие"
			ИЛИ ДанныеСтроки.ТипШага = "ВыполнитьМакрошаг"
			ИЛИ ДанныеСтроки.ТипШага = "ПроверитьТекстОшибки"
			ИЛИ ДанныеСтроки.ТипШага = "ВыбратьСообщениеПользователю"
			ИЛИ ДанныеСтроки.ТипШага = "АвтоГруппа"
			ИЛИ ДанныеСтроки.ТипШага = "СравнитьДвижения"
			ИЛИ ДанныеСтроки.ТипШага = "ЗаменаСсылки"
			ИЛИ ДанныеСтроки.ТипШага = "АвтоГруппаТабличныйДокумент"
			ИЛИ ДанныеСтроки.ТипШага = "ДействиеСТабДокументом"
			ИЛИ ДанныеСтроки.ТипШага = "ДействиеСЯчейкойТД")
			
		ИЛИ ИмяКолонки = "ОтображатьАвтоописание" И (
			    ДанныеСтроки.ТипШага = "Комментарий"
			ИЛИ ДанныеСтроки.ТипШага = "ВыполнитьВРучную")
			
		ИЛИ ИмяКолонки = "ОтображатьРучноеОписание" И (
			    ДанныеСтроки.ТипШага = "Комментарий") Тогда
		
		Возврат;
	КонецЕсли;
	
	ДанныеСтроки[ИмяКолонки] = ЗначениеФлага;
	
КонецПроцедуры


#КонецОбласти




















