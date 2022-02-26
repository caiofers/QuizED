//
//  Flow.swift
//  QuizEDEngine
//
//  Created by Caio Fernandes on 26/02/22.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let question = questions.first {
            router.routeTo(question: question) {[weak self]_ in
                guard let self = self else { return }
                
                let firstQuestionIndex = self.questions.firstIndex(of: question)!
                let nextQuestion = self.questions[firstQuestionIndex + 1]
                self.router.routeTo(question: nextQuestion) { _ in
                    
                }
            }
        }
    }
}
