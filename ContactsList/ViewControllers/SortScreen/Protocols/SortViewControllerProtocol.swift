import Foundation

// MARK: - SortViewControllerProtocol

protocol SortViewControllerProtocol: AnyObject {
    var presenter: SortPresenterProtocol? { get set }
    func makeConfirmButtonEnabled()
    func makeConfirmButtonUnEnabled()
    func fromAtoZNameSortRadioButtonBluePoint(isHidden : Bool)
    func fromZtoANameSortRadioButtonBluePoint(isHidden : Bool)
    func fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden : Bool)
    func fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden : Bool)
}
