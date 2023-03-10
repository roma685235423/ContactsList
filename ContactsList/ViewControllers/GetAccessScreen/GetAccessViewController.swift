import UIKit

final class GetAccessViewConrtoller: UIViewController {
    // MARK: - Properties
    private let logoImageView = UIImageView()
    
    // MARK: - Lifecicle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        view?.backgroundColor = MyColors.fullBlack
        configureLogoImageView()
        configureGetAccessButton()
    }
    
    // MARK: - Methods
    private func configureLogoImageView() {
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
    
    
    private func configureGetAccessButton() {
        let getAccessButton = UIButton()
        getAccessButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(getAccessButton)
        getAccessButton.addTarget(self, action: #selector(Self.didTapGetAccessButton), for: .touchUpInside)
        getAccessButton.setTitle("Хочу увидеть свои контакты", for: .normal)
        getAccessButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        getAccessButton.titleLabel?.textColor = MyColors.white
        getAccessButton.backgroundColor = MyColors.blue
        getAccessButton.layer.cornerRadius = 24
        
        NSLayoutConstraint.activate([
            getAccessButton.heightAnchor.constraint(equalToConstant: 64),
            getAccessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +20),
            getAccessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getAccessButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58)
        ])
    }
    
    
    @objc
    private func didTapGetAccessButton() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
