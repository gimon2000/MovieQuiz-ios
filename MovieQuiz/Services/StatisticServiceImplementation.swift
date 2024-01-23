//
//  StatisticServiceImplementation.swift
//  MovieQuiz
//
//  Created by gimon on 21.01.2024.
//

import Foundation

final class StatisticServiceImplementation: StatisticService {
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount, totalAccuracy
    }
    
    var totalAccuracy: Double {
        get {
            userDefaults.double(forKey: Keys.totalAccuracy.rawValue)
        }
        
        set {
            let oldValue = totalAccuracy
            let value = (((oldValue / 10) * Double(gamesCount) + newValue / 10) / Double(gamesCount+1)) * 10
            userDefaults.set(value, forKey: Keys.totalAccuracy.rawValue)
        }
    }
    
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        
        set {
            let value = gamesCount + newValue
            userDefaults.set(value, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        
        let newRecord = GameRecord(correct: count, total: amount, date: Date())
        if !bestGame.isBetterThan(newRecord) {
            bestGame = newRecord
        }
        totalAccuracy = Double(count) * 10
        gamesCount = 1
    }
    
    
}
