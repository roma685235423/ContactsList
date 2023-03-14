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
                    let phoneIconName = (phone == "No mobile phone number" ? nil : "phone")
                    let photoData = cnContact.imageData
                    let emailIconName = !cnContact.emailAddresses.isEmpty ? nil : "email"
                    let social = MessengersIconNames(
                        phone: phoneIconName,
                        email: emailIconName,
                        telegram: cnContact.socialProfiles.first(where: { $0.value.service == "telegram" })?.value.service,
                        whatsApp: cnContact.socialProfiles.first(where: { $0.value.service == "whatsapp" })?.value.service,
                        viber: cnContact.socialProfiles.first(where: { $0.value.service == "viber" })?.value.service,
                        signal: cnContact.socialProfiles.first(where: { $0.value.service == "signal" })?.value.service,
                        threema: cnContact.socialProfiles.first(where: { $0.value.service == "threema" })?.value.service
                    )
                    let contact = ContactFromStore(
                        name: cnContact.givenName,
                        faimilyName: cnContact.familyName,
                        phone: phone,
                        photoData: photoData,
                        messengers: social
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

/*
 Для реализации функции конфигурации иконок способов связи, можно добавить новый метод configureIcons, который будет получать параметр messengers из свойства Contact. В этом методе можно проверять, какие иконки должны быть отображены и добавлять их на contactCellView. Например:

 swift
 Copy code
 private func configureIcons(messengers: messengersIconNames) {
     let iconSize: CGFloat = 30
     var iconConstraints = [NSLayoutConstraint]()
     var icons = [UIImageView]()

     if let telegramIcon = messengers.telegram {
         let imageView = createIconImageView(iconName: telegramIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let whatsAppIcon = messengers.whatsApp {
         let imageView = createIconImageView(iconName: whatsAppIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let viberIcon = messengers.viber {
         let imageView = createIconImageView(iconName: viberIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let signalIcon = messengers.signal {
         let imageView = createIconImageView(iconName: signalIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let threemaIcon = messengers.threema {
         let imageView = createIconImageView(iconName: threemaIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let phoneIcon = messengers.phone {
         let imageView = createIconImageView(iconName: phoneIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let emailIcon = messengers.email {
         let imageView = createIconImageView(iconName: emailIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     for (index, iconView) in icons.enumerated() {
         contactCellView.addSubview(iconView)

         if index == 0 {
             iconConstraints.append(iconView.leftAnchor.constraint(equalTo: contactImage.rightAnchor, constant: 12))
         } else {
             let previousIcon = icons[index-1]
             iconConstraints.append(iconView.leftAnchor.constraint(equalTo: previousIcon.rightAnchor, constant: 8))
         }

         iconConstraints.append(iconView.centerYAnchor.constraint(equalTo: contactCellView.centerYAnchor))
         iconConstraints.append(iconView.heightAnchor.constraint(equalToConstant: iconSize))
         iconConstraints.append(iconView.widthAnchor.constraint(equalToConstant: iconSize))
     }

     NSLayoutConstraint.activate(iconConstraints)
 }

 private func createIconImageView(iconName: String, iconSize: CGFloat) -> UIImageView {
     let imageView = UIImageView()
     imageView.translatesAutoresizingMaskIntoConstraints = false
     imageView.image = UIImage(named: iconName)
     imageView.contentMode = .scaleAspectFit
     imageView.layer.cornerRadius = iconSize / 2
     imageView.clipsToBounds = true
     return imageView
 }
 Вы можете вызывать этот метод внутри configureCell метода, передавая messengers из параметра Contact:

 swift
 Copy code
 func configureCell(contact: Contact) {
     //...
     configureIcons(messengers: contact.messengers)
 }




 Regenerate response
 */
