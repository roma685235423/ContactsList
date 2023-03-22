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
            CNContactEmailAddressesKey,
            CNContactSocialProfilesKey,
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
                    let phone = phoneLabeledValue?.value.stringValue ?? "No mobile phone number"
                    let phoneIconName = (phone == "No mobile phone number" ? nil : "Phone")
                    let photoData = cnContact.imageData
                    let emailIconName = cnContact.emailAddresses.isEmpty ? nil : "Email"
                    let messengers = MessengersIconNames(
                        telegram: cnContact.socialProfiles.first(where: { $0.value.service == "Telegram" })?.value.service,
                        whatsApp: cnContact.socialProfiles.first(where: { $0.value.service == "WhatsApp" })?.value.service,
                        viber: cnContact.socialProfiles.first(where: { $0.value.service == "Viber" })?.value.service,
                        signal: cnContact.socialProfiles.first(where: { $0.value.service == "Signal" })?.value.service,
                        threema: cnContact.socialProfiles.first(where: { $0.value.service == "Threema" })?.value.service,
                        phone: phoneIconName,
                        email: emailIconName
                    )
                    let contact = ContactFromStore(
                        name: cnContact.givenName,
                        faimilyName: cnContact.familyName,
                        phone: phone,
                        photoData: photoData,
                        messengers: messengers
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
