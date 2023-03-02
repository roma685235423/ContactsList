import UIKit
import Contacts

protocol SplashScreenPresenterProtocol {
    var view: SplashScreenViewControllerProtocol? { get set }
    func viewDidLoad()
}

final class SplashScreenPresenter: SplashScreenPresenterProtocol {
    var view: SplashScreenViewControllerProtocol?
    
    private let contactStore = CNContactStore()
    private let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
    private let service: ContactService = ContactServiceImpl()
    
    func viewDidLoad() {
        view?.configureLogoImageView()
        checkAuthStatus()
    }
    
    
    private func checkAuthStatus () {
        switch authorizationStatus {
        case .authorized:
            switchToContactView()
        case .denied:
            switchToGetAccessView()
        case .notDetermined:
            ContactServiceImpl().requestAccess { [weak self] isGrained in
                guard let self = self else { return }
                if isGrained {
                    self.switchToContactView()
                } else {
                    self.switchToGetAccessView()
                }
            }
        case .restricted:
            switchToGetAccessView()
        @unknown default:
            switchToGetAccessView()
        }
    }
    
    private func switchToContactView() {
        guard let window = UIApplication.shared.windows.first else {fatalError("Invalid Configuration")}
        let contactsView = ContactViewController()
        let contactPresenter = ContactViewPresenter()
        contactsView.presenter = contactPresenter
        window.rootViewController = contactsView
    }
    
    private func switchToGetAccessView() {
        DispatchQueue.main.async {
        guard let window = UIApplication.shared.windows.first else {fatalError("Invalid Configuration")}
            let getAccessView = GetAccessViewConrtoller()
            window.rootViewController = getAccessView
        }
    }
}
