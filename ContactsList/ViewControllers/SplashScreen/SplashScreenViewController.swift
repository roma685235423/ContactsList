import UIKit
import Contacts

protocol SplashScreenViewControllerProtocol {
    var presenter: SplashScreenPresenterProtocol? { get set }
    func configureLogoImageView()
}

final class SplashScreenViewControler: UIViewController & SplashScreenViewControllerProtocol {
    var presenter: SplashScreenPresenterProtocol?
    
    private let logoImageView = UIImageView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        view?.backgroundColor = MyColors.fullBlack
        presenter?.view = self
        presenter?.viewDidLoad()
    }
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        guard let image = UIImage(named: "logo") else { return }
        logoImageView.image = image
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: image.size.height),
            logoImageView.widthAnchor.constraint(equalToConstant: image.size.width),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
