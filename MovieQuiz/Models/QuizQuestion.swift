//
//  QuizQuestion.swift
//  MovieQuiz
//
//  Created by gimon on 09.01.2024.
//

import Foundation

struct QuizQuestion {
    // строка с названием фильма,
    // совпадает с названием картинки афиши фильма в Assets
    let image: Data
    // строка с вопросом о рейтинге фильма
    let text: String
    // булево значение (true, false), правильный ответ на вопрос
    let correctAnswer: Bool
}
