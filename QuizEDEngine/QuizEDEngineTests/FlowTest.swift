//
//  FlowTest.swift
//  QuizEDEngineTests
//
//  Created by Caio Fernandes on 26/02/22.
//

import XCTest
@testable import QuizEDEngine

class FlowTest: XCTestCase {
    func test_start_withoutQuestions_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: [], router: router)
        
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q1"], router: router)
        
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q1"], router: router)
        
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q2"], router: router)
        
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestion, "Q2")
    }
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String? = nil
        
        func routeTo(question: String) {
            routedQuestionCount += 1
            routedQuestion = question
        }
    }
}
