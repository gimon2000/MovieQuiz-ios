//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by gimon on 15.01.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}
