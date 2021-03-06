//
//  FlowTest.swift
//  QuizEDEngineTests
//
//  Created by Caio Fernandes on 26/02/22.
//

import XCTest
@testable import QuizEDEngine

class FlowTest: XCTestCase {
    let router = RouterSpy()

    
    func test_start_withoutQuestions_doesNotRouteToQuestion() {
        makeSystemUnderTest(questions: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSystemUnderTest(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSystemUnderTest(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSystemUnderTest(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let systemUnderTest = makeSystemUnderTest(questions: ["Q1", "Q2"])
        
        systemUnderTest.start()
        systemUnderTest.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let systemUnderTest = makeSystemUnderTest(questions: ["Q1", "Q2", "Q3"])
        systemUnderTest.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let systemUnderTest = makeSystemUnderTest(questions: ["Q1"])
        systemUnderTest.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestion_doesNotRouteToAnotherQuestion() {
        let systemUnderTest = makeSystemUnderTest(questions: ["Q1", "Q2"])
        systemUnderTest.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    //MARK: Helpers
    
    func makeSystemUnderTest(questions: [String]) -> Flow {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: AnswerCallback = {_ in}
        
        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
