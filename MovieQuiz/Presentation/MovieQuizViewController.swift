import UIKit

final class MovieQuizViewController: UIViewController, ShowAlertDelegate {
    
    private var presenter: MovieQuizPresenter!
    private var statisticService: StatisticService?
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
        
        statisticService = StatisticServiceImplementation()
        
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
            self.presenter.questionFactory?.loadData()
            self.presenter.restartGame()
        }
        alertPresenter?.requestShowAlert(alertModel: alertModel)
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func showAnswerResult(isCorrect: Bool) {
        noButton.isEnabled = false
        yesButton.isEnabled = false
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        { [weak self] in
            guard let self = self else { return }
            
            self.presenter.statisticService = self.statisticService
            self.presenter.alertPresenter = self.alertPresenter
            self.presenter.showNextQuestionOrResults()
            self.imageView.layer.borderWidth = 0
            self.noButton.isEnabled = true
            self.yesButton.isEnabled = true
        }
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
}
