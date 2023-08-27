import Foundation

// MARK: - SortPresenterProtocol

protocol SortPresenterProtocol {
    var view: SortViewControllerProtocol? { get set }
    func checkConfirmButtonAccessability()
    func changeButtonsPointIsHidden(sortOption: sortOption)
    func viewWillAppear()
    func didTapConfirmButton()
    func didTapResetButton()
}
