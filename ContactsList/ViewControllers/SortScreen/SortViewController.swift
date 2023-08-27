import UIKit

final class SortViewController: UIViewController {
    // MARK: - Private properties
    
    private let fromAtoZNameSortView = UIView()
    private let fromAtoZNameSortLabel = UILabel()
    private let fromAtoZNameSortRadioButton = BlueRadioButton()
    private let fromZtoANameSortView = UIView()
    private let fromZtoANameSortLabel = UILabel()
    private let fromZtoANameSortRadioButton = BlueRadioButton()
    private let fromAtoZFaimilyNameSortView = UIView()
    private let fromAtoZFaimilyNameSortLabel = UILabel()
    private let fromAtoZFaimilyNameSortRadioButton = BlueRadioButton()
    private let fromZtoAFaimilyNameSortView = UIView()
    private let fromZtoAFaimilyNameSortLabel = UILabel()
    private let fromZtoAFaimilyNameSortRadioButton = BlueRadioButton()
    private let resetButton = UIButton()
    private let conformButton = UIButton()
    private var currentSortOption: Int = 1
    private var previosSortOptions: Int = 1
    
    // MARK: - Public properties
    
    var presenter: SortPresenterProtocol?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyColors.fullBlack
        presenter?.view = self
        configureSortView(
            name: fromAtoZNameSortView,
            prevLabel: nil,
            button: fromAtoZNameSortRadioButton,
            option: sortOption.byNameAToZ
        )
        configureSortView(
            name: fromZtoANameSortView,
            prevLabel: fromAtoZNameSortView,
            button: fromZtoANameSortRadioButton,
            option: sortOption.byNameZToA
        )
        configureSortView(
            name: fromAtoZFaimilyNameSortView,
            prevLabel: fromZtoANameSortView,
            button: fromAtoZFaimilyNameSortRadioButton,
            option: sortOption.byFaimilyNameAToZ
        )
        configureSortView(
            name: fromZtoAFaimilyNameSortView,
            prevLabel: fromAtoZFaimilyNameSortView,
            button: fromZtoAFaimilyNameSortRadioButton,
            option: sortOption.byFaimilyNameZToA
        )
        
        configureSortLabel(text: "По имени (А-Я / A-Z)", on: fromAtoZNameSortLabel, inView: fromAtoZNameSortView)
        configureSortLabel(text: "По имени (Я-А / Z-A)", on: fromZtoANameSortLabel, inView: fromZtoANameSortView)
        configureSortLabel(text: "По фамилии (А-Я / A-Z)", on: fromAtoZFaimilyNameSortLabel, inView: fromAtoZFaimilyNameSortView)
        configureSortLabel(text: "По фамилии (Я-А / Z-A)", on: fromZtoAFaimilyNameSortLabel, inView: fromZtoAFaimilyNameSortView)
        confugureResetButton()
        confugureConformButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
}


private extension SortViewController {
    func configureSortView(name label: UIView, prevLabel: UIView?, button: BlueRadioButton, option: sortOption) {
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
        button.configureRadioButton(onView: label, sortOption: option, delegate: self)
    }
    
    func configureSortLabel(text: String, on label: UILabel, inView: UIView) {
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
    
    func confugureResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.layer.masksToBounds = true
        view.addSubview(resetButton)
        resetButton.setTitle("Cбросить", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        resetButton.titleLabel?.textColor = MyColors.white
        resetButton.backgroundColor = MyColors.fullBlack
        resetButton.layer.cornerRadius = 24
        resetButton.addTarget(self, action: #selector(Self.didTapResetButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resetButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            resetButton.heightAnchor.constraint(equalToConstant: 64),
            resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            resetButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 51) / 2)
        ])
    }
    
    func confugureConformButton() {
        conformButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conformButton)
        conformButton.setTitle("Применить", for: .normal)
        conformButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        conformButton.titleLabel?.textColor = MyColors.white
        conformButton.backgroundColor = MyColors.blue
        conformButton.layer.cornerRadius = 24
        conformButton.layer.masksToBounds = true
        conformButton.addTarget(self, action: #selector(Self.didTapConfirmButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            conformButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            conformButton.heightAnchor.constraint(equalTo: resetButton.heightAnchor),
            conformButton.centerYAnchor.constraint(equalTo: resetButton.centerYAnchor),
            conformButton.widthAnchor.constraint(equalTo: resetButton.widthAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    func didTapConfirmButton() {
        presenter?.didTapConfirmButton()
        self.dismiss(animated: true)
    }
    
    
    @objc
    func didTapResetButton() {
        presenter?.didTapResetButton()
    }
}


// MARK: - BlueRadioButtonDelegate

extension SortViewController: BlueRadioButtonDelegate {
    func radioButtonAction(sortOption: sortOption) {
        presenter?.changeButtonsPointIsHidden(sortOption: sortOption)
        presenter?.checkConfirmButtonAccessability()
    }
}


// MARK: - Extension SortViewControllerProtocol

extension SortViewController: SortViewControllerProtocol {
    func makeConfirmButtonEnabled() {
        conformButton.isEnabled = true
        conformButton.backgroundColor = MyColors.blue
    }
    
    func makeConfirmButtonUnEnabled() {
        conformButton.isEnabled = false
        conformButton.backgroundColor = MyColors.gray
    }
    
    func fromAtoZNameSortRadioButtonBluePoint(isHidden : Bool) {
        fromAtoZNameSortRadioButton.bluePointView.isHidden = isHidden
    }
    
    func fromZtoANameSortRadioButtonBluePoint(isHidden : Bool) {
        fromZtoANameSortRadioButton.bluePointView.isHidden = isHidden
    }
    
    func fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden : Bool) {
        fromAtoZFaimilyNameSortRadioButton.bluePointView.isHidden = isHidden
    }
    
    func fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden : Bool) {
        fromZtoAFaimilyNameSortRadioButton.bluePointView.isHidden = isHidden
    }
}
