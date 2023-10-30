import UIKit

final class SortPresenter: SortPresenterProtocol {
    // MARK: - Public properties
    
    weak var view: SortViewControllerProtocol?
    weak var delegate: SortViewDelegate?
    weak var contactPresenterDelegate: ContactSortDelegate?
    
    // MARK: - Private properties
    
    private var currentSortOption = sortOption.cancel
    private var previosSortOptions = sortOption.cancel
    
    // MARK: - public properties
    
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
        currentSortOption != .cancel ? delegate?.sortIndicator(isHidden: false) : delegate?.sortIndicator(isHidden: true)
        contactPresenterDelegate?.changeSortOption(option: currentSortOption)
    }
    
    func didTapResetButton() {
        currentSortOption = sortOption.cancel
        changeButtonsPointIsHidden(sortOption: currentSortOption)
        view?.makeConfirmButtonEnabled()
    }
}
