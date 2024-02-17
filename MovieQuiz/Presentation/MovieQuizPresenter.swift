//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by gimon on 17.02.2024.
//

import UIKit

final class MovieQuizPresenter: QuestionFactoryDelegate {
    
    private var currentQuestionIndex = 0
    let questionsAmount = 10
    var correctAnswers = 0
    var currentQuestion: QuizQuestion?
    var questionFactory: QuestionFactoryProtocol?
    var alertPresenter: AlertPresenter?
    var statisticService: StatisticService?
    weak var viewController: MovieQuizViewController?
    
    init(viewController: MovieQuizViewController) {
        self.viewController = viewController
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        viewController.showLoadingIndicator()
    }
    
    func didLoadDataFromServer() {
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        viewController?.showNetworkError(message: error.localizedDescription)
    }
    
    func restartGame() {
        correctAnswers = 0
        currentQuestionIndex = 0
        questionFactory?.requestNextQuestion()
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func convertQuestionToViewModel(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)"
        )
    }
    
    func yesButtonClicked() {
        didAnswer(isYes: true)
    }
    
    func noButtonClicked() {
        didAnswer(isYes: false)
    }
    
    // MARK: - QuestionFactoryDelegate
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convertQuestionToViewModel(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    func showNextQuestionOrResults() {
        if self.isLastQuestion() {
            self.statisticService?.store(correct: correctAnswers, total: self.questionsAmount)
            guard let count = self.statisticService?.gamesCount else {
                return
            }
            guard let bestGame = self.statisticService?.bestGame else {
                return
            }
            guard let totalAccuracy = self.statisticService?.totalAccuracy else {
                return
            }
            let dateFormatter = DateFormatter()
            let date = bestGame.date
            dateFormatter.dateFormat = "dd.MM.yy' 'HH:mm"
            let text = """
Ваш результат: \(correctAnswers)/10
Количество сыгранных квизов: \(count)
Рекорд: \(bestGame.correct)/10 (\(dateFormatter.string(from: date)))
Средняя точность: \(String(format: "%.2f", totalAccuracy))%
"""
            
            let alertModel = AlertModel(
                title: "Этот раунд окончен!",
                message: text,
                buttonText: "Сыграть ещё раз")
            { [weak self] in
                guard let self = self else { return }
                
                self.restartGame()
            }
            alertPresenter?.requestShowAlert(alertModel: alertModel)
        } else {
            self.switchToNextQuestion()
            questionFactory?.requestNextQuestion()
        }
    }
    
    private func didAnswer(isYes: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = isYes
        
        let isCorrect = givenAnswer == currentQuestion.correctAnswer
        
        if isCorrect {
            correctAnswers += 1
        }
        
        viewController?.showAnswerResult(isCorrect: isCorrect)
        
    }
    
}
