import UIKit
import Contacts

final class SplashScreenViewControler: UIViewController & SplashScreenViewControllerProtocol {
    // MARK: - Public properties
    
    var presenter: SplashScreenPresenterProtocol?
    
    // MARK: - Private properties
    
    private let logoImageView = UIImageView()
    
    // MARK: - Lifecicle
    
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
    
    // MARK: - Public methods
    
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
