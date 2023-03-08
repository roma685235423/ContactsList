import UIKit

final class SortViewController: UIViewController {
    
    private let fromAtoZNameSortUIView = UIView()
    private let fromAtoZNameSortUILabel = UILabel()
    private let fromAtoZNameSortRadioButton = UIButtonWithBluePoint()
    
    private let fromZtoANameSortUIView = UIView()
    private let fromZtoANameSortUILabel = UILabel()
    private let fromZtoANameSortRadioButton = UIButtonWithBluePoint()
    
    private let fromAtoZFaimilyNameSortUIView = UIView()
    private let fromAtoZFaimilyNameSortUILabel = UILabel()
    private let fromAtoZFaimilyNameSortRadioButton = UIButtonWithBluePoint()
    
    private let fromZtoAFaimilyNameSortUIView = UIView()
    private let fromZtoAFaimilyNameSortUILabel = UILabel()
    private let fromZtoAFaimilyNameSortRadioButton = UIButtonWithBluePoint()
    
    private var currentSortOption: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyColors.white
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
    
    private func configureSortUIView(name label: UIView, prevLabel: UIView?, button: UIButtonWithBluePoint, sortOption: Int) {
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
        button.configureRadioButton(onView: label, sortOption: sortOption)
        button.addTarget(self, action: #selector(Self.radioButtonAction), for: .touchUpInside)
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
    
    @objc private func radioButtonAction(_ sender: UIButton) {
        guard let button = sender as? UIButtonWithBluePoint else {
            return
        }
        
        switch button.tag {
        case 1:
            // Обработка нажатия на кнопку "По имени (А-Я / A-Z)"
            fromAtoZNameSortRadioButton.bluePoint.isHidden = false
            fromZtoANameSortRadioButton.bluePoint.isHidden = true
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = true
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = true
            currentSortOption = 1
        case 2:
            // Обработка нажатия на кнопку "По имени (Я-А / Z-A)"
            fromAtoZNameSortRadioButton.bluePoint.isHidden = true
            fromZtoANameSortRadioButton.bluePoint.isHidden = false
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = true
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = true
            currentSortOption = 2
        case 3:
            // Обработка нажатия на кнопку "По фамилии (А-Я / A-Z)"
            fromAtoZNameSortRadioButton.bluePoint.isHidden = true
            fromZtoANameSortRadioButton.bluePoint.isHidden = true
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = false
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = true
            currentSortOption = 3
        case 4:
            // Обработка нажатия на кнопку "По фамилии (Я-А / Z-A)"
            fromAtoZNameSortRadioButton.bluePoint.isHidden = true
            fromZtoANameSortRadioButton.bluePoint.isHidden = true
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = true
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = false
            currentSortOption = 4
        default:
            fromAtoZNameSortRadioButton.bluePoint.isHidden = true
            fromZtoANameSortRadioButton.bluePoint.isHidden = true
            fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = true
            fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = true
            currentSortOption = 0
        }
    }
}
