import Foundation

protocol ContactViewPresenterProtocol {
    var view: ContactViewControllerProtocol? {get set}
    func loadData()
    var contactCellModels: [Contact] { get }
}

protocol ContactPresenterDelegate: AnyObject  {
    func changeSortOption(option: sortOption)
}

final class ContactPresenter: ContactViewPresenterProtocol {
    var view: ContactViewControllerProtocol?
    var contactCellModels: [Contact] = []
    var contactStoreModelsUnsorted: [ContactFromStore] = []
    var contactStoreModelsSorted: [ContactFromStore] = []
    
    private var service: ContactService = ContactServiceImpl()
    
    func loadData() {
        service.getContacts{ [ weak self ] contacts in
            guard let self = self else { return }
            self.contactCellModels = self.changeContactArrayWith(option: .cancel, storeContacts: contacts)
            self.view?.reloadTableData()
        }
    }
    private func sortContactsBy(option: sortOption, contacts: [ContactFromStore]) -> [ContactFromStore] {
        switch option {
        case .byNameAToZ:
            return contacts.sorted { $0.faimilyName < $1.faimilyName }.sorted { $0.name < $1.name }
        case .byNameZToA:
            return contacts.sorted { $0.faimilyName > $1.faimilyName }.sorted { $0.name > $1.name }
        case .byFaimilyNameAToZ:
            return contacts.sorted { $0.name < $1.name }.sorted { $0.faimilyName < $1.faimilyName }
        case .byFaimilyNameZToA:
            return contacts.sorted { $0.name > $1.name }.sorted { $0.faimilyName > $1.faimilyName }
        default:
            return contacts
        }
    }
    
    private func convertToContacts(from contacts: [ContactFromStore]) -> [Contact] {
        return contacts.map { Contact(
            name: "\($0.name) \($0.faimilyName)",
            phone: $0.phone,
            photoData: $0.photoData,
            messengers: $0.messengers
        ) }
    }
    
    private func changeContactArrayWith(option: sortOption, storeContacts: [ContactFromStore]) -> [Contact] {
        let sortedContacts = sortContactsBy(option: option, contacts: storeContacts)
        let convertedContacts = convertToContacts(from: sortedContacts)
        return convertedContacts
    }
}


extension ContactPresenter: ContactPresenterDelegate {
    func changeSortOption(option: sortOption){
        service.getContacts{ [ weak self ] contacts in
            guard let self = self else { return }
            self.contactCellModels = self.changeContactArrayWith(option: option, storeContacts: contacts)
            self.view?.reloadTableData()
        }
    }
}
