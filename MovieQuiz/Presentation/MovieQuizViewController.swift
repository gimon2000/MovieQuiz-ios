import UIKit

final class MovieQuizViewController: UIViewController, ShowAlertDelegate, MovieQuizViewControllerProtocol {
    
    private var presenter: MovieQuizPresenter?
    private var alertPresenter: AlertPresenter?
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        
        alertPresenter = AlertPresenter()
        alertPresenter?.delegate = self
        
        showLoadingIndicator()
        
        presenter = MovieQuizPresenter(viewController: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let alertModel = AlertModel(
            title: "Что-то пошло не так(",
            message: message,
            buttonText: "Попробовать еще раз")
        { [weak self] in
            guard let self = self else { return }
            
            self.showLoadingIndicator()
            self.presenter?.loadDataFromServer()
        }
        alertPresenter?.requestShowAlert(alertModel: alertModel)
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
        imageView.layer.borderWidth = 0
        changeButtonState(isEnabled: true)
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }
    
    func showAlertResults() {
        let alertModel = AlertModel(
            title: "Этот раунд окончен!",
            message: self.presenter?.makeResultsMessage() ?? "Fail get results",
            buttonText: "Сыграть ещё раз")
        { [weak self] in
            guard let self = self else { return }
            
            self.presenter?.restartGame()
        }
        alertPresenter?.requestShowAlert(alertModel: alertModel)
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        changeButtonState(isEnabled: false)
        presenter?.noButtonClicked()
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        changeButtonState(isEnabled: false)
        presenter?.yesButtonClicked()
    }
    
    private func changeButtonState(isEnabled: Bool) {
        noButton.isEnabled = isEnabled
        yesButton.isEnabled = isEnabled
    }
}
