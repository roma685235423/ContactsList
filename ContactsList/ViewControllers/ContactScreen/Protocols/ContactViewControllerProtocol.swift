import Foundation

// MARK: - ContactViewControllerProtocol

protocol ContactViewControllerProtocol {
    var presenter: ContactViewPresenterProtocol? { get set }
    func reloadTableData()
    func isNeedToHideNoSuitableContactsLabel(isHidden: Bool)
}
