import Foundation

// MARK: - SplashScreenViewControllerProtocol

protocol SplashScreenViewControllerProtocol {
    var presenter: SplashScreenPresenterProtocol? { get set }
    func configureLogoImageView()
}
