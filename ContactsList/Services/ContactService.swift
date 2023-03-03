import Foundation
import Contacts

protocol ContactService {
    func loadContacts(completion: @escaping ([Contact]) -> Void)
}

final class ContactServiceImpl: ContactService {
    // MARK: - Properties
    private let contactStore = CNContactStore()
    
    // MARK: - Methods
    func loadContacts(completion: @escaping (([Contact]) -> Void)) {
        let request = CNContactFetchRequest(keysToFetch: [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey
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
                    let phone = phoneLabeledValue?.value.stringValue ?? "No mobile phone number"
                    return Contact(
                        name: "\(cnContact.givenName) \(cnContact.familyName)",
                        phone: phone
                    )
                }
                completion(contacts)
            } catch {
                completion([])
            }
        }
    }
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        contactStore.requestAccess(for: .contacts) { isGrant, error in
            print(error?.localizedDescription as Any)
            completion(isGrant)
        }
    }
}
