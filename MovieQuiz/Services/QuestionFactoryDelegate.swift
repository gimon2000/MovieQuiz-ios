//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by gimon on 12.01.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
