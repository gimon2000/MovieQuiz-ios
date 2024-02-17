//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by gimon on 17.02.2024.
//

import UIKit

final class MovieQuizPresenter {
    
    private var currentQuestionIndex = 0
    let questionsAmount = 10
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func convertQuestionToViewModel(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
}
