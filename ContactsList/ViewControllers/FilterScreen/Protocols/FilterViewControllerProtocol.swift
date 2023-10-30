
import Foundation

// MARK: - FilterViewControllerProtocol

protocol FilterViewControllerProtocol: AnyObject {
    var presenter: FilterPresenterProtocol? { get set }
    func makeConfirmButtonEnabled()
    func makeConfirmButtonUnEnabled()
    func updateButtonsImage()
}
