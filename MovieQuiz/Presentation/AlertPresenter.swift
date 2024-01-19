//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by gimon on 15.01.2024.
//

import UIKit

class AlertPresenter {
    
    weak var delegate: ShowAlertDelegate?
    
    func requestShowAlert(alertModel: AlertModel?) {
        guard let alertModel = alertModel else {
            return
        }
        
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default){ _ in alertModel.completion() }
        alert.addAction(action)
        delegate?.showAlert(alert: alert)
    }
}
