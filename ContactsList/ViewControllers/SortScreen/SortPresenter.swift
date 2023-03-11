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
    private var currentSortOption = sortOption.byNameAToZ
    private var previosSortOptions = sortOption.byNameAToZ
    var delegate: SortViewDelegate?
    
    // MARK: - Methods
    func viewWillAppear() {
        changeButtonsPointIsHidden(sortOption: currentSortOption)
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
        default:
            currentSortOption = .cancel
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
