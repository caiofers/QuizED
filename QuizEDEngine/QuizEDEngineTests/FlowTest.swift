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
    
    func test_start_withOneQuestion_RoutesToQuestion() {
        let router = RouterSpy()
        let systemUnderTest = Flow(questions: ["Q1"], router: router)
        
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    class RouterSpy: Router {
        var routedQuestionCount = 0
        
        func routeTo(question: String) {
            routedQuestionCount += 1
        }
    }
}
