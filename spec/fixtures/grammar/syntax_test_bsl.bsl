// SYNTAX TEST "source.bsl"
#Область ИмяОбласти
// <- keyword.other.section.bsl
//       ^ entity.name.section.bsl

Перем А Экспорт;
// <- storage.type.var.bsl
//      ^ storage.modifier.bsl

// Комментарий процедуры
// <- comment.line.double-slash.bsl
Процедура ИмяПроцедуры(
// <- storage.type.bsl
//        ^ entity.name.function.bsl
    Знач ПараметрСКонстантой,
//  ^ storage.modifier.bsl
//       ^ variable.parameter.bsl
//                          ^ keyword.operator.bsl
    ОбычныйПараметр,
//  ^ variable.parameter.bsl
    ПараметрСНекорректнымЗначением = Нелегальщина,
//                                   ^ invalid.illegal.bsl
    ПараметрСНекорректнымЗначением =НелегальщинаБезПробела,
//                                  ^ invalid.illegal.bsl
    ПараметрСДефолтнымЧисловымЗначением = 0) Экспорт
//                                      ^ keyword.operator.comparison.bsl
//                                        ^ constant.numeric.bsl
//                                           ^ storage.modifier.bsl

    Б = "текст с экраннированной "" кавычкой";
//       ^ string.quoted.double.bsl
//                               ^ constant.character.escape.bsl
//                                           ^ keyword.operator.bsl

    В = "многострочная
//      ^ string.quoted.double.bsl
    |строка
//  ^ string.quoted.double.bsl
    //|это комментарий
//      ^ comment.line.double-slash.bsl
    |// а это нет
//      ^ string.quoted.double.bsl
    |";
//   ^ string.quoted.double.bsl
//    ^ keyword.operator.bsl

    GUID = 00000000-0000-0000-0000-000000000000;
//         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.bsl 
    Если А = 0 Тогда
//  ^ keyword.control.conditional.bsl
//         ^ keyword.operator.comparison.bsl
//           ^ constant.numeric.bsl
//             ^ keyword.control.conditional.bsl

        ОбычныйПараметр = Истина;
//                        ^ constant.language.bsl
    Иначе
//  ^ keyword.control.conditional.bsl
        ОбычныйПараметр = Ложь;
    КонецЕсли;
//  ^ keyword.control.conditional.bsl
    
    Пока ЗначениеЗаполнено(Б) Цикл
//  ^ keyword.control.repeat.bsl
//       ^ support.function.bsl
        Прервать;
//      ^ keyword.control.repeat.bsl        
    КонецЦикла;
//  ^ keyword.control.repeat.bsl
    
    НевстроеннаяПроцедура();
//  x^ support.function.bsl
    
КонецПроцедуры
// <- storage.type.bsl

Процедура НевстроеннаяПроцедура()
    Возврат;
//  ^ keyword.control.bsl
КонецПроцедуры

#КонецОбласти
// <- keyword.other.section.bsl
