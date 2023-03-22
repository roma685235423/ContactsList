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
    
    private func switchToContactView() {
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
            
            contactsView.sortViewController = sortViewController
            contactsView.filterViewController = filterViewController
            
            contactsView.presenter = contactPresenter
            contactsView.presenter?.loadData()
            window.rootViewController = contactsView
        }
    }
    
    private func switchToGetAccessView() {
        DispatchQueue.main.async {
        guard let window = UIApplication.shared.windows.first else {fatalError("Invalid Configuration")}
            let getAccessView = GetAccessViewConrtoller()
            window.rootViewController = getAccessView
        }
    }
}
