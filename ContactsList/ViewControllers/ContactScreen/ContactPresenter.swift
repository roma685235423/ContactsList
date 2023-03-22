import Foundation

protocol ContactViewPresenterProtocol {
    var view: ContactViewControllerProtocol? {get set}
    var contactCellModels: [Contact] { get }
    func loadData()
    func removeCellModel(index: Int)
}

protocol ContactSortDelegate: AnyObject  {
    func changeSortOption(option: sortOption)
}

protocol ContactFilterDelegate: AnyObject  {
    func changeFilterOption(filters: [ContactCellContent])
}

final class ContactPresenter: ContactViewPresenterProtocol {
    var view: ContactViewControllerProtocol?
    var contactCellModels: [Contact] = []
    private var contactCellModelsFromStore: [Contact] = []
    private var service: ContactService = ContactServiceImpl()
    private var currentSortOption: sortOption = .cancel
    private var currentFilters: [ContactCellContent] = []
    
    func loadData() {
        service.getContacts{ [ weak self ] contacts in
            guard let self = self else { return }
            self.contactCellModelsFromStore = self.convertToContacts(from: contacts)
            self.contactCellModels = self.contactCellModelsFromStore
            self.view?.reloadTableData()
        }
    }
    
    func removeCellModel(index: Int) {
        contactCellModels.remove(at: index)
        contactCellModelsFromStore.remove(at: index)
    }
    
    private func isNeedToHideNoSuitableContactsLabel() -> Bool {
        if contactCellModels.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    
    private func sortContactsBy(option: sortOption, contacts: [Contact]) -> [Contact] {
        currentSortOption = option
        switch option {
        case .byNameAToZ:
            return contacts.sorted(by: {$0.name.components(separatedBy: " ").first ?? "" < $1.name.components(separatedBy: " ").first ?? ""})
        case .byNameZToA:
            return contacts.sorted(by: {$0.name.components(separatedBy: " ").first ?? "" > $1.name.components(separatedBy: " ").first ?? ""})
        case .byFaimilyNameAToZ:
            return contacts.sorted(by: {$0.name.components(separatedBy: " ").last ?? "" < $1.name.components(separatedBy: " ").last ?? ""})
        case .byFaimilyNameZToA:
            return contacts.sorted(by: {$0.name.components(separatedBy: " ").last ?? "" > $1.name.components(separatedBy: " ").last ?? ""})
        case .cancel:
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
    
    
    private func validateContacts(contacts: [Contact], filters: [ContactCellContent]) -> [Contact] {
        var validatedContacts: [Contact] = []
        for contact in contacts {
            var isSelected: Bool = true
            for filter in filters {
                if filter.name == "Выбрать все" {
                    continue
                }
                if filter.isSelected {
                    switch filter.name {
                    case "Telegram":
                        isSelected = isSelected && (contact.messengers.telegram != nil)
                    case "WhatsApp":
                        isSelected = isSelected && (contact.messengers.whatsApp != nil)
                    case "Viber":
                        isSelected = isSelected && (contact.messengers.viber != nil)
                    case "Signal":
                        isSelected = isSelected && (contact.messengers.signal != nil)
                    case "Threema":
                        isSelected = isSelected && (contact.messengers.threema != nil)
                    case "Номер телефона":
                        isSelected = isSelected && (contact.messengers.phone != nil)
                    case "E-mail":
                        isSelected = isSelected && (contact.messengers.email != nil)
                    default:
                        break
                    }
                }
                if !isSelected {
                    break
                }
            }
            if isSelected {
                validatedContacts.append(contact)
            }
        }
        return validatedContacts
    }
}


extension ContactPresenter: ContactSortDelegate {
    func changeSortOption(option: sortOption){
        contactCellModels = validateContacts(contacts: contactCellModelsFromStore, filters: currentFilters)
        contactCellModels = sortContactsBy(option: option, contacts: contactCellModels)
        view?.reloadTableData()
    }
}


extension ContactPresenter: ContactFilterDelegate {
    func changeFilterOption(filters: [ContactCellContent]) {
        currentFilters = filters
        if currentSortOption == .cancel {
            contactCellModels = validateContacts(contacts: contactCellModelsFromStore, filters: filters)
            
        } else {
            contactCellModels = validateContacts(contacts: contactCellModelsFromStore, filters: filters)
            contactCellModels = sortContactsBy(option: currentSortOption, contacts: contactCellModels)
        }
        view?.isNeedToHideNoSuitableContactsLabel(isHidden: isNeedToHideNoSuitableContactsLabel())
        view?.reloadTableData()
    }
}
