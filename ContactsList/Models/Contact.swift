import Foundation

struct Contact {
    let name: String
    let phone: String
    let photoData: Data?
    let messengers: MessengersIconNames
}

struct ContactFromStore {
    let name: String
    let faimilyName: String
    let phone: String
    let photoData: Data?
    let messengers: MessengersIconNames
}

struct MessengersIconNames {
    var telegram: String?
    var whatsApp: String?
    var viber: String?
    var signal: String?
    var threema: String?
    var phone: String?
    var email: String?
}
