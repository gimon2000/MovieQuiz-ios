//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by gimon on 18.02.2024.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showNetworkError(message: String)
    func show(quiz step: QuizStepViewModel)
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showAlertResults()
}
