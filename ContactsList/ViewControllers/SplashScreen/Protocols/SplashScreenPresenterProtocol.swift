import Foundation

// MARK: - SplashScreenPresenterProtocol

protocol SplashScreenPresenterProtocol {
    var view: SplashScreenViewControllerProtocol? { get set }
    func viewDidLoad()
}
