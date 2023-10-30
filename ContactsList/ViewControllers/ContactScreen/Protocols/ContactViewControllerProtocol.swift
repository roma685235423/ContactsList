import Foundation

// MARK: - ContactViewControllerProtocol

protocol ContactViewControllerProtocol: AnyObject {
    var presenter: ContactViewPresenterProtocol? { get set }
    func reloadTableData()
    func isNeedToHideNoSuitableContactsLabel(isHidden: Bool)
}
