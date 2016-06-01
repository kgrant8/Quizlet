//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Keith on 5/28/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

// enum used to classify the questions to change the view according to question asked
enum QuestionType {
    case TrueFalse
    case MutliChoice
}

//Question class that can hold both True and False questions and Multi-choice questions
class Question
{
    let type : QuestionType
    let question : String
    let answer : String
    var wrongChoice1: String? = nil
    var wrongChoice2: String? = nil
    var wrongChoice3: String? = nil
    
    init(type: QuestionType,question: String, answer: String,wrongChoice1: String?,wrongChoice2: String?,wrongChoice3: String?) {
        self.type = type
        self.question = question
        self.answer = answer
        self.wrongChoice1 = wrongChoice1
        self.wrongChoice2 = wrongChoice2
        self.wrongChoice3 = wrongChoice3
        
    }
    
    init(type: QuestionType,question: String, answer: String)
    {
        self.type = type
        self.question = question
        self.answer = answer
    }
    
    
}

//The data set of questions asked current count is 11 questions 4 asked per round. 

let quiz = [Question (type: QuestionType.MutliChoice, question :"Where was the 1986 World Cup held?",answer:"Mexico",wrongChoice1: "Brazil",wrongChoice2: "Argentina",wrongChoice3: "Germany"),
            Question (type: QuestionType.MutliChoice, question :"Which Country is the winner of FIFA World Cup 2014?",answer:"Germany",wrongChoice1: "Brazil",wrongChoice2: "Netherlands",wrongChoice3: "England"),
            Question (type: QuestionType.MutliChoice, question :"Who was the winner of Golden Ball award in the FIFA World Cup 2014?",answer:"Lionel Messi",wrongChoice1: "Neymar Jr",wrongChoice2: "Ronaldo",wrongChoice3: "Thomas Muller"),
            Question (type: QuestionType.MutliChoice, question :"The first winner of the FIFA World Cup is",answer:"Uruguay",wrongChoice1: "Brazil",wrongChoice2: "England",wrongChoice3: "Germany"),
            Question (type: QuestionType.MutliChoice, question :"Who won the inaugural Women’s World Cup in 1991?",answer:"United States",wrongChoice1: "Brazil",wrongChoice2: "England",wrongChoice3: "China"),
            Question (type: QuestionType.MutliChoice, question :"Wales scored 11 goals in qualifying for EURO 2016 - how many of these did Gareth Bale score?",answer:"7",wrongChoice1: "9",wrongChoice2: "4",wrongChoice3: "0"),
            Question (type: QuestionType.MutliChoice, question :"In 2007, Ajax decided to retire which number shirt in honour of Cruyff?",answer:"14",wrongChoice1: "7",wrongChoice2: "8",wrongChoice3: "12"),
            Question (type: QuestionType.MutliChoice, question :"England's World Cup debut came in 1950, where they suffered an infamous 1-0 defeat by which nation?",answer:"United States",wrongChoice1: "Germany",wrongChoice2: "Brazil",wrongChoice3: "Wales"),
            Question (type: QuestionType.MutliChoice, question :"Which football player is famous for his 1986 'Hand of God'?",answer:"Diego Maradona",wrongChoice1: "Geoff Hurst",wrongChoice2: "Peter Shilton",wrongChoice3: "Franz Beckenbauer"),
            Question (type: QuestionType.MutliChoice, question :"Which English goalkeeper made his world cup debut aged 39?'?",answer:"David James",wrongChoice1: "David Seaman",wrongChoice2: "Peter Shilton",wrongChoice3: "Joe Hart"),
            Question (type: QuestionType.MutliChoice, question :"Who was famously sent off in the 1998 World Cup against Argentina",answer:"David Beckham",wrongChoice1: "David Seaman",wrongChoice2: "Ryan Giggs",wrongChoice3: "John Terry"),
            
            
]