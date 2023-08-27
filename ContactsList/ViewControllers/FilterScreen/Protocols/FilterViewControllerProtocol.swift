
import Foundation

// MARK: - FilterViewControllerProtocol

protocol FilterViewControllerProtocol {
    var presenter: FilterPresenterProtocol? { get set }
    func makeConfirmButtonEnabled()
    func makeConfirmButtonUnEnabled()
    func updateButtonsImage()
}
