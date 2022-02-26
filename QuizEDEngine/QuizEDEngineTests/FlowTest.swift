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
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q1"], router: router)
        
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q2"], router: router)
        
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q1", "Q2"], router: router)
        
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q1", "Q2"], router: router)
        
        systemUnderTest.start()
        systemUnderTest.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q1", "Q2"], router: router)
        systemUnderTest.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: (String) -> Void = {_ in}
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
