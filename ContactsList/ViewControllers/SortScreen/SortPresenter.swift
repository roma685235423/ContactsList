import UIKit
// MARK: - Protocol
protocol SortPresenterProtocol {
    var view: SortViewControllerProtocol? { get set }
    func checkConfirmButtonAccessability()
    func changeButtonsPointIsHidden(sortOption: Int)
    func viewWillAppear()
    func didTapConfirmButton()
    func didTapResetButton()
}


final class SortPresenter: SortPresenterProtocol {
    // MARK: - Properties
    var view: SortViewControllerProtocol?
    private var currentSortOption: Int = 1
    private var previosSortOptions: Int = 1
    var delegate: SortViewDelegate?
    
    // MARK: - Methods
    func viewWillAppear() {
        changeButtonsPointIsHidden(sortOption: currentSortOption)
        checkConfirmButtonAccessability()
    }
    
    func checkConfirmButtonAccessability() {
        currentSortOption != previosSortOptions ? view?.makeConfirmButtonEnabled() : view?.makeConfirmButtonUnEnabled()
    }
    
    func changeButtonsPointIsHidden(sortOption: Int) {
        switch sortOption {
        case 1:
            // Обработка нажатия на кнопку "По имени (А-Я / A-Z)"
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: false)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: true)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            currentSortOption = 1
        case 2:
            // Обработка нажатия на кнопку "По имени (Я-А / Z-A)"
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: false)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            currentSortOption = 2
        case 3:
            // Обработка нажатия на кнопку "По фамилии (А-Я / A-Z)"
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: true)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: false)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            currentSortOption = 3
        case 4:
            // Обработка нажатия на кнопку "По фамилии (Я-А / Z-A)"
            view?.fromAtoZNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoANameSortRadioButtonBluePoint(isHidden: true)
            view?.fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden: true)
            view?.fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden: false)
            currentSortOption = 4
        default:
            currentSortOption = 0
        }
    }
    
    func didTapConfirmButton() {
        previosSortOptions = currentSortOption
        checkConfirmButtonAccessability()
        delegate?.sortIndicator(isHidden: false)
    }
    
    func didTapResetButton() {
        currentSortOption = previosSortOptions
        changeButtonsPointIsHidden(sortOption: currentSortOption)
        checkConfirmButtonAccessability()
        delegate?.sortIndicator(isHidden: true)
    }
}
