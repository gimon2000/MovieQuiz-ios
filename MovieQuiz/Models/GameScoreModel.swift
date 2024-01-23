//
//  GameScoreModel.swift
//  MovieQuiz
//
//  Created by gimon on 21.01.2024.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ another: GameRecord) -> Bool {
        correct >= another.correct
    }
}
