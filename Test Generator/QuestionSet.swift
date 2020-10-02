//
//  QuestionSet.swift
//  Test Generator
//
//  Created by Esha Shetty on 2019-11-19.
//  Copyright © 2019 Esha Shetty. All rights reserved.
//

import Foundation

class QuestionSet:NSObject, Codable{
    
    var question: String
    var answer: String
    var choices: [String]
    
    override init(){
        self.question = ""
        self.answer = ""
        self.choices = ["","","",""]
    }
}
