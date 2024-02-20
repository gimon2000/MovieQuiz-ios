//
//  MovieQuizViewControllerMock.swift
//  MovieQuizTests
//
//  Created by gimon on 18.02.2024.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func showLoadingIndicator() {}
    
    func hideLoadingIndicator() {}
    
    func showNetworkError(message: String) {}
    
    func show(quiz step: MovieQuiz.QuizStepViewModel) {}
    
    func highlightImageBorder(isCorrectAnswer: Bool) {}
    
    func showAlertResults() {}
}
