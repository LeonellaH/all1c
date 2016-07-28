﻿
#Область Переменные

// Форма - владелец текущей формы (для краткости и наглядности вместо "ЭтаФорма.ВладелецФормы")
&НаКлиенте
Перем СцТ_ГлавнаяФорма Экспорт;

// Указатель на форму (главная или макрошага), из которой была открыта эта форма
&НаКлиенте
Перем ВызвавшаяФорма Экспорт;

// Указатель на ветку в дереве. Заполненяется, если шаг не новый
&НаКлиенте
Перем ДанныеШага Экспорт;

// Идентификатор узла в дереве. Заполнено если шаг не новый
&НаКлиенте
Перем ИдентификаторУзла Экспорт;

// Содержит интерактивный контейнер, соответствующий интерактивному шагу:
//	форма или таблица формы
&НаКлиенте
Перем ИнтерактивныйКонтейнер Экспорт;

// Окно-объект, которому подчинена текущая форма
&НаКлиенте
Перем ОкноВыбраннойФормы Экспорт;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.РежимСовместимости838 Тогда
		УстановитьДействие("ПередЗакрытием", "ПередЗакрытиеБезРежимаСовместимости");
	КонецЕсли;
	
	ЭтаОбработка = РеквизитФормыВЗначение("Объект");
	ПутьКФормам  = ЭтаОбработка.Метаданные().ПолноеИмя() + ".Форма.";
	
	// Управление доступностью
	ЭтотОбъект.ТолькоПросмотр = Параметры.ТолькоПросмотр;
	Элементы.ПрименитьИЗакрыть.Доступность  = НЕ Параметры.ТолькоПросмотр;
	Элементы.ПрименитьИзменения.Доступность = НЕ Параметры.ТолькоПросмотр;
	
	// основные атрибуты шага (ОА)
	// атрибуты, для редактирования, которых не требуется открытие формы настройки
	// или свернутые для хранения атрибуты
	ОА_ТипШага                          = Параметры.ТипШага;
	ОА_НомерШага                        = Параметры.НомерШага;
	ОА_Активность                       = Параметры.Активность;
	ОА_ОписательПоложенияШагаВДереве    = Параметры.ОписательПоложенияШагаВДереве;
	ОА_ЭтоНовый                         = Параметры.ЭтоНовый;
	ОА_СтруктураДанныхШага              = Параметры.СтруктураДанныхШага;
	
	// 1. Раскрытие структуры шага и определение типа шага
	Если ОА_СтруктураДанныхШага = Неопределено  Тогда
		Возврат;
	КонецЕсли;
	
	ДШ_Наименование                 = ОА_СтруктураДанныхШага.Наименование;
	ДШ_ТипМетаданных                = ОА_СтруктураДанныхШага.ТипМетаданных;
	ДШ_ИмяМетаданных                = ОА_СтруктураДанныхШага.ИмяМетаданных;
	ДШ_Автоописание                 = ОА_СтруктураДанныхШага.Автоописание;
	ДШ_Описание                     = ОА_СтруктураДанныхШага.Описание;
	ДШ_СкрытьАвтоописание           = ОА_СтруктураДанныхШага.СкрытьАвтоописание;
	ДШ_ОбСсылка                     = ОА_СтруктураДанныхШага.ОбСсылка;
	ДШ_ПредставлениеОбъекта         = ОА_СтруктураДанныхШага.ПредставлениеОбъекта;
	ДШ_ПредставлениеИмениМетаданных = ОА_СтруктураДанныхШага.ПредставлениеИмениМетаданных;
	ДШ_ИмяФормы                     = ОА_СтруктураДанныхШага.ИмяФормы;
	ДШ_ВыполнитьВручную             = ОА_СтруктураДанныхШага.ВыполнитьВручную;
	ДШ_Комментарий                  = ОА_СтруктураДанныхШага.Комментарий;
	ДШ_ЗаголовокФормы               = ОА_СтруктураДанныхШага.ЗаголовокФормы;
	ДШ_ДанныеКартинки               = ОА_СтруктураДанныхШага.ДанныеКартинки;
	
	Если ТипЗнч(ОА_СтруктураДанныхШага.ДеревоЗначения) = Тип("Структура") Тогда
		// Данные дерева переданы в виде структуры из главной формы обработки
		СцТ_ЗаполнитьДеревоФормыИзДереваСтруктур(ДеревоЗначения,
			ОА_СтруктураДанныхШага.ДеревоЗначения);
	ИначеЕсли ТипЗнч(ОА_СтруктураДанныхШага.ДеревоЗначения) = Тип("ХранилищеЗначения") Тогда
		// Данные из конфигурации могут поступить в виде данных ХЗ
		Попытка
			ДЗ_НаСервере = ОА_СтруктураДанныхШага.ДеревоЗначения.Получить();
			ПреобразоватьЗначенияВДереве(ДЗ_НаСервере, Истина);
			ЗначениеВРеквизитФормы(ДЗ_НаСервере, "ДеревоЗначения");
		Исключение
		КонецПопытки;
	КонецЕсли;
	
	
	// Признак, что наименование установлено вручную
	НаименованиеШагаИзмененоВручную = СцТ_ЗначениеВДереве(
		ДеревоЗначения,
		"ИСТЗ_НаименованиеРучное",
		Ложь);
		
	// Картинки для закладок описания и комментария
	АдресКартинкиКомментария = ПоместитьВоВременноеХранилище(ЭтаОбработка.ПолучитьМакет("КартинкаКомментария"));
	КартинкаКомментария = Новый Картинка(ПолучитьИзВременногоХранилища(АдресКартинкиКомментария));
	
	Элементы.Страница_РедактируемоеОписание.Картинка = ?(
		ПустаяСтрока(ДШ_Описание),
		Новый Картинка,
		БиблиотекаКартинок.РежимПросмотраСпискаСписок);
	
	Элементы.Страница_Комментарий.Картинка = ?(
		ПустаяСтрока(ДШ_Комментарий),
		Новый Картинка,
		БиблиотекаКартинок.РежимПросмотраСпискаСписок);
	
	СцТ_НастроитьФормуДляШага();
	
	// Заполнение поведения при ошибке для группового шага
	СцТ_ЗаполнитьДействиеГрупповогоШагаПриОшибке(ЭтотОбъект);
	
	// Модифицированность
	Модифицированность = ОА_ЭтоНовый;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ТекущийЭлемент = Элементы.ЯчейкаТД_Действие;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "СцТ_УдалениеШаговСценария" Тогда
		
		Если ОА_ЭтоНовый Тогда
			Возврат;
		КонецЕсли;
		
		Если Параметр.НайтиПоЗначению(ДанныеШага.ПолучитьИдентификатор()) <> Неопределено Тогда
			Модифицированность = Ложь;
			Если Открыта() Тогда
				Закрыть();
			КонецЕсли;
		КонецЕсли;
		
	ИначеЕсли  ИмяСобытия = "СцТ_ПеремещениеУзловСценария" Тогда
		
		Если ОА_ЭтоНовый Тогда
			Возврат;
		КонецЕсли;
		
		НовыйУзел = Параметр[ДанныеШага];
		Если НовыйУзел <> Неопределено Тогда
			ДанныеШага = НовыйУзел;
			ИдентификаторУзла = ДанныеШага.ПолучитьИдентификатор();
			ДШ_НомерШага      = ДанныеШага.НомерШага;
			СцТ_СформироватьПредставлениеРодителя();
		КонецЕсли;
		
	ИначеЕсли ИмяСобытия = "СцТ_ОбновленыДанныеГрупповогоШага" Тогда
		
		Если Параметр = ОА_ОписательПоложенияШагаВДереве.ИдентификаторУзлаРодителя Тогда
			СцТ_СформироватьПредставлениеРодителя();
		КонецЕсли;
		
	ИначеЕсли ИмяСобытия = "СцТ_ИзмениласьНумерацияШагов" Тогда
		
		Если ОА_ЭтоНовый Тогда
			Возврат;
		КонецЕсли;
		
		Попытка
			ДанныеШага = СцТ_ГлавнаяФорма.СцТ_ПолучитьДанныеШагаПоИдентификатору(ВызвавшаяФорма,ИдентификаторУзла);
			ОА_НомерШага = ДанныеШага.НомерШага;
			СцТ_СформироватьПредставлениеРодителя();
		Исключение
		КонецПопытки;
		
	ИначеЕсли ИмяСобытия = "СцТ_ПринудительноеЗакрытиеВсехФормОбработки" Тогда
		Модифицированность = Ложь;
		Если Открыта() Тогда
			Закрыть();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если Модифицированность Тогда
		Отказ = Истина;
		ПоказатьВопрос(Новый ОписаниеОповещения("СцТ_ОбработатьЗапросОСохраненииДанныхШага", ЭтотОбъект),
			НСтр("ru = 'Данные шага были изменены. Применить изменения?'"),
			РежимДиалогаВопрос.ДаНетОтмена);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиеБезРежимаСовместимости(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если Модифицированность Тогда
		Отказ = Истина;
		Если НЕ ЗавершениеРаботы Тогда
			ПоказатьВопрос(Новый ОписаниеОповещения("СцТ_ОбработатьЗапросОСохраненииДанныхШага", ЭтотОбъект),
				НСтр("ru = 'Данные шага были изменены. Применить изменения?'"),
				РежимДиалогаВопрос.ДаНетОтмена);
			
		Иначе
			ТекстПредупреждения = НСтр("ru = 'Данные шага ячейка табличного документа были изменены. При закрытии все изменения будут утеряны'");
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ПриЗакрытии()
	
	Попытка
		СцТ_ГлавнаяФорма.СцТ_ОткрытыеФормыНастройкиШагов.Удалить(ОА_ОписательПоложенияШагаВДереве.ИдентификаторШага);
	Исключение
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКоманд

&НаКлиенте
Процедура СохранитьИЗакрытьФорму(Команда)
	
	Если СцТ_ПрименитьИзменения_НаКлиенте() Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПрименитьИзменения(Команда)
	
	Если СцТ_ПрименитьИзменения_НаКлиенте() Тогда
		ПоказатьОповещениеПользователя(НСтр("ru = 'Сохранение шага'"), , НСтр("ru = 'Данные шага сохранены.'"));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьАвтоназвание(Команда)
	
	СцТ_ОбновитьНаименование_НаКлиенте(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ХранимыеДанныеШага(Команда)
	
	// Всегда отображаются имеено хранимые данные, которые сохранены в дереве шагов
	Если ОА_ЭтоНовый Тогда
		ТекстПредупреждения = НСтр("ru = 'Данные шага еще не записаны. Отобразить структуру хранения данных невозможно. Сохранить?'");
		ОписаниеОповещения = Новый ОписаниеОповещения("СцТ_ПослеОтветаНаВопросОСохраненииНового", ЭтотОбъект);
		ПоказатьВопрос(ОписаниеОповещения, ТекстПредупреждения, РежимДиалогаВопрос.ДаНет);
		Возврат;
	ИначеЕсли НЕ ОА_ЭтоНовый И Модифицированность Тогда
		ТекстПредупреждения = НСтр("ru = 'Данные шага были изменены. Сохранить изменения перед отображением структуры?'");
		ОписаниеОповещения = Новый ОписаниеОповещения("СцТ_ПослеОтветаНаВопросОСохраненииСуществующего", ЭтотОбъект);
		ПоказатьВопрос(ОписаниеОповещения, ТекстПредупреждения, РежимДиалогаВопрос.ДаНетОтмена);
		Возврат;
	КонецЕсли;
	
	СцТ_ГлавнаяФорма.ОтобразитьХранимыеДанныеШага(ИдентификаторУзла, ВызвавшаяФорма);
	
КонецПроцедуры


#КонецОбласти


#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура АктивностьПриИзменении(Элемент)
	
	Если ОА_Активность = 2 Тогда
		ОА_Активность = 0;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	ПроверочноеНаименование = СцТ_СформироватьОписаниеШага_НаКлиенте(Истина);
	
	НаименованиеШагаИзмененоВручную = (ДШ_Наименование <> ПроверочноеНаименование);
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийПриИзменении(Элемент)
	
	ПодключитьОбработчикОжидания("СцТ_ОбновитьЗаголовкиЗакладок", 0.2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОписаниеПриИзменении(Элемент)
	
	ПодключитьОбработчикОжидания("СцТ_ОбновитьЗаголовкиЗакладок", 0.2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеГруппыНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если ОА_ЭтоНовый Тогда
		РодительУзла = СцТ_ГлавнаяФорма.СцТ_ПолучитьДанныеШагаПоИдентификатору(ВызвавшаяФорма,ОА_ОписательПоложенияШагаВДереве.ИдентификаторУзлаРодителя);
	Иначе
		РодительУзла = ДанныеШага.ПолучитьРодителя();
	КонецЕсли;
	
	Если РодительУзла <> Неопределено Тогда
		СцТ_ГлавнаяФорма.СцТ_ОткрытьФормуНастройкиШага(РодительУзла, ВызвавшаяФорма);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДействиеПриОшибкеВПодчиненныхШагахПриИзменении(Элемент)
	
	УправлениеДоступностьюПеременнойОшибкиГрупповогоШага(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиОповещений

// Обрабатывает нажатие пользователем кнопки в диалоге вопроса о сохранении
// данных шага перед закрытием формы
// Параметры
//	КодВозврата - код нажатой кнопки (Да, Нет, Отмена);
//	ДопДанные - дополнительные данные;
//
&НаКлиенте
Процедура СцТ_ОбработатьЗапросОСохраненииДанныхШага(КодВозврата, ДопДанные) Экспорт
	
	Если КодВозврата = КодВозвратаДиалога.Да Тогда
		Если СцТ_ПрименитьИзменения_НаКлиенте() Тогда
			Закрыть();
		КонецЕсли;
		
	ИначеЕсли КодВозврата = КодВозвратаДиалога.Нет Тогда
		Модифицированность = Ложь;
		Закрыть();
		
		// При Отмене ничего не выполняется
		
	КонецЕсли;
	
КонецПроцедуры

// После ответа на вопрос диалога о Сохранении нового шага перед
// отображением хранимых данных
&НаКлиенте
Процедура СцТ_ПослеОтветаНаВопросОСохраненииНового(Результат, ДопПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	// Обработка нажатия "ДА"
	Если СцТ_ПрименитьИзменения_НаКлиенте() Тогда
		СцТ_ГлавнаяФорма.ОтобразитьХранимыеДанныеШага(ИдентификаторУзла, ВызвавшаяФорма);
	Иначе
		ТекстПредупреждения = НСтр("ru = 'Не удалось сохранить шаг'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
	КонецЕсли;
	
КонецПроцедуры

// После ответа на вопрос диалога о Сохранении уже существующего модифицированного шага перед
// отображением хранимых данных
&НаКлиенте
Процедура СцТ_ПослеОтветаНаВопросОСохраненииСуществующего(Результат, ДопПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Отмена Тогда
		Возврат;
	ИначеЕсли Результат = КодВозвратаДиалога.Нет Тогда
		// Показываем, что хранится
		СцТ_ГлавнаяФорма.ОтобразитьХранимыеДанныеШага(ИдентификаторУзла, ВызвавшаяФорма);
		
	Иначе
		
		Если СцТ_ПрименитьИзменения_НаКлиенте() Тогда
			СцТ_ГлавнаяФорма.ОтобразитьХранимыеДанныеШага(ИдентификаторУзла, ВызвавшаяФорма);
		Иначе
			ТекстПредупреждения = НСтр("ru = 'Не удалось сохранить изменения в шаге'");
			ПоказатьПредупреждение(, ТекстПредупреждения);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ВспомогательныеПроцедурыИФункции

#Область НастрокаПриЗагрузкеДанныхШага

// Индивидуальная настройка формы для шага
//
&НаСервере
Процедура СцТ_НастроитьФормуДляШага()
	
	// Заполнение списка действий
	Элементы.ЯчейкаТД_Действие.СписокВыбора.Добавить("Проверить"      , "Проверить");
	Элементы.ЯчейкаТД_Действие.СписокВыбора.Добавить("Заполнить"      , "Заполнить");
	Элементы.ЯчейкаТД_Действие.СписокВыбора.Добавить("Нажать"         , "Нажать");
	Элементы.ЯчейкаТД_Действие.СписокВыбора.Добавить("ВыбратьИзСписка", "Выбрать из списка");
	
	ЯчейкаТД_Действие    = СцТ_ЗначениеВДереве(ДеревоЗначения, "Действие"   , "Проверить");
	ЯчейкаТД_АдресЯчейки = СцТ_ЗначениеВДереве(ДеревоЗначения, "Адрес"      , "R1C1");
	ЯчейкаТД_Значение    = СцТ_ЗначениеВДереве(ДеревоЗначения, "ТекстЯчейки", "");
	
	Если ЯчейкаТД_Действие = "Нажать" Тогда
		Элементы.ЯчейкаТД_Значение.Доступность = Ложь;
	Иначе
		Элементы.ЯчейкаТД_Значение.Доступность = Истина;
	КонецЕсли;
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.Страница_ДанныеШага;
	
КонецПроцедуры

&НаСервере
Процедура СцТ_ЗаполнитьДействиеГрупповогоШагаПриОшибке(ЭтотОбъект)
	
	СписокВыбора = Элементы.ДействиеПриОшибке.СписокВыбора;
	СписокВыбора.Добавить("Остановить", НСтр("ru = 'Остановить выполнение'"));
	СписокВыбора.Добавить("Продолжить", НСтр("ru = 'Продолжить выполнение'"));
	
	// Параметры действий при ошибке находятся в корне
	ДействиеПриОшибке = СцТ_ЗначениеВДереве(
		ДеревоЗначения,
		"ДействиеПриОшибке",
		"Остановить");
		
	ПеременнаяПриОшибке = СцТ_ЗначениеВДереве(
		ДеревоЗначения,
		"ПеременнаяПриОшибке",
		"");
	
	УправлениеДоступностьюПеременнойОшибкиГрупповогоШага(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти


#Область СохранениеШагаВСценарии

// Сохранение реализовано в виде функции, т.к. потребуется
// ее выполнение в обработчике ПередЗакрытием
//
&НаКлиенте
Функция СцТ_ПрименитьИзменения_НаКлиенте() Экспорт
	
	// Проверка, что владелец формы еще не закрыт
	Если НЕ ВладелецФормы.Открыта() Тогда
		ТекстСообщения = НСтр("ru = 'Форма с деревом шагов уже закрыта. Применить изменения невозможно'");
		ПоказатьПредупреждение(,ТекстСообщения);
		Возврат Ложь;
	КонецЕсли;
	
	// Проверка правильности данных
	Отказ = Ложь;
	
	Если ПустаяСтрока(ДШ_Наименование) Тогда
		
		СцТ_СообщитьПользователю(НСтр("ru = 'Не заполнено наименование.'"),
			Отказ,
			"ДШ_Наименование");
	КонецЕсли;
	
	// Проверка индивидуальных настроек шага и заполнение ДереваЗначения
	СцТ_ПодготовитьДанныеШагаДляСохранения_НаКлиенте(Отказ);
	
	Если Отказ Тогда
		Возврат Ложь;
	КонецЕсли;
	
	СцТ_ОбновитьНаименование_НаКлиенте();
	ОбновитьПользовательскоеОписание();
	
	ВозвращаемаяСтруктура = СцТ_СформироватьСтруктуруданныхШага_НаКлиенте();
	
	Если ОА_ЭтоНовый Тогда
		
		ДанныеШага = СцТ_ГлавнаяФорма.СцТ_СохранитьНовыйШаг(ВызвавшаяФорма, ВозвращаемаяСтруктура);
		
		ИдентификаторУзла = ДанныеШага.ПолучитьИдентификатор();
		ОА_НомерШага      = ДанныеШага.НомерШага;
		ОА_ЭтоНовый       = Ложь;
		
	Иначе
		СцТ_ГлавнаяФорма.СцТ_ПрименитьИзмененияВШаге(ВызвавшаяФорма, ДанныеШага, ВозвращаемаяСтруктура);
	КонецЕсли;
	
	Модифицированность = Ложь;
	
	Возврат Истина;
	
КонецФункции

// Заполнение дерева значения данными формы.
// Проверка корректности специфических для этого шага данных
&НаКлиенте
Процедура СцТ_ПодготовитьДанныеШагаДляСохранения_НаКлиенте(Отказ)
	
	// Проверки
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	// формирование дерева
	
	Если НаименованиеШагаИзмененоВручную Тогда
		СцТ_ГлавнаяФорма.СцТ_ДобавитьУзелВДеревоЗначения(
			ДеревоЗначения,
			"ИСТЗ_НаименованиеРучное",
			Истина);
	Иначе
		НайденныйУзел = СцТ_ГлавнаяФорма.СцТ_НайтиУзелДереваФормы(
			ДеревоЗначения,
			"Имя",
			"ИСТЗ_НаименованиеРучное");
			
		Если НайденныйУзел <> Неопределено Тогда
			ДеревоЗначения.ПолучитьЭлементы().Удалить(НайденныйУзел);
		КонецЕсли;
	КонецЕсли;
	
	// Проверки
	Если ПустаяСтрока(ЯчейкаТД_АдресЯчейки) Тогда
		СцТ_СообщитьПользователю(НСтр("ru = 'Адрес ячейки должен быть заполнен'"),
		Отказ,
		"ЯчейкаТД_АдресЯчейки");
	КонецЕсли;
	
	// Сохранение данных
	
	СцТ_ГлавнаяФорма.СцТ_ДобавитьУзелВДеревоЗначения(
		ДеревоЗначения,
		"Действие",
		ЯчейкаТД_Действие);
		
	СцТ_ГлавнаяФорма.СцТ_ДобавитьУзелВДеревоЗначения(
		ДеревоЗначения,
		"Адрес",
		ЯчейкаТД_АдресЯчейки);
	
	СцТ_ГлавнаяФорма.СцТ_ДобавитьУзелВДеревоЗначения(
		ДеревоЗначения,
		"ТекстЯчейки",
		ЯчейкаТД_Значение);
		
	
	///
	
	СцТ_ГлавнаяФорма.СцТ_ДобавитьУзелВДеревоЗначения(
		ДеревоЗначения,
		"ДействиеПриОшибке",
		ДействиеПриОшибке);
		
	СцТ_ГлавнаяФорма.СцТ_ДобавитьУзелВДеревоЗначения(
		ДеревоЗначения,
		"ПеременнаяПриОшибке",
		ПеременнаяПриОшибке);
	
КонецПроцедуры

// Свертка данных шага в структуру
// и подготовка возвращаемой структуры отредактированного шага
&НаКлиенте
Функция СцТ_СформироватьСтруктуруданныхШага_НаКлиенте()
	
	// СДШ - структура данных шага
	СДШ = Новый Структура;
	
	СДШ.Вставить("ИдентификаторШага"           , ОА_ОписательПоложенияШагаВДереве.ИдентификаторШага);
	СДШ.Вставить("НаименованиеШага"            , ДШ_Наименование);
	СДШ.Вставить("ТипМетаданных"               , ДШ_ТипМетаданных);
	СДШ.Вставить("ИмяМетаданных"               , ДШ_ИмяМетаданных);
	СДШ.Вставить("Автоописание"                , ДШ_Автоописание);
	СДШ.Вставить("Описание"                    , ДШ_Описание);
	СДШ.Вставить("СкрытьАвтоописание"          , ДШ_СкрытьАвтоописание);
	СДШ.Вставить("ОбСсылка"                    , ДШ_ОбСсылка);
	СДШ.Вставить("ПредставлениеОбъекта"        , ДШ_ПредставлениеОбъекта);
	СДШ.Вставить("ВыполнитьВручную"            , ДШ_ВыполнитьВручную);
	СДШ.Вставить("Комментарий"                 , ДШ_Комментарий);
	СДШ.Вставить("ИмяФормы"                    , ДШ_ИмяФормы);
	СДШ.Вставить("ПредставлениеИмениМетаданных", ДШ_ПредставлениеИмениМетаданных);
	СДШ.Вставить("ЗаголовокФормы"              , ДШ_ЗаголовокФормы);
	СДШ.Вставить("ДанныеКартинки"              , ДШ_ДанныеКартинки);
	СДШ.Вставить("ДеревоЗначения"              , СцТ_ГлавнаяФорма.СцТ_ДеревоформыВДеревоСтруктур(ДеревоЗначения));
	
	
	// ВСД - возвращаемая структура данных
	ВСД = Новый Структура;
	ВСД.Вставить("ОписательПоложенияШагаВДереве", ОА_ОписательПоложенияШагаВДереве);
	ВСД.Вставить("Наименование"                 , ДШ_Наименование);
	ВСД.Вставить("Активность"                   , ОА_Активность);
	ВСД.Вставить("СтруктураДанныхШага"          , СДШ);
	ВСД.Вставить("ЭтоНовый"                     , ОА_ЭтоНовый);
	ВСД.Вставить("ТипШага"                      , ОА_ТипШага);
	
	Возврат ВСД;
	
КонецФункции

#КонецОбласти

#Область ФормированеОписанийИНаименований

// Формирование описания шага на клиенте
&НаКлиенте
Функция СцТ_СформироватьОписаниеШага_НаКлиенте(Краткое = Ложь)
	
	Если ЯчейкаТД_Действие = "Проверить" Тогда
		ВозвращаемоеОписание = НСтр("ru = 'В ячейке ""%1"" проверить значение ""%2""'");
		
	ИначеЕсли ЯчейкаТД_Действие = "Заполнить" Тогда
		ВозвращаемоеОписание = НСтр("ru = 'В ячейке ""%1"" ввести значение ""%2""'");
		
	ИначеЕсли ЯчейкаТД_Действие = "Нажать" Тогда
		ВозвращаемоеОписание = НСтр("ru = 'Нажать на значение в ячейке ""%1""'");
		
	ИначеЕсли ЯчейкаТД_Действие = "ВыбратьИзСписка" Тогда
		ВозвращаемоеОписание = НСтр("ru = 'В ячейке ""%1"" выбрать из списка значение ""%2""'");
		
	КонецЕсли;
	
	ВозвращаемоеОписание = СтрЗаменить(ВозвращаемоеОписание, "%1", ЯчейкаТД_АдресЯчейки);
	ВозвращаемоеОписание = СтрЗаменить(ВозвращаемоеОписание, "%2", ЯчейкаТД_Значение);
	
	Возврат ВозвращаемоеОписание;
	
КонецФункции

&НаКлиенте
Процедура СцТ_ОбновитьНаименование_НаКлиенте(Принудительно = Ложь)
	
	Если НЕ НаименованиеШагаИзмененоВручную ИЛИ Принудительно Тогда
		ДШ_Наименование = СцТ_СформироватьОписаниеШага_НаКлиенте(Истина);
	КонецЕсли;
	
	Если Принудительно Тогда
		НаименованиеШагаИзмененоВручную = Ложь;
		Модифицированность = Истина;
		// В остальных случаях менять модифицированность не нужно,
		// так как ее должно изменить изменение другого элемента формы
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

#Область ПроцедурыИФункцииРаботыСДеревомЗначения

// Возвращает значение заданного поля в дереве данных
//
// Параметры
//	ДерЗнач              - дерево с данными в котором ведется поиск
//	ИмяПараметра         - имя искомого параметра
//	ЕслиНеНайдено        - что вернуть, если значение не найдено
//	ВозвращаемыйРеквизит - имя колонки, которую нужно вернуть
//	Рекурсивно           - признак рекурсии
// Возвращаемое значение - значение нужного поля найденного узла
&НаСервереБезКонтекста
Функция СцТ_ЗначениеВДереве(
	ДерЗнач,
	ИмяПараметра,
	ЕслиНеНайдено = Неопределено,
	ВозвращаемыйРеквизит = "Значение",
	Рекурсивно = Истина)
	
	УзелЗначения = СцТ_НайтиУзелДереваФормы(ДерЗнач, "Имя", ИмяПараметра, Рекурсивно);
	Если УзелЗначения = Неопределено Тогда
		Возврат ЕслиНеНайдено;
	Иначе
		Возврат УзелЗначения[ВозвращаемыйРеквизит];
	КонецЕсли;
	
КонецФункции

// Поиск нужного узла в дереве данных
//
// Параметры
//	ДеревоФормы       - дерево, в котором ведется поиск
//	Реквизит          - имя поля в котором ведется поиск
//	ЗначениеРеквизита - значение в поле
//	Рекурсивно        - признак рекурсивного поиска
// Возвращаемое значение - найденный узел
&НаСервереБезКонтекста
Функция СцТ_НайтиУзелДереваФормы(
	ДеревоФормы,
	Реквизит,
	ЗначениеРеквизита,
	Рекурсивно = Ложь)
	
	Если ДеревоФормы = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Для каждого Узел Из ДеревоФормы.ПолучитьЭлементы() Цикл
		Если Узел[Реквизит] = ЗначениеРеквизита Тогда
			Возврат Узел;
		КонецЕсли;
		Если Рекурсивно Тогда
			НайденыйУзел = СцТ_НайтиУзелДереваФормы(Узел, Реквизит, ЗначениеРеквизита, Истина);
			Если НайденыйУзел <> Неопределено Тогда
				Возврат НайденыйУзел;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Заполнение дерева значения данными из структуры
//
// параметры
//	ДеревоФормы - заполняемое дерево
//	ДеревоСтруктур - структура с данными
&НаСервереБезКонтекста
Процедура СцТ_ЗаполнитьДеревоФормыИзДереваСтруктур(ДеревоФормы, ДеревоСтруктур)
	
	СтрокиДереваФормы = ДеревоФормы.ПолучитьЭлементы();
	Для каждого СтрокаДереваСтруктур Из ДеревоСтруктур.ИСТЗ_Строки Цикл
		СтрокаДереваФормы = СтрокиДереваФормы.Добавить();
		Для каждого КлючЗначение Из СтрокаДереваСтруктур Цикл
			Если КлючЗначение.Ключ <> "ИСТЗ_Строки" Тогда
				СтрокаДереваФормы[КлючЗначение.Ключ] = КлючЗначение.Значение;
			КонецЕсли;
		КонецЦикла;
		СцТ_ЗаполнитьДеревоФормыИзДереваСтруктур(СтрокаДереваФормы, СтрокаДереваСтруктур);
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПреобразоватьЗначенияВДереве(ВеткаДерева, ДляОтображения = Истина)
	
	Для каждого СтрокаДерева Из ВеткаДерева.Строки Цикл
		
		Если ДляОтображения Тогда
			СтрокаДерева.Значение = ЗначениеИзСтрокиВнутр(СтрокаДерева.Значение);
		Иначе
			СтрокаДерева.Значение = ЗначениеВСтрокуВнутр(СтрокаДерева.Значение);
		КонецЕсли;
		
		ПреобразоватьЗначенияВДереве(СтрокаДерева, ДляОтображения);
		
	КонецЦикла;
	
КонецПроцедуры


#КонецОбласти

#Область ДополнительныеПроцедурыИФункции

// Обновление картинок на закладках
// Вызывается посредством обработки ожидания, чтобы форма нормально закрывалась после редактирования
&НаКлиенте
Процедура СцТ_ОбновитьЗаголовкиЗакладок()
	
	Элементы.Страница_РедактируемоеОписание.Картинка = ?(
		ПустаяСтрока(ДШ_Описание),
		Новый Картинка,
		БиблиотекаКартинок.РежимПросмотраСпискаСписок);
	
	Элементы.Страница_Комментарий.Картинка = ?(
		ПустаяСтрока(ДШ_Комментарий),
		Новый Картинка,
		БиблиотекаКартинок.РежимПросмотраСпискаСписок);
	
КонецПроцедуры

// Отображение родительского шага
// Параметры:
// ПриОткрытии - устанавливает признак, что настройка выполняется при открытии
// или (в противном случае) по обработке оповещения
&НаКлиенте
Процедура СцТ_СформироватьПредставлениеРодителя(ПриОткрытии = Истина) Экспорт
	
	Если ОА_ЭтоНовый И ПриОткрытии Тогда
		Если ОА_ОписательПоложенияШагаВДереве.ИдентификаторУзлаРодителя = Неопределено Тогда
			ПредставлениеГруппы = "";
		Иначе
			// Поиск данных родительского узла в дереве по идентификатору шага
			СцТ_РодительУзла = СцТ_ГлавнаяФорма.СцТ_ПолучитьДанныеШагаПоИдентификатору(ВызвавшаяФорма,
				ОА_ОписательПоложенияШагаВДереве.ИдентификаторУзлаРодителя);
			
			Если СцТ_РодительУзла = Неопределено Тогда
				ПредставлениеГруппы = "";
			Иначе
				ОтобразитьПредставлениеСуществующегоРодительскогоШага(СцТ_РодительУзла);
			КонецЕсли;
		КонецЕсли;
		
		// Если родительский узел будет изменен у нового шага, то редактируемый шаг уже не имеет смысла,
		// так как неизвестно куда его вставить
		
	ИначеЕсли НЕ ОА_ЭтоНовый Тогда
		Если ДанныеШага = Неопределено Тогда
			ПредставлениеГруппы = "";
		Иначе
			СцТ_РодительУзла = ДанныеШага.ПолучитьРодителя();
			Если СцТ_РодительУзла = Неопределено Тогда
				ПредставлениеГруппы = "";
			Иначе
				ОтобразитьПредставлениеСуществующегоРодительскогоШага(СцТ_РодительУзла);
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
	Если ПредставлениеГруппы = "" Тогда
		Элементы.СтраницыГрупп.ТекущаяСтраница = Элементы.СтраницаПустойГруппы;
	Иначе
		Элементы.СтраницыГрупп.ТекущаяСтраница = Элементы.СтраницаЗаполненнойГруппы;
	КонецЕсли;
	
КонецПроцедуры

// Формирование представление существующего шага
// параметры
// РодительскийШаг - указатель на данные родительского шага.
// НЕ может быть Неопределено
&НаКлиенте
Процедура ОтобразитьПредставлениеСуществующегоРодительскогоШага(РодительскийШаг)
	
	ПредставлениеГруппы = НСтр("ru = 'Шаг №%1 ""%2""'");
	ПредставлениеГруппы = СтрЗаменить(
		ПредставлениеГруппы,
		"%1",
		Формат(РодительскийШаг.НомерШага, "ЧГ=0"));
	
	ПредставлениеГруппы = СтрЗаменить(
		ПредставлениеГруппы,
		"%2",
		РодительскийШаг.Наименование);
	
КонецПроцедуры

// Вывод сообщения пользователю
//
// Параметры
// ТекстСообщения - отображаемый текст
// Отказ - ссылка на переменную отказ в вызываемой процедуре
// ПолеДанных - поле, которое должно получить фокус
&НаКлиенте
Процедура СцТ_СообщитьПользователю(ТекстСообщения, Отказ = Неопределено, ПолеДанных = "")
	
	Отказ = Истина;
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ТекстСообщения;
	Сообщение.Поле  = ПолеДанных;
	Сообщение.Сообщить();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеДоступностьюПеременнойОшибкиГрупповогоШага(УпрФорма)
	
	Если УпрФорма.ДействиеПриОшибке = "Остановить" Тогда
		УпрФорма.Элементы.СтраницыПеременнойОшибки.ТекущаяСтраница = УпрФорма.Элементы.СтраницыПеременнойОшибки_Пустая;
	Иначе
		УпрФорма.Элементы.СтраницыПеременнойОшибки.ТекущаяСтраница = УпрФорма.Элементы.СтраницыПеременнойОшибки_Заполненная;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораОбъектаМетаданных(Результат, ДопПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДШ_ИмяМетаданных = Результат.Значение;
	ДШ_ПредставлениеИмениМетаданных = Результат.Представление;
	
КонецПроцедуры


&НаКлиенте
Процедура ОбновитьПользовательскоеОписание()
	
	ТекстОписания = ДШ_Описание;
	
	Если НЕ ДШ_СкрытьАвтоописание Тогда
		ДШ_Автоописание = СцТ_СформироватьОписаниеШага_НаКлиенте();
		ТекстОписания = СцТ_ГлавнаяФорма.СцТ_ДобавитьПодстроку(ТекстОписания, ДШ_Автоописание, Символы.ПС);
	КонецЕсли;
	
	ПользовательскоеОписание = ТекстОписания;
	
КонецПроцедуры

&НаКлиенте
Процедура ДШ_СкрытьАвтоописаниеПриИзменении(Элемент)
	
	ОбновитьПользовательскоеОписание();
	
КонецПроцедуры

&НаКлиенте
Процедура СтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	Если Элемент.ТекущаяСтраница = Элементы.Страница_ОписаниеШага Тогда
		ОбновитьПользовательскоеОписание();
	КонецЕсли;
	
КонецПроцедуры



&НаКлиенте
Процедура ПолучитьИзРодительскогоУзла(Команда)
	
	Если ОА_ЭтоНовый Тогда
		РодительУзла = СцТ_ГлавнаяФорма.СцТ_ПолучитьДанныеШагаПоИдентификатору(ВызвавшаяФорма,ОА_ОписательПоложенияШагаВДереве.ИдентификаторУзлаРодителя);
	Иначе
		РодительУзла = ДанныеШага.ПолучитьРодителя();
	КонецЕсли;
	
	Если РодительУзла = Неопределено Тогда
		ТекстПредупреждения = НСтр("ru = 'Не удалось получить родительский узел'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
		Возврат;
	КонецЕсли;
	
	ДШ_ИмяФормы = РодительУзла.ИмяФормы;
	ДШ_ЗаголовокФормы = РодительУзла.ЗаголовокФормы;
	
	ДЗ = РодительУзла.Значение;
	
	
КонецПроцедуры

// Получение контейнера тестируемого приложения
// Привязка
//
&НаКлиенте
Процедура СцТ_ПолучитьИнтерактивныйКонтейнер()
	
	// Так как шаг может быть еще не записан, то удобно получить форму для родительского шага
	Если ОА_ЭтоНовый Тогда
		РодительУзла = СцТ_ГлавнаяФорма.СцТ_ПолучитьДанныеШагаПоИдентификатору(ВызвавшаяФорма,ОА_ОписательПоложенияШагаВДереве.ИдентификаторУзлаРодителя);
	Иначе
		РодительУзла = ДанныеШага.ПолучитьРодителя();
	КонецЕсли;
	
	// Сообщения об ошибках показывать не нужно, так как редактирование шага может
	// выполняться без использования тестируемой формы
	ОписаниеОшибкиПолученияКонтейнера = "";
	ИнтерактивныйКонтейнер = СцТ_ГлавнаяФорма.СцТ_ПолучитьИнтерактивныйКонтейнерДляШагаСценария(
		РодительУзла,
		ОписаниеОшибкиПолученияКонтейнера,
		Истина);
	
	Если НЕ ПустаяСтрока(ОписаниеОшибкиПолученияКонтейнера) Тогда
		ИнтерактивныйКонтейнер = Неопределено;
		//ПоказатьПредупреждение(, СцТ_ГлавнаяФорма.СцТ_РасшифроватьОшибку(ОписаниеОшибкиПолученияКонтейнера));
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ИнтерактивныйКонтейнер) <> Тип("ТестируемаяФорма") Тогда
		ИнтерактивныйКонтейнер = Неопределено;
		//ТП = НСтр("ru = 'Не найдена тестируемая форма'");
		//ПоказатьПредупреждение(, ТП);
		Возврат;
	КонецЕсли;
	
	// Проверить, открыта ли форма
	Попытка
		ФормаЗакрыта = ИнтерактивныйКонтейнер.ОжидатьЗакрытие(0);
	Исключение
		ФормаЗакрыта = Истина;
	КонецПопытки;
	
	Если ФормаЗакрыта Тогда
		ИнтерактивныйКонтейнер = Неопределено;
		//ПоказатьПредупреждение(, НСтр("ru = 'Не удалось обратиться к форме тестируемого приложения:
		//	|форма была закрыта, либо тестируемое приложение не запущено.'"));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьПоДаннымФормы(Команда)
	
	Если ИнтерактивныйКонтейнер = Неопределено Тогда
		СцТ_ПолучитьИнтерактивныйКонтейнер();
	КонецЕсли;
	
	Если ИнтерактивныйКонтейнер = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ДействиеПроверки = "ПроверитьЗаголовок" Тогда
		Попытка
			ЗначениеПроверки = ИнтерактивныйКонтейнер.ТекстЗаголовка;
		Исключение
			ЗначениеПроверки = "";
		КонецПопытки;
		
		
	ИначеЕсли ДействиеПроверки = "ПроверитьМодифицированность" Тогда
		Попытка
			ТекМодифицированность = ИнтерактивныйКонтейнер.ТекущаяМодифицированность();
		Исключение
			ТекМодифицированность = Ложь;
		КонецПопытки;
		
		Если ТекМодифицированность Тогда
			ЗначениеПроверки = "Модифицирована";
		Иначе
			ЗначениеПроверки = "НЕМодифицирована";
		КонецЕсли;
		
		// на других страницах кнопки обновления нет
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЯчейкаТД_ЗначениеПриИзменении(Элемент)
	
	СцТ_ОбновитьНаименование_НаКлиенте();
	
КонецПроцедуры


#КонецОбласти

#КонецОбласти

