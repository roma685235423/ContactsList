import UIKit

// MARK: - FilterPresenterProtocol
protocol FilterPresenterProtocol {
    var view: FilterViewControllerProtocol? { get set }
    var messengerFiltersData: [ContactCellContent] { get set }
    var tmpIsSelected: [Bool] { get }
    func copyIsSelectedToTmp()
    func copyIsSelectedFromTmp()
    func changeTempIsSelectedFor(row: Int)
    func checkIsAllSelectedNeedDrop() -> Bool
    func checkIsAllSelectedNeedSet() -> Bool
    func dropSelectAll()
    func setSelectAll()
    func cangeSelectAll()
    func didTapConfirmButton()
    func didTapResetButton()
    func checkConfirmButtonAccessability()
}



final class FilterPresenter: FilterPresenterProtocol {
    // MARK: - Properties
    var contactPresenterDelegate: ContactFilterDelegate?
    var view: FilterViewControllerProtocol?
    var delegate: FilterViewDelegate?
    
    var messengerFiltersData: [ContactCellContent] = [
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
    
    
    // MARK: - Methods
    func copyIsSelectedToTmp() {
        tmpIsSelected = messengerFiltersData.map{$0.isSelected}
    }
    
    
    func copyIsSelectedFromTmp() {
        for i in 0..<tmpIsSelected.count {
            messengerFiltersData[i].isSelected = tmpIsSelected[i]
        }
    }
    
    
    func changeTempIsSelectedFor(row: Int) {
        tmpIsSelected[row] = !tmpIsSelected[row]
    }
    
    
    func cangeSelectAll() {
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
    
    
    func checkConfirmButtonAccessability() {
        var currentFilters: [Bool] = []
        for i in 0..<tmpIsSelected.count {
            currentFilters.append(messengerFiltersData[i].isSelected)
        }
        (tmpIsSelected != currentFilters) ? view?.makeConfirmButtonEnabled() : view?.makeConfirmButtonUnEnabled()
    }
    
    
    func dropSelectAll() {
        tmpIsSelected[0] = false
    }
    
    
    func setSelectAll() {
        tmpIsSelected[0] = true
    }
    
    
    func didTapConfirmButton() {
        copyIsSelectedFromTmp()
        checkConfirmButtonAccessability()
        contactPresenterDelegate?.changeFilterOption(filters: messengerFiltersData)
        if messengerFiltersData.allSatisfy({$0.isSelected == false }){
            delegate?.filterIndicator(isHidden: true)
        } else {
            delegate?.filterIndicator(isHidden: false)
        }
    }
    
    
    func didTapResetButton() {
        dropSelectAll()
        cangeSelectAll()
        view?.makeConfirmButtonEnabled()
        view?.updateButtonsImage()
    }
}
