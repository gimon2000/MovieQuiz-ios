//
//  MovieQuizPresenterTests.swift
//  MovieQuizTests
//
//  Created by gimon on 18.02.2024.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizPresenterTests: XCTestCase {
    private func testPresenterConvertModel() throws {
        let viewControllerMock = MovieQuizViewControllerMock()
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
        let viewModel = sut.convertQuestionToViewModel(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
}
