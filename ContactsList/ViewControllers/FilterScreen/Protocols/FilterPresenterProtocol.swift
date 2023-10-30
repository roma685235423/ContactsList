import Foundation

// MARK: - FilterPresenterProtocol

protocol FilterPresenterProtocol: AnyObject {
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
