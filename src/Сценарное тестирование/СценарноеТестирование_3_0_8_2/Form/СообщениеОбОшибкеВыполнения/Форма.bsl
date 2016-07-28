
#Область Переменные

&НаКлиенте
Перем ФормаШага Экспорт;

// Экспортная переменная для хранения указателя на основную форму обработки
&НаКлиенте
Перем СцТ_ГлавнаяФорма Экспорт;

#КонецОбласти

#Область Обработчики_событий_формы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МассивИнфоСообщений = Параметры.МассивИнфоСообщений;
	ОтображаемыеТипы    = Параметры.ОтображаемыеТипы;
	
	// СУК - СтруктураУпарвляющихКнопок
	СУК = Параметры.СУК;
	Элементы.ФормаПродолжитьВыполнение.Видимость  = СУК.Выполнить;
	Элементы.ФормаВыполнитьСледующийШаг.Видимость = СУК.СледующийШаг;
	Элементы.ФормаЗавершитьВыполнение.Видимость   = СУК.Закрыть;
	
	СписокРазличий = Параметры.РазличияСрвниваемыхТаблиц;
	
	ОтображаемаяСтрока= "";
	НомерСообщения = 0;
	Для каждого ИнфоСообщение Из МассивИнфоСообщений Цикл
		Если ОтображаемыеТипы.НайтиПоЗначению(ИнфоСообщение.ТипОшибки) <> Неопределено Тогда
			//
			//// Добавление номера сообщения для отличия одного сообщения от другого
			//НомерСообщения = НомерСообщения + 1;
			//
			//СтрокаНомераСообщения = "<h2>%1)</h2>";
			//СтрокаНомераСообщения = СтрЗаменить(СтрокаНомераСообщения, "%1", Формат(НомерСообщения,"ЧГ=0"));
			
			ТекстКартинки = КартинкаТипаОшибки(ИнфоСообщение.ТипОшибки);
			
			ТекстКартинки = "<br><img src=""data:image/png;base64," + ТекстКартинки + """ hspace=""10"" alt="""" align=""left"">";
			
			
			//ОтображаемаяСтрока = ОтображаемаяСтрока + СтрокаНомераСообщения + ИнфоСообщение.ТекстСообщения;
			ОтображаемаяСтрока = ОтображаемаяСтрока + ТекстКартинки + ИнфоСообщение.ТекстСообщения;
			
		КонецЕсли;
	КонецЦикла;
	
	// Добавление заголовка
	ТекстЗаголовка = "<!DOCTYPE html PUBLIC ""-//W3C//DTD HTML 4.01//EN"" ""http://www.w3.org/TR/html4/strict.dtd"">";
	ТекстЗаголовка = ТекстЗаголовка + "<html>";
	ТекстЗаголовка = ТекстЗаголовка + "<head><meta content=""text/html; charset=ISO-8859-1"" http-equiv=""content-type""><title></title></head>";
	ТекстЗаголовка = ТекстЗаголовка + "<body>";
	
	// Завершающий текст
	ТекстЗавершения = "</body>";
	
	// Сборка итогового текста
	ОписаниеОшибки = ТекстЗаголовка + ОтображаемаяСтрока + ТекстЗавершения;
	
	// Представление шага
	ШагСценария_Идентификатор = Параметры.ШагСценария_Идентификатор;
	ШагСценария_Номер         = Параметры.ШагСценария_Номер;
	ШагСценария_Наименование  = Параметры.ШагСценария_Наименование;
	
	ШагСценария_Представление = НСтр("ru = 'Шаг №%1: %2'");
	ШагСценария_Представление = СтрЗаменить(ШагСценария_Представление, "%1", ШагСценария_Номер);
	ШагСценария_Представление = СтрЗаменить(ШагСценария_Представление, "%2", ШагСценария_Наименование);
	
	Если ШагСценария_Идентификатор = 0 Тогда
		Элементы.ШагСценария_Представление.Гиперссылка = Ложь;
	КонецЕсли;
	
	Элементы.СравнитьОтличияВизуально.Видимость = (СписокРазличий.Количество() > 0);
	Элементы.ТипОшибки.Видимость                = Параметры.ОтображатьТипОшибки;
	Элементы.СтраницыКомментария.Видимость      = Параметры.ОтображатьТипОшибки;
	
	УстановитьВидимостьСтраницКомментария(ЭтотОбъект);
	
	ПутьКФормам  = Параметры.ПутьКФормам;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "СцТ_ПринудительноеЗакрытиеВсехФормОбработки" Тогда
		Модифицированность = Ложь;
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	Для каждого ЭлементСписка Из СписокРазличий Цикл
		УдалитьИзВременногоХранилища(ЭлементСписка.Значение.АдресЭталоннойТЗ);
		УдалитьИзВременногоХранилища(ЭлементСписка.Значение.АдресТестовойТЗ);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Обработчики_событий_элементов_формы

&НаКлиенте
Процедура ШагСценария_ПредставлениеНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СцТ_ГлавнаяФорма.СцТ_ОткрытьФормуНастройкиШага(ШагСценария_Идентификатор, ФормаШага);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьКомментарийНажатие(Элемент)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ТекстРедактирования", Комментарий);
	ПараметрыФормы.Вставить("Заголовок", НСтр("ru = 'Комментарий'"));
	
	ПараметрыФормы.Вставить("РежимСовместимости838", СцТ_ГлавнаяФорма.РежимСовместимости838);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеЗакрытияФормыКомментария", ЭтотОбъект);
	
	ОткрытьФорму(
		ПутьКФормам + "РедакторМногострочногоТекста",
		ПараметрыФормы,
		ЭтотОбъект,,,,
		ОписаниеОповещения);
	
КонецПроцедуры


#КонецОбласти


#Область Обработчики_команд

&НаКлиенте
Процедура СравнитьОтличияВизуально(Команда)
	
	Если СписокРазличий.Количество() = 1 Тогда
		ПараметрыФормы = СписокРазличий[0].Значение;
		ПараметрыФормы.Вставить("РежимСовместимости838", СцТ_ГлавнаяФорма.РежимСовместимости838);
		
		ОткрытьФорму(
			ПутьКФормам + "ВизуальноеСравнениеТаблиц",
			ПараметрыФормы,
			ЭтотОбъект);
	Иначе
		СписокРазличий.ПоказатьВыборЭлемента(
			Новый ОписаниеОповещения("СцТ_ОбработатьВыборЭлементаРазличий", ЭтотОбъект),
			НСтр("ru = 'Таблица для визуального сравнения'"));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьСледующийШаг(Команда)
	
	ВыборДействия("СледующийШаг");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьВыполнение(Команда)
	
	ВыборДействия("ЗавершитьВыполнение");
	
КонецПроцедуры

&НаКлиенте
Процедура ПродолжитьВыполнение(Команда)
	
	ВыборДействия("ПродолжитьВыполнение");
	
КонецПроцедуры

#КонецОбласти


#Область Дополнительные_процедуры_и_функции

// Обработчик оповещения о закрытии формы редактирования комментария
&НаКлиенте
Процедура ПослеЗакрытияФормыКомментария(РезультатФормы, ДопПараметры) Экспорт
	
	Если РезультатФормы <> Неопределено Тогда
		Комментарий = РезультатФормы;
		Модифицированность  = Истина;
		
		УстановитьВидимостьСтраницКомментария(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьСтраницКомментария(УпрФорма)
	
	Если ПустаяСтрока(УпрФорма.Комментарий) Тогда
		УпрФорма.Элементы.СтраницыКомментария.ТекущаяСтраница = УпрФорма.Элементы.СтраницаКомментарияСоздать;
	Иначе
		УпрФорма.Элементы.СтраницыКомментария.ТекущаяСтраница = УпрФорма.Элементы.СтраницаКомментарийРеадктировать;
	КонецЕсли;
	
КонецПроцедуры

// Обработчик команд, нажатия кнопок
// Параметры
// ВыбранноеДействие - строка выбранного действия из заданного списка
&НаКлиенте
Процедура ВыборДействия(ВыбранноеДействие)
	
	СтруктураОтвета = Новый Структура;
	СтруктураОтвета.Вставить("ВыбранноеДействие", ВыбранноеДействие);
	СтруктураОтвета.Вставить("ТипОшибки"        , ТипОшибки);
	СтруктураОтвета.Вставить("Комментарий"      , Комментарий);
	
	Модифицированность = Ложь;
	Закрыть(СтруктураОтвета);
	
КонецПроцедуры

/////////////////////////

&НаКлиенте
Процедура СцТ_ОбработатьВыборЭлементаРазличий(ВыбранныйЭлемент, ДопПараметры) Экспорт
	
	Если ВыбранныйЭлемент <> Неопределено Тогда
		ПараметрыФормы = ВыбранныйЭлемент.Значение;
		ПараметрыФормы.Вставить("РежимСовместимости838", СцТ_ГлавнаяФорма.РежимСовместимости838);
		ОткрытьФорму(
			ПутьКФормам + "ВизуальноеСравнениеТаблиц",
			ПараметрыФормы,
			ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры


&НаКлиентеНаСервереБезКонтекста
Функция КартинкаТипаОшибки(ТипОшибки)
	
	Если ТипОшибки = 0 Тогда
		// значек ошибки
		Возврат "Qk04DAAAAAAAADYAAAAoAAAAIAAAACAAAAABABgAAAAAAAIMAAASCwAAEgsAAAAAAAAAAAAA+fn7
				|+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+vr7///+///////////////////9+fn6
				|+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+fn7+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6
				|+Pj6+Pj6+Pj6////////////////9PT25ubw5eXw8/P1////////////////+Pj6+Pj6+Pj6+Pj6
				|+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj69/f5/////////f38trbbcnK8
				|RUWnIiKZEhKTDw+UGxuaNzepamq9r6/a/Pz8////////9/f5+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6
				|+Pj6+Pj6+Pj6+Pj6+Pj69/f5+fn7////////mJjOLi+dAACBAAB6AAB/AACFAACJAACLAACLAACI
				|AACEAACKIyOjj4/P////////+fn69/f6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj69/f5+/v8
				|////2NjsPz+lAAB8AAB/AACKAACPAACSAACUAACVAACXAACZAACbAACdAACdAACUAACNMTGuzc3t
				|////+vr79/f5+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj69/f5+/v8////trbeDAyOAAB9AACMAACTAACU
				|AACVAACXAACYAACaAACcAACdAACfAAChAACjAACmAACnAACZAACgqqri////+/v79/f6+Pj6+Pj6
				|+Pj6+Pj6+Pj69/f6+vr7////tbXeAACLAACEAACUAACXAACXAACZAACaAACcAACeAACfAAChAACj
				|AAClAACnAACpAACqAACtAACwAACmAACkqanj////+fn7+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6////1tbr
				|AwOUAACKAACZAACaAACcAACeAACfAACgAAChAACjAAClAACnAACpAACqAACsAACvAACxAACyAACy
				|AAC1AACuAACs0NDv////+Pj5+Pj6+Pj6+Pj69/f5///+///9LS2sAACMAACdAACeAACjAACcAACO
				|AACYAACqAACoAACpAACrAACtAACuAACwAAC1AACoAACiAACxAAC6AAC5AAC8AACxHR3C///8/v7+
				|9/f6+Pj6+Pj6+vr7////kpLTAACSAACeAACjAAClAACgFhakjo7ORka0AACWAACyAACvAACwAACx
				|AACzAAC4AACiRka9jo7UFha1AAC4AAC/AAC/AADCAAC1iYnf////+fn6+Pj6+Pj6////9vb5GBiu
				|AACeAACpAACqAACtAACTnZ3W////////QUGvAACcAAC4AAC1AAC3AAC8AACkQUG3///+////nZ3d
				|AACrAADFAADEAADGAADCDg7J+fn5///++Pj6+Pj6////pqbeAACiAACrAACvAACwAACyAACoQEC0
				|/Pz7////////QUG0AACjAAC/AADBAACpQUG6/////////Pz6QEDAAAC9AADJAADJAADKAADMAADF
				|qKjp////9/f6/f38////WlrKAACoAACzAAC0AAC1AAC2AAC7AAClNTWx/Pz7////////QUG5AACu
				|AACvQUG8/////////Pz6NTW8AAC4AADPAADMAADOAADPAADQAADKWlrf////+/v6////+vr6JibA
				|AACxAAC5AAC6AAC7AAC8AAC9AADDAACsNTW2/Pz6////////Jye0Jye1/////////Pz6NTW+AAC7
				|AADTAADQAADRAADSAADUAADVAADSKirb///7///8////3d3yCAi+AAC6AAC/AADAAADBAADCAADD
				|AADEAADKAACzNTW7/Pz7////+fn7+fn7/////Pz7NTXBAAC/AADXAADTAADUAADVAADWAADXAADY
				|AADYDw/b7Oz2///+////y8vtAADDAADEAADFAADFAADGAADIAADJAADKAADLAADRAAC+GBi55+f0
				|////////5+f0Fxe+AADGAADcAQHXAQHZAgLaAgLbAgLcAQHdAQHeAADdBQXe2tr1///+////ycnt
				|AwPJAgPNDAzPBgbOAADMAADMAADNAADOAADPAADWAADEJibA6en1////////6en1KirFAADPDQ3i
				|Dg7eDQ3fDA3gDA3hDA3iDQ3jDQ3jAADjEhLj29v2///9////0tLxFRXSERHUHBzWHR3YGRrYFBTX
				|DQ3WCAjWBATbAADHQUHJ////////8vL28vL2////////T0/SAADVHBzoHBzkGxvlGxvmGxvmGxvn
				|GxvnCwvoKSno5ub2///9///+7Oz3MjLcHh7cKyvdKyveLCzfLi7gLy/hLy/mAADUWFjQ///+////
				|/f36LS3LLS3L/f36///////9VlbVAADcLS3vLCzqKyvrKyvrKyvrKirtGRntSUnt+fn4///8/v77
				|///6W1vlISHiOzvkOzvkOzvlOzvmPz/qFBXaYGDV///9/////Pz5UlLUDw/hDw/iUlLW/Pz5////
				|///9X1/ZFBTiPj/yOzvuOzvvOzvvOTnvHx/vdXXx///6/Pz7+Pj6///+kpLuIyPmT0/rTEzrTEzr
				|TEztNTXmcHDe///9/////Pz5Xl7YHx/jUFD0UFD1Hx/kXl7Z/Pz5///////8cHDhNTXsTEzzTEzy
				|TEzyS0vyLi7xra30///8+Pj69/f6///+19f1QUHqXV3wXFzvXV3vXl7yNzfjvb3s////+/v4amra
				|NDTnYWD3XV3yXV3yYWD4NDTpamrd+/v4////vb3tNzfpXl73XV31XFz2WFj3WFjz5+f3///8+Pj6
				|+Pj6/Pz7///7g4PwUFDxcnLybm7ybm7zZ2fzbm7nr67qhYXkS0vrcnL6bm71bm71bm71bm72cnL7
				|S0vuhYXlr67rbm7qZ2f3bm74bm73bm74VVX4np71///6+vr6+Pj6+Pj69/f6///93Nz2XFzyf3/4
				|fn72fn72g4P4dnf3X1/sa2v0g4P7f3/4fn74fn74fn74fn75f3/5g4P8a2v1X1/vdnf6g4P7fn75
				|fX35fHz8dHT36en3///89/f6+Pj6+Pj6+Pj6+fn6///7rKzzZGT3mZn7jY35jo75j476j4/8j4/7
				|jo76jo76jo76jo76jo76jo76jo76jo77j4/9j4/+j478jo77jIz7lJT9c3T7w8P2///7+fn6+Pj6
				|+Pj6+Pj6+Pj69/f6/f37///6jY3zeXr6qan9nJ37nZ38nZ38nZ38nZ38nZ38nZ38nZ38nZ38nZ38
				|nZ38nZ38nZ38nZ38nZ39nJz8p6j+f3/9pKT1///5+/v79/f6+Pj6+Pj6+Pj6+Pj6+Pj69/f6///8
				|+vr4kZL0iov9srP/ra79q6z9q6z9q6z9q6z9q6z9q6z9q6z9q6z9q6z9q6z9q6z9qqv9rrD+tLX/
				|h4j9nZ32/v75///79/f6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj69/f6///7///5srL2m5v7sLD/wMH/
				|urv+t7f+t7j+t7j+t7j+t7j+t7j+t7j+trf+vLz+xsb/rq//kpL7sbH2///5///79/f6+Pj6+Pj6
				|+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj69/f6///7///62dn3srL5pqb8sbH/xcX/z8//z8//zs7/zs7/
				|zs7/z8//xcX/ra3/nZz8pqb41dX3///6///79/f6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6
				|+Pj6+Pj69/f6+fn6///7+/v409P3ubn5q6v6o6P8o6P8o6P8pKT8pqb8paX7p6f6srL4y8v3+/v4
				|///7+fn6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj69/f6/Pz6
				|///7///56ur41NT3yMj2wsL3xMT3y8v31tb36ur4///5///7/Pz69/f6+Pj6+Pj6+Pj6+Pj6+Pj6
				|+Pj6+Pj6+Pj6+fn7+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+fn6///7///7///7///7
				|///7///7///7/v76+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+Pj6+fn7AAA=";
		
	ИначеЕсли ТипОшибки = 1 Тогда
		// восклицательный знак
		Возврат "Qk04DAAAAAAAADYAAAAoAAAAIAAAACAAAAABABgAAAAAAAIMAAASCwAAEgsAAAAAAAAAAAAA////
				|///////////////////////////////////////90+f3msvycrfxUavuPaPtPaHuT6fubLLvksXx
				|zeH0///5////////////////////////////////////////////////////////////////////
				|////+//7ksXwNZjtAH7qAHLqAHPtAHjsAH3vAH7xAHnvAHTuAHLqAHrpK5Hohrzs8fT1////////
				|////////////////////////////////////////////////////qtH0IIrpAG/pAHjvAIfxAIvx
				|AYvwAYrxAInwAInwAIrwAozyAY3xAInxAHvxAG/pFYPklcPo///7////////////////////////
				|///////////////////////8aLHtAG3sAHjvAI7yAIvwAYrwAYvwAIrwAHnuAHfuAHXuAHrxAIvz
				|AY3tAY3sAozxAIvyAH3xAG/mVKHj+fn1////////////////////////////////////+v37P5vr
				|AGvsAIT0AIvyAYrxAovwAInwAYfwAonwZrfvisTuh8PveLjmC4vrAIfzAYztAY3sAozxAYrxAInw
				|AHLpKIvg6e/z///////////////////////////////8PJ3rAGjuAIn0AInyAIjyAIjxAorwAYrw
				|AILxCY3u///7///////+//flEorhAIP2AovyAY3uAY3sAYrvAInwAI3uAHPqIorf/fn1////////
				|///////////////+abfuAGntAIr0AYjyAIjyAIjyAIjyAIjyAYrxAILwCo3u8/f8////////8ezp
				|EIriAIT1AovyAovyAo3tAY3sAozxAoryAI7vAHHpTKHh///6////////////////ut30AGzqAIPy
				|AInyAIjyAIjyAIjyAIjyAIjzAInwAILvCYzv8/n5///9///+6urpDYflAITzAovxAovyAovyAo3t
				|AY3sA4zyAovyAIvvAG7kl8Xk///////////////8F47sAHHyAYnxAIjxAIfyAIjyAIjyAIjyAIjz
				|AIjxAYrxAIrxDpHxE5TxE5XxCo/yA4nxAovxAovxAovxAovyAovyAYzuAY3sA4zxAozyAIDwBIDe
				|8/Py////////ns7yAGjuAYb2AIbzAIjxAIjxAIjyAIjyAIjyAIjyAIjzAYrxAYrvGZPvIpXtIZTt
				|FpDtAYryAovxAovxAovxAovxAovxAozxAY3sAYztAozxAY3zAHDqf7jl///+///9Mp/uAHDxAoX1
				|AYX0AIbzAIjyAIjyAIjyAIjyAIjyAIjyAHvwJJrv///6///9///92+DnAIDpAIfzAovxAYrwAovx
				|AovxAozwAo7uAY3tAY3tAozxAH72F4zi/vv03+72AI/vAI32AoD0AoX0AYX0AIfyAIjyAIjyAofy
				|AYjyAIjyAHbxPaXy////////////5efsBoXmAIX0AovxAovxAovxAovxAozxAo3vAo3uAo3uAo3u
				|AIvzAHjnx9vsoNDzAITzAKD5A4vyAoDzAoX1AIbzAIjxAIjyAofyAYjyAIjyAHTxVK70///+////
				|////9PDsGY7kAIP1AovxAovxAovxAovxAovxAovxAo3vAo3uAo3tAY/vAHXrhr7peb/wAIX1Ap/6
				|Ap31A4j0AYD0AYT1AIbyAIjyAIjyAIjyAIjyAHLwaLn0//////////////jtLJXiAIH1AovxAovx
				|AovxAovxAovxAovxAozwAo3uAo3uAo7uAH3wXarjXLbwAIv1A5z6Ap76A5z2A4nzA4DzAYT1AIfx
				|AInxAIjyAIjyAHPvgMTy//////////////7wQJ3iAH71AovxAovxAovxAovxAovxAovxAozxAo3v
				|Ao3uAY3uAIPzQ57iTrHyAIz2A5z3A5v5Ap75A571BIz0A4HzAITyAYfxAYjxAIfzAHbwotT3////
				|///////////0VqfiAH30AovxAovxAovxAovxAovxAovxAovxAozwAo3uAo3uAIXyM5nnTq/zAI32
				|A5z3A5z3A5z5Ap35Ap73AZPzA4TyBIDzAIfxAIbyAHzxweH8///////////////4cLHiAHvyAYvx
				|AovxAovxAovxAovxAovxAovxAozxAo3vAo/uAIXyMpnoXbbyAIv2A533A5z3A5z3A5z6Apz5AJ/1
				|Apj0BIr1AYLzAIDxAITx1+v8///////////////7jL3iAHvwAIvxAovxAovxAovxAovxAovxAovx
				|AovxAozxAo3uAITzQZ3jesDyAIf1AZ73A5z3A5z3A5z3A5z5Apv5AJ31AZ31ApP1AIDxCIjv6vX7
				|////////////////psjkAHzsAIryAovxAovxAovxAovxAovxAovxAovxAovxAozxAHzzXqnmo9Py
				|AIfxAKH6Apz3A5z3A5z3A5z3A5z6Apr5AZr0AJ71AJH1H5v0/f38////////////////vtLkAH/r
				|AIjzAovxAovxAovxAovxAovxAovxAovxAovxAY3yAHXsib7p4u/2AJHvAJz8AJ74Apz3A5z3A5z3
				|A5z3A5z6Apv5AZr0AI/0MbD1///9////////////////1d3mAH/pAIT0AovxAovxAovwAovxAovx
				|AovxAovxAovxAIvzAHvmzd3s///8OqjxAIz4Ap/4AJ74Apz3A5z3A5z3A5z3A5v6A5v5AIr0Rrb0
				|///+////////////////5ufpDIrmAIP1AorwAonxAonyAonxAorwAorxAorwAYvwAH/0G47k//v0
				|////p9LzAIPyAqL6Ap74AJ74AZz3A5z3A5z3A5z3A5z6AIr5Xb/2///+////////////////+PLs
				|IJvnAI76A5TzApLzAY/zA4/yA47zA4/zBI7zAJL0AHbrh7rk//////////76HJvtAI75A6D4Ap74
				|AJ74AZz3A5z3A5z3A5z3AIn4dcj5//////////////////////rvN6HnAI38A5j2A5j3Apf1AZX0
				|AZX1AZX0A5b1AIr5CIXh+PTw////////////v93zAIHvAJ77A574Ap74AJ74AZz3A5z3Apz3AIv1
				|itD3///////////////////////xSqrmAIz8BJb2A5b2A5b2ApX1AZT0AJT0AJX4AHXrosfj////
				|///////////////+db/vAILzAKL7A534Ap74AJ74AZ33AJv3AI72qN36////////////////////
				|///1ZbXkAIz5BJf4A5b2A5b2A5b2ApX1AJf3AHvyWKbg///5///////////////////////8Rqnr
				|AIL1AKH7BJ74Ap74AJ74AJr4AJH21e76///+///+///+///+///+///3g7/kAIv2Apr2BZf4A5b2
				|A5b2Apr6AH31L5He//rz//////////////////////////////z7S6fsAIP0AJ38A5/4Ap74AJ34
				|Apv3O7H1SLb2RLX3RbX2RLX3Q7T1R7XzIaPzAZf3AJr0A5r2BZn4AJf7AHzzNZLg8fLw////////
				|///////////////////////////////7d7ruAITwAI/5AKH6Ap/4AZ/4AJH3AIz3AI33AI33AI35
				|AIz5AIr1AJX3AZz1AZv1AJ73AI76AHntYKji//rz////////////////////////////////////
				|////////////tNfwLJvuAIXzAI35AJ37AKH6AZ73Apz3A5z3A5z3A536Apz5AJz3AJr4AI33AH/v
				|H47lo8fm///6///////////////////////////////////////////////////////////6n8zz
				|Q6bxAJHvAIjxAIj1AIz2AJD4AJD4AI33AIj4AIPyAInqN5zpksDq+vbz////////////////////
				|///////////////////////////////////////////////////////72+n1pdDxfL/wX7XvS6zx
				|SqvwWrHud7zvm8vw0+Pw///3////////////////////////////////////////AAA=";
	
	ИначеЕсли ТипОшибки = 5 Тогда
		// значек успешно
		Возврат "Qk04DAAAAAAAADYAAAAoAAAAIAAAACAAAAABABgAAAAAAAIMAAASCwAAEgsAAAAAAAAAAAAA////
				|////////////////////////////////////////////////////////////////////////////
				|////////////////////////////////////////////////////////////////////////////
				|//////////////////////////////7/9fj19fj1//7/////////////////////////////////
				|////////////////////////////////////////////////////////////////////yN/HjL6M
				|ZKhjTJtMQJU/QJVATJtMZahjjb2MyN/H////////////////////////////////////////////
				|////////////////////////////////////qs+qTZxNGYEXC3oIEn8SGoYcIIkgIIkfG4YcEX8S
				|CnoIGYIXTZxNqs6q////////////////////////////////////////////////////////////
				|////5vDnV6JWB3sIEoMTLZEtM5QzMpMyMpMxMZIyMZIyMpMyMZMyMpQzLZEtEoMTCHsIV6JW5vDn
				|////////////////////////////////////////////////////y+HLJYonCX8JL5YwNJYzMZQx
				|MpUxMpcyMpQxMpQxMpUxMpQxMpQxMpQxMpQxM5YzL5YwCH8KJYony+HL////////////////////
				|////////////////////////zePNFYMVFIgUNpk1MpYxMpUxN5o2JZAkGYcZNpk1MpYxMpYxMpYx
				|MpYxMpYxMpYxMpYxMpYxNpk1FYgVFYQWzuPN////////////////////////////////////6fLp
				|I44jFIsUNZs1MpgwMZgwNZw1I5MiMosyUJJRHYgdNp83MpgxMpgwMpgwMpgwMpgwMpgwMpgwMpgw
				|NZs2FYsUJI0j6PLp////////////////////////////////W6tbCIcHNp40MZsxMZoxNJ80J5sn
				|AHEAvdO8/fr9I4AjHJIbNZ40MZsxMZsxMZsxMZsxMZsxMZsxMZsxMZswNp41CIYHWqtb////////
				|////////////////////ttq3BocGMZ4vMZ4xMJ0xNaI1JZ0lAHQAlbuV////////sMyxAHYALqIt
				|MZ4yMZ0xMZ4xMZ4xMZ4xMZ4xMZ4xMZ0xMZ4xMJ4vBoYGttq3////////////////////////UatQ
				|E5ITNKE0Mp80N6c4HpoeA3cFlr2X////////////////calwAoADNqg3MqAyMqAyMqAzMqAzMqAz
				|MqAzMqAzMqAzNKE0E5ITUKtR////////////////////zujPGJUYL6EvNaU1NKo0C44MFYAWrcqt
				|//////////////////////z/PZA9DI8NN6k4MqIyMaIyMaIxMqIyM6MzMqMzMqMzMqMzLqIvGZUZ
				|zujP////////////////j8yPC5MJN6k1LaQtDYcMRJdE1ePV////////////zN/Myt/L////////
				|5OzkIIcfH50fPKw7N6c2N6c1M6YyMKQwM6UxM6YyM6YyNaczC5MKj8uP////////////////ZLtl
				|FJwTK6cqJI8lr8qv////////////////////S5pLU6FS////////////y97LGYgZLKgtQbFBPq09
				|Pa4+N6s3L6cuMagwM6gyM6gxE5wSZbtl//////////////7/TLRLHaQcLawtJpsmebZ54+vi////
				|////////2OXYH5MfJ5cm4erg////////////udW4HY8cNbA3SbdJRrNGSLVIPrE+LqouMKswM6sy
				|HqQcTLRM//7/////////9/r3QbJBIakhM7A0LbEuHZ8cO585lcKU//v/////cbNyLassLqkseLh4
				|////////////////tdO0KZcpPLQ7U75STrlOU7xSQ7VCLawtMa4yIakiQbFB9vv3////////9vr3
				|QLVBI60kLK4sPrY/YsdiTb9NL6QvcbhzpsqnTq5NVcNUVcNUNqI10uPR////////////////w9zC
				|QKJDN684V8RWWsFaXsJePrY+LK8tI60kQLVB9vv3//////////7/S7xNHawdMbMxW8RbasdoYsZi
				|ZcxkTbxNRK9FYMVgZchkZchlS7tLaLRo//z/////////////////4+zke7x6XLpbX8VfachoXcRb
				|MrMxG60cTLxN//7/////////////ZcZmDKoLQr1Cc850bs1ubMxtbcxtbc5tbdBtbc1tbMxsbctt
				|b9JwSbZJptCo////////////////////////fsF9W8Vbb81vdM9zQ71BC6oLZsZm////////////
				|////kdePAKgAVcZUhNaDeNB3eNB4eNB4eNB4eNB4eNB4eNB4eNB4eNJ5ctNyWrha1ujW////////
				|////////7fPtc8RzctFxeNF3g9aDVMZUAqcAkNeP////////////////z+3QDK0LWctZkdyRgteB
				|gteCgteCgteCgteCgteCgteCgteCg9aCh9mGc9JydMF07/Pv////////////1unWccdxgtmBgteB
				|kd2RWctYC60Lzu7P////////////////////QMBCPcQ9oeKgjd2Ojd2Ojd2Ojd2Ojd2Ojd2Ojd2O
				|jd2Ojd2OjtyNkeGRedN5jcqN9/j3////////2uvaf89+jN+Mjd2OoOOgPcU9QcBB////////////
				|////////////quKqIrojpOajnOKcmOKZmOKZmOKZmOKZmOKZmOKZmOKZmOKZmOKZmeGZm+achNeD
				|nNKb9Pb1////5vDljdWOleSXnOKco+ajIrokquKq////////////////////////////UslTatdq
				|v+69o+Wipeakpeakpeakpeakpeakpeakpeakpealpealpeakpeqnkd2Rotag7fTt//3/pd2lneWc
				|v+6+atdrUshT////////////////////////////////1/HYRMhFrOysvu29reqtr+qvr+qvr+qv
				|r+qvr+qvr+qvr+qvr+qvr+qvr+qvsu6yo+ajqd6qz+fPteS0ve68qeyqQcZC1/HY////////////
				|////////////////////////uee6Vs5XvfO+y/LLt+24ue66ue66ue66ue66ue66ue66ue66ue66
				|ue66ue65vPC8tO61q+Orz/HPufO7TMtLuee4////////////////////////////////////////
				|////tOe1YNJgru2u3/rgyPHJwfDCw/DDw/DDw/DDw/DDw/DDw/DDw/DDw/DDwO/CzPHM4vzko+ym
				|Uc9Ssuaz////////////////////////////////////////////////////zO3Lb9Vugt+BxfTG
				|5fzn3Pfcz/PQzPPNy/PMy/LMzfLN0fPR3ffe5/vpwPPAdtx2ZNJky+7L////////////////////
				|////////////////////////////////////////+Pv3mN+Zetp6huGIpumlxvPG2PfY4Prh3/rf
				|1vjXxPPDoeihgd6AcNlwlN6V/Pz6////////////////////////////////////////////////
				|////////////////////////8PjwseewluGVkOGQkOCQleOUk+OTjeCOi+CMkOCRr+au8fry////
				|////////////////////////////////////////////////////////////////////////////
				|////////////+v374/bk2fPY2fPZ5Pbk/P38////////////////////////////////////////
				|////////////////////////////////////////////////////////////////////////////
				|////////////////////////////////////////////////////////////////AAA=";
		
	Иначе
		// значек актуализировать (обновить)
		Возврат "Qk04DAAAAAAAADYAAAAoAAAAIAAAACAAAAABABgAAAAAAAIMAAASCwAAEgsAAAAAAAAAAAAA/vv6
				|/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr6//7///////////////////////////7/
				|/vr6/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vv6/vr5/vr5/vr5/vr5/vr5/vr5/vr5
				|/vr5/vn4//z9/////////vz/+u/n9+bL9eTB9eTB9+bL+e/n/vz///////////z9/vn4/vr5/vr5
				|/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr4/vr6////////9+nV7c6F5bpK
				|4q8n4KkQ36gJ36gJ4KkQ4q8n5bpK7c6G9+nX/////////vr6/vr4/vr5/vr5/vr5/vr5/vr5/vr5
				|/vr5/vr5/vr5/vr5/vr5/vn4//7/////+e3f6cNm4KoT3qQA4KgA4awF4q0H36cA4awE4q4J4awE
				|4KgA3aMA36kT6cJn+e3g//////7//vn4/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vn4////
				|////8Nei4asY36UA4q8J4q8O4q4L4asE36UA47EW4q0K4awF4a0H4q0J4q8O4q8J36UA4KoZ8Naj
				|/////////vn4/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vn4////////7MuF36UA464G47AS4q4M4q4M
				|4asD3aAA6sNS++/k5rkv3qIA4q0I4q4K4q0K4q4M47AS4q4F36QA7MuH/////////vn4/vr5/vr5
				|/vr5/vr5/vr5/vn4//38////7c2I4KcA5LIR47AT468O47AQ4qsD36MA7chk/PHs/vb+7sxu4KYA
				|4KcA4KUA4qwE47AQ468O5LAT5LIQ36YA7M2K//////38/vn4/vr5/vr5/vr5/vr5/vv6////8tur
				|4aoB5bQV5LIV5LES5bIW46wC4KYA79B8/fT0+evW+OjL+OnQ9uK38tiW68ZX4qwG4acA5LES5LEU
				|5LIW5bQV4agA8tqs/////vv6/vr5/vr5/vr5/vn4////+vDl5LMk5bMT5bQb5bMX5rQc46wC4qoA
				|89mV/vf7+ezW+OnM+OnM+evU+/Dj/PTz/fX19+W/6b4/4agA5bIS5bMZ5rQb5bMS5LEl+vDn////
				|/vn4/vr5/vr5//z8////7sx35bAK57ci5rUb5rUb5bAN57gp9+fD//v/+u3Y+evR+evT+evU+erO
				|+/Di/PTx+ezV/PTx/fb37cle46oA5rQa5rUc57cj5K4J7ct5//////z8/vr5/vr4////+e7f57gr
				|6Lki57ch57cf57ch5a4F7spf/PLn+u/d/Pby/fj9/ff3/PPq/PTv9eCp9Nua/fj5+/Hl+/Hl/vv/
				|7cZT5KwA6Lgj57ch6Lki57Ys+u7i/////vr4/vr6////89mY57UW6bsr6bkl6Lkk6Lce6bkm6LYc
				|57Yb6sA77spf8taF9eGq+evN////9uOy46kA7sth/Pbx/PXt/fb0+/Lk6Lkn57MS6bkl6bsr57MV
				|8deY/////vr6//3+/v3/78xo6rki6rss6rsq6rsr6rom6LQR6LYY6bkj6LUX57EK5rEH57QT6rsr
				|7shU78tg6bgh5aoA78pe/fr9+/Pn////9NqQ5rAE6rsq6rws6bki7spn//3///3+/////PPt7cVO
				|674v670w6rsn7L819d+r89eQ7MI/67wq670v674w674w670t6rol6bUU6bYX674y670u57AC9d+g
				|/////vv8+vDZ67ws6rol670w678v7MNN+/Pt////////+u3U7cJA7ME57MA167oh7sdP+u3f+/Hx
				|+OnR7sVJ67sk7MA17MA17MA17MA17MA17MA17MA17MA36bYW78lU/vz7/vr6/vz98Mtb6rgb7L81
				|7ME57MFA+e3U////////+uzO7sM/7cM/7cI667wi8c1l+e3d+erV+enP78ZJ7L4s7cI67cI67cI6
				|7cI67cI67cI67cI67cI67b8v7cI6+/Th////////89V367ga7cI67sM/7cM/+ezN////////+u3P
				|78VF78VD78Q/7b4o8s9p+u7h+eza+OjI78ZG7sE078RA78RA78RA78RA78RA78RA78RA78RA7sE2
				|7sQ+/PXh////////9NiC7bsg78Q/78VD78VF+u3P////////+u/Y8MhQ8MhI8MZE78Iy8s1g+u7d
				|+u3b+u/h8s5g78At8MdG8MZF8MZF8MZF8MZF8MZF8MZF8MZF78Ez8ctT////////////9NV27r0n
				|8MZE8MdI8clR++/Z//////7//PXy885n8slJ8chK8cZC8chI+erM+/Hn+/Xz9t6a778n8slL8slM
				|8cZA8cU/8chJ8clL8clL8clK8cdG8chI9dd8+/DO//79889g8MM48chL8clI89Bp/Pbz//7///z+
				|/v3/9deE88lH88tR88tP8cQz9+Ci/Pj++/Hh+/Tt9NFm8cEq88tP889e88xU8sY98cQ08cQ38sdA
				|8spM8spN8MEv8cY+9NFl88tS8stO88tR88lH9tqH//3///z9/vr5////9+Kw8shH9M9a9M1V88hE
				|9NBe/Pbt/PXu/Pbz+/Pm9dJo8b8f+eWv/Pbv+ee59+Cd9tiA9dFl9MtO88Y688pI9M1U88hC9MxS
				|9M5W9M5Z9MpJ+OW0/////vr5/vr5////+/Pp9M9k9dBa9c9a9c9b9Mc8+N6R/f7//PXq/fn5/fn2
				|+N6T+ui3/fz//fv//fz//fr7/PXq++7P+u7M99uJ9MpI9c9Z9c9Z9c9a9dBa9dJn/PTr/////vr5
				|/vr5/vv7////+N+k9c1P9tNk9tFf9tBa9cpD+eWp/v///fr4/fjz/v7//fjy/Pbp/ffs/fbs/fft
				|/fjy/////v//+NuC9cxL9tFe9tFe9tJj9s5Q+OKn/////vr7/vr5/vr5/vr4/////PTv9dFt99Ne
				|99Rm99Nl99Fa9sxI+uGZ/vv4/v///v3//vv6/fny/fjx/fjx/fjx/v///fjs+NRn9sxJ99Rm99Nj
				|99Rm99Ne99Ry/Pbx/////vr4/vr5/vr5/vr5/vr6////+urO99Bc+ddo+NVq+NVq+NRj981K+Ndw
				|++q1/ffk/v39/v7//vv2/vv3/////fbi+NNh985N+NZq+NVo+NVq+NZn+NJg++zS/////vr6/vr5
				|/vr5/vr5/vr5/vr4//z7////+eW7+NBd+ths+ddu+dds+ddt+dJb+M9Q+dZn+ddu/O2+////////
				|/fPW+NJc+NFV+ddv+dZr+ddu+thr+NJf+ue//////vv7/vr4/vr5/vr5/vr5/vr5/vr5/vn4//3+
				|/v//+eW7+NJk+9lr+9p0+tlw+thv+thv+tZo+c1H+9yA/////vHP+dJZ+tNd+tly+tlw+tp0+9hr
				|+dRn+ue//v7///39/vr4/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vn4//3/////+uvN+NZ5+tVk/Ntz
				|/Nx4+9p0+9pz+9lw+9p1/OWd+9dq+9dm+9t3/Nx3/Ntz+9Vl+dh8++3Q//////3+/vn4/vr5/vr5
				|/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vn4//v8/////PTu+uOs+dh7+tZo/Nlu/Nx2/N17/Nx3/Ndl
				|/Nxz/N14+9lu+tZp+tl9++Wu/Pbw/////vv8/vr4/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5
				|/vr5/vr5/vr5/vr5/////v///PPp+ue7+uCb+tuH+tl8+9l2+9l2+tl8+tyI+uCd+ui9/PTq/v//
				|/////vr4/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr4/vr6
				|/////////fv//PXv/PHh/O/X/O/X/PHh/PXw/vv///////7//vr6/vr4/vr5/vr5/vr5/vr5/vr5
				|/vr5/vr5/vr5/vv6/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vv8//3/////////
				|//////////3//vv8/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vr5/vv6AAA=";
		
	КонецЕсли;
	
КонецФункции



#КонецОбласти

