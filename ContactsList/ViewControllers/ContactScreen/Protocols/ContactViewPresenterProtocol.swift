import Foundation

// MARK: - ContactViewPresenterProtocol

protocol ContactViewPresenterProtocol {
    var view: ContactViewControllerProtocol? {get set}
    var contactCellModels: [Contact] { get }
    func loadData()
    func removeCellModel(index: Int)
}
