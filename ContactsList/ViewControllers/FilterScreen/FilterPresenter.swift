import UIKit

protocol FilterPresenterProtocol {
    var view: FilterViewControllerProtocol? { get set }
    var messengerData: [ContactCellContent] { get set }
    var tmpIsSelected: [Bool] { get }
    func copyIsSelectedToTmp()
    func selectAll()
    func changTempIsSelectedFor(row: Int)
    func checkIsAllSelectedNeedDrop() -> Bool
    func checkIsAllSelectedNeedSet() -> Bool
    func dropSelectAll()
    func setSelectAll()
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
    var tmpIsSelected: [Bool] = []
    
    
    func copyIsSelectedToTmp() {
        tmpIsSelected = messengerData.map{$0.isSelected}
    }
    
    func changTempIsSelectedFor(row: Int) {
        tmpIsSelected[row] = !tmpIsSelected[row]
    }
    
    func selectAll() {
        let allSelected = tmpIsSelected[0]
        for i in 1..<tmpIsSelected.count {
            tmpIsSelected[i] = allSelected
        }
    }
    
     func checkIsAllSelectedNeedDrop() -> Bool {
        let messengersCheckbox = tmpIsSelected.dropFirst()
        let allCheckboxTrue = messengersCheckbox.allSatisfy({$0 == true})
        if tmpIsSelected[0] == true && allCheckboxTrue == false {
            return true
        } else {
            return false
        }
    }
    
    func checkIsAllSelectedNeedSet() -> Bool {
       let messengersCheckbox = tmpIsSelected.dropFirst()
       let allCheckboxTrue = messengersCheckbox.allSatisfy({$0 == true})
       if tmpIsSelected[0] == false && allCheckboxTrue == true {
           return true
       } else {
           return false
       }
   }
    
    func dropSelectAll() {
        tmpIsSelected[0] = false
    }
    
    func setSelectAll() {
        tmpIsSelected[0] = true
    }
}
