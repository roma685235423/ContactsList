import Foundation

protocol ContactViewPresenterProtocol {
    var view: ContactViewControllerProtocol? {get set}
    func viewDidLoad()
    func loadData()
    var contactCellModels: [Contact] { get }
}

final class ContactViewPresenter: ContactViewPresenterProtocol {
    var view: ContactViewControllerProtocol?
    var contactCellModels: [Contact] = []
    private var service: ContactService = ContactServiceImpl()
    
    
    func viewDidLoad() {
        
    }
    
    func loadData() {
        service.loadContacts{ [ weak self ] contacts in
            guard let self = self else { return }
            self.contactCellModels = contacts
            DispatchQueue.main.async {
                self.view?.tableView.reloadData()
            }
        }
    }
}
