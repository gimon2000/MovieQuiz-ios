//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by gimon on 08.01.2024.
//

import Foundation

class QuestionFactory {
    // массив вопросов
    private let questions: [QuizQuestion] = [
        QuizQuestion(image:"The Godfather", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image:"The Dark Knight", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image:"Kill Bill", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image:"The Avengers", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image:"Deadpool", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image:"The Green Knight", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image:"Old", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image:"The Ice Age Adventures of Buck Wild", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image:"Tesla", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image:"Vivarium", text:"Рейтинг этого фильма больше чем 6?", correctAnswer: false)]
    
    func requestNextQuestion() -> QuizQuestion? { // функция будет возвращать nil, если получить следующий вопрос невозможно
        guard let index = (0..<questions.count).randomElement() else {
            return nil
        } // вопрос должен быть случайным
        
        return questions[safe: index] // Subscript – это, по сути, сокращённый путь к члену коллекции. А subscript safe — функция, которую мы добавили в расширении массива. Она поможет безопасно достать из него элемент: если индекс выйдет за пределы размера массива, вместо крэша нам просто вернётся nil.
    }
}
