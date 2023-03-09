import UIKit

protocol BlueRadioButtonDelegate: AnyObject {
    func radioButtonAction(sender: BlueRadioButton)
}


final class SortViewController: UIViewController {
    // MARK: - Properties
    private let fromAtoZNameSortUIView = UIView()
    private let fromAtoZNameSortUILabel = UILabel()
    private let fromAtoZNameSortRadioButton = BlueRadioButton()
    
    private let fromZtoANameSortUIView = UIView()
    private let fromZtoANameSortUILabel = UILabel()
    private let fromZtoANameSortRadioButton = BlueRadioButton()
    
    private let fromAtoZFaimilyNameSortUIView = UIView()
    private let fromAtoZFaimilyNameSortUILabel = UILabel()
    private let fromAtoZFaimilyNameSortRadioButton = BlueRadioButton()
    
    private let fromZtoAFaimilyNameSortUIView = UIView()
    private let fromZtoAFaimilyNameSortUILabel = UILabel()
    private let fromZtoAFaimilyNameSortRadioButton = BlueRadioButton()
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyColors.fullBlack
        configureSortUIView(
            name: fromAtoZNameSortUIView,
            prevLabel: nil,
            button: fromAtoZNameSortRadioButton,
            sortOption: 1
        )
        configureSortUIView(
            name: fromZtoANameSortUIView,
            prevLabel: fromAtoZNameSortUIView,
            button: fromZtoANameSortRadioButton,
            sortOption: 2
        )
        configureSortUIView(
            name: fromAtoZFaimilyNameSortUIView,
            prevLabel: fromZtoANameSortUIView,
            button: fromAtoZFaimilyNameSortRadioButton,
            sortOption: 3
        )
        configureSortUIView(
            name: fromZtoAFaimilyNameSortUIView,
            prevLabel: fromAtoZFaimilyNameSortUIView,
            button: fromZtoAFaimilyNameSortRadioButton,
            sortOption: 4
        )
        
        configureSortUILabel(text: "По имени (А-Я / A-Z)", on: fromAtoZNameSortUILabel, inView: fromAtoZNameSortUIView)
        configureSortUILabel(text: "По имени (Я-А / Z-A)", on: fromZtoANameSortUILabel, inView: fromZtoANameSortUIView)
        configureSortUILabel(text: "По фамилии (А-Я / A-Z)", on: fromAtoZFaimilyNameSortUILabel, inView: fromAtoZFaimilyNameSortUIView)
        configureSortUILabel(text: "По фамилии (Я-А / Z-A)", on: fromZtoAFaimilyNameSortUILabel, inView: fromZtoAFaimilyNameSortUIView)
    }
    
    // MARK: - Methods
    private func configureSortUIView(name label: UIView, prevLabel: UIView?, button: BlueRadioButton, sortOption: Int) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = MyColors.black
        label.layer.cornerRadius = 24
        view?.addSubview(label)
        switch prevLabel {
        case .none:
            NSLayoutConstraint.activate([
                label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
                label.heightAnchor.constraint(equalToConstant: 64),
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 46)
            ])
        case .some:
            NSLayoutConstraint.activate([
                label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
                label.heightAnchor.constraint(equalToConstant: 64),
                label.topAnchor.constraint(equalTo: prevLabel!.bottomAnchor, constant: 4)
            ])
        }
        button.configureRadioButton(onView: label, sortOption: sortOption, delegate: self)
    }
    
    
    private func configureSortUILabel(text: String, on label: UILabel, inView: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MyColors.white
        label.font = UIFont(name: "SFProText-Medium", size: 16)
        label.text = text
        inView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: inView.centerYAnchor),
            label.leftAnchor.constraint(equalTo: inView.leftAnchor, constant: 16)
        ])
    }
}

// MARK: - BlueRadioButtonDelegate
extension SortViewController: BlueRadioButtonDelegate {
    func radioButtonAction(sender: BlueRadioButton) {
        if sender == fromAtoZNameSortRadioButton {
            changeButtonsPointIsHidden(sortOption: sender.button.tag)
        } else if sender == fromZtoANameSortRadioButton {
            changeButtonsPointIsHidden(sortOption: sender.button.tag)
        } else if sender == fromAtoZFaimilyNameSortRadioButton {
            changeButtonsPointIsHidden(sortOption: sender.button.tag)
        } else if sender == fromZtoAFaimilyNameSortRadioButton {
            changeButtonsPointIsHidden(sortOption: sender.button.tag)
        }
    }
}

// MARK: - Extension
extension SortViewController {
    private func changeButtonsPointIsHidden(sortOption: Int) {
        switch sortOption {
        case 1:
            // Обработка нажатия на кнопку "По имени (А-Я / A-Z)"
            fromAtoZNameSortRadioButton.bluePoint.isHidden = false
            fromZtoANameSortRadioButton.bluePoint.isHidden = true
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = true
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = true
        case 2:
            // Обработка нажатия на кнопку "По имени (Я-А / Z-A)"
            fromAtoZNameSortRadioButton.bluePoint.isHidden = true
            fromZtoANameSortRadioButton.bluePoint.isHidden = false
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = true
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = true
        case 3:
            // Обработка нажатия на кнопку "По фамилии (А-Я / A-Z)"
            fromAtoZNameSortRadioButton.bluePoint.isHidden = true
            fromZtoANameSortRadioButton.bluePoint.isHidden = true
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = false
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = true
        case 4:
            // Обработка нажатия на кнопку "По фамилии (Я-А / Z-A)"
            fromAtoZNameSortRadioButton.bluePoint.isHidden = true
            fromZtoANameSortRadioButton.bluePoint.isHidden = true
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = true
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = false
        default:
            fromAtoZNameSortRadioButton.bluePoint.isHidden = true
            fromZtoANameSortRadioButton.bluePoint.isHidden = true
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = true
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = true
        }
    }
}
