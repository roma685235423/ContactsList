import UIKit
import Contacts

final class SplashScreenPresenter: SplashScreenPresenterProtocol {
    // MARK: - Puplic properties
    
    var view: SplashScreenViewControllerProtocol?
    
    // MARK: - Private properties
    
    private let contactStore = CNContactStore()
    private let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
    private let service: ContactService = ContactServiceImpl()
    
    // MARK: - Lifecicle
    
    func viewDidLoad() {
        view?.configureLogoImageView()
        checkAuthStatus()
    }
}
// MARK: - Private methods

private extension SplashScreenPresenter {
    func checkAuthStatus () {
        switch authorizationStatus {
        case .authorized:
            switchToContactView()
        case .denied:
            switchToGetAccessView()
        case .notDetermined:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                ContactServiceImpl().requestAccess { isGrained in
                    if isGrained {
                        self.switchToContactView()
                    } else {
                        self.switchToGetAccessView()
                    }
                }
            }
        case .restricted:
            switchToGetAccessView()
        @unknown default:
            switchToGetAccessView()
        }
    }
    
    func switchToContactView() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else {fatalError("Invalid Configuration")}
            let contactsView = ContactViewController()
            let contactPresenter = ContactPresenter()
            
            let filterViewController = FilterViewController()
            let filterPresenter = FilterPresenter()
            
            let sortViewController = SortViewController()
            let sortPresenter = SortPresenter()
            
            sortViewController.presenter = sortPresenter
            sortPresenter.delegate = contactsView
            sortPresenter.contactPresenterDelegate = contactPresenter
            
            filterViewController.presenter = filterPresenter
            filterPresenter.delegate = contactsView
            filterPresenter.contactPresenterDelegate = contactPresenter
            
            contactsView.presenter = contactPresenter
            contactsView.presenter?.loadData()
            contactsView.sortViewController = sortViewController
            contactsView.filterViewController = filterViewController
            
            window.rootViewController = contactsView
        }
    }
    
    func switchToGetAccessView() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else {fatalError("Invalid Configuration")}
            let getAccessView = GetAccessViewConrtoller()
            window.rootViewController = getAccessView
        }
    }
}
