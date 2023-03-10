import UIKit
// MARK: - Protocol
protocol SortPresenterProtocol {
    var view: SortViewControllerProtocol? { get set }
    func checkConfirmButtonAccessability()
    func changeButtonsPointIsHidden(sortOption: sortOption)
    func viewWillAppear()
    func didTapConfirmButton()
    func didTapResetButton()
}


final class SortPresenter: SortPresenterProtocol {
    // MARK: - Properties
    var view: SortViewControllerProtocol?
    var delegate: SortViewDelegate?
    var contactPresenterDelegate: ContactPresenterDelegate?
    
    private var currentSortOption = sortOption.cancel
    private var previosSortOptions = sortOption.cancel
    
    // MARK: - Methods
    func viewWillAppear() {
        changeButtonsPointIsHidden(sortOption: previosSortOptions)
        checkConfirmButtonAccessability()
    }
    
    func checkConfirmButtonAccessability() {
        currentSortOption != previosSortOptions ? view?.makeConfirmButtonEnabled() : view?.makeConfirmButtonUnEnabled()
    }
    
    func changeButtonsPointIsHidden(sortOption: sortOption) {
        switch sortOption {
        case .byNameAToZ:
            // Обработка нажатия на кнопку "По имени (А-Я / A-Z)"
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: false)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: true)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            currentSortOption = .byNameAToZ
        case .byNameZToA:
            // Обработка нажатия на кнопку "По имени (Я-А / Z-A)"
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: false)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            currentSortOption = .byNameZToA
        case .byFaimilyNameAToZ:
            // Обработка нажатия на кнопку "По фамилии (А-Я / A-Z)"
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: true)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: false)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            currentSortOption = .byFaimilyNameAToZ
        case .byFaimilyNameZToA:
            // Обработка нажатия на кнопку "По фамилии (Я-А / Z-A)"
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: true)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: false)
            currentSortOption = .byFaimilyNameZToA
            // Обработка нажатия на кнопку "Сброс"
        case .cancel:
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: true)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            currentSortOption = .cancel
        }
    }
    
    func didTapConfirmButton() {
        previosSortOptions = currentSortOption
        checkConfirmButtonAccessability()
        delegate?.sortIndicator(isHidden: false)
        contactPresenterDelegate?.changeSortOption(option: currentSortOption)
    }
    
    func didTapResetButton() {
        previosSortOptions = sortOption.cancel
        currentSortOption = previosSortOptions
        changeButtonsPointIsHidden(sortOption: currentSortOption)
        checkConfirmButtonAccessability()
        delegate?.sortIndicator(isHidden: true)
        contactPresenterDelegate?.changeSortOption(option: currentSortOption)
    }
}
