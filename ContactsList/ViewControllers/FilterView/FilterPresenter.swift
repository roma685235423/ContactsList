import UIKit

protocol FilterPresenterProtocol {
    var view: FilterViewControllerProtocol? { get set }
    var messengerData: [ContactCellContent] { get set }
}

final class FilterPresenter: FilterPresenterProtocol {
    var view: FilterViewControllerProtocol?
    
    var messengerData: [ContactCellContent] = [
        ContactCellContent(name: "Выбрать все", iconName: nil),
        ContactCellContent(name: "Telegram", iconName: "telegramSqr"),
        ContactCellContent(name: "WhatsApp", iconName: "whatsappSqr"),
        ContactCellContent(name: "Viber", iconName: "viberSqr"),
        ContactCellContent(name: "Signal", iconName: "signalSqr"),
        ContactCellContent(name: "Threema", iconName: "threemaSqr"),
        ContactCellContent(name: "Номер телефона", iconName: "phoneSqr"),
        ContactCellContent(name: "E-mail", iconName: "emailSqr")
        ]
}
