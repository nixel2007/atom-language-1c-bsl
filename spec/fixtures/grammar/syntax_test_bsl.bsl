// SYNTAX TEST "source.bsl"
#Область ИмяОбласти  
// ^ keyword.other.section.bsl
//       ^ entity.name.section.bsl

// Комментарий процедуры
// ^ comment.line.double-slash.bsl
Процедура ИмяПроцедуры(Знач ПараметрСКонстантой, ОбычныйПараметр, ПараметрСДефолтнымЧисловымЗначением = 0) Экспорт
// ^ storage.type.bsl
//        ^ entity.name.function.bsl
//                     ^ storage.modifier.bsl
//                          ^ variable.parameter.bsl
//                                             ^ keyword.operator.bsl
//                                               ^ variable.parameter.bsl
//                                                                                                    ^ keyword.operator.comparison.bsl
//                                                                                                      ^ constant.numeric.bsl
//                                                                                                         ^ storage.modifier.bsl

    А = 0;
//    ^ keyword.operator.comparison.bsl
//      ^ constant.numeric.bsl
//       ^ keyword.operator.bsl

    Б = "текст с экраннированной "" кавычкой";
//       ^ string.quoted.double.bsl
//                               ^ constant.character.escape.bsl
    
    Если А = 0 Тогда
//  ^ keyword.control.conditional.bsl
//         ^ keyword.operator.comparison.bsl
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
    
КонецПроцедуры
// ^ storage.type.bsl

Процедура НевстроеннаяПроцедура()
    Возврат;
//  ^ keyword.control.bsl
КонецПроцедуры

#КонецОбласти
// ^ keyword.other.section.bsl
