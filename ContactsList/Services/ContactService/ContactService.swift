import MessageUI
import Contacts

protocol ContactService {
    func getContacts(completion: @escaping ([ContactFromStore]) -> Void)
}

final class ContactServiceImpl: ContactService {
    // MARK: - Properties
    private let contactStore = CNContactStore()
    private var contactsFromStore: [ContactFromStore] = []
    
    // MARK: - Methods
    func getContacts(completion: @escaping (([ContactFromStore]) -> Void)) {
        let request = CNContactFetchRequest(keysToFetch: [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataKey
        ] as [CNKeyDescriptor])
        DispatchQueue.global().async {
            do{
                var cnContacts = [CNContact]()
                try self.contactStore.enumerateContacts(with: request) { contact, _ in
                    cnContacts.append(contact)
                }
                
                let contacts = cnContacts.map { cnContact in
                    let phoneLabeledValue = cnContact.phoneNumbers.first {
                        $0.label == CNLabelPhoneNumberMobile
                    }
                    let photoData = cnContact.imageData
                    
                    let phone = phoneLabeledValue?.value.stringValue ?? "No mobile phone number"
                    let contact = ContactFromStore(
                        name: cnContact.givenName,
                        faimilyName: cnContact.familyName,
                        phone: phone,
                        photoData: photoData
                    )
                    return contact
                }
                completion(contacts)
            } catch {
                completion([])
            }
        }
    }
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        contactStore.requestAccess(for: .contacts) { isGrant, error in
            completion(isGrant)
        }
    }
}
