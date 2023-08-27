import Foundation

// MARK: - ContactFilterDelegate

protocol ContactFilterDelegate: AnyObject  {
    func changeFilterOption(filters: [ContactCellContent])
}
