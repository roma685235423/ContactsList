import UIKit
// MARK: - Protocols
protocol BlueRadioButtonDelegate: AnyObject {
    func radioButtonAction(sortOption: sortOption)
}

protocol SortViewControllerProtocol: AnyObject {
    var presenter: SortPresenterProtocol? { get set }
    func makeConfirmButtonEnabled()
    func makeConfirmButtonUnEnabled()
    func fromAtoZNameSortRadioButtonBluePoint(isHidden : Bool)
    func fromZtoANameSortRadioButtonBluePoint(isHidden : Bool)
    func fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden : Bool)
    func fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden : Bool)
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
    
    private let resetButton = UIButton()
    private let conformButton = UIButton()
    
    private var currentSortOption: Int = 1
    private var previosSortOptions: Int = 1
    
    var presenter: SortPresenterProtocol?
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyColors.fullBlack
        presenter?.view = self
        configureSortUIView(
            name: fromAtoZNameSortUIView,
            prevLabel: nil,
            button: fromAtoZNameSortRadioButton,
            option: sortOption.byNameAToZ
        )
        configureSortUIView(
            name: fromZtoANameSortUIView,
            prevLabel: fromAtoZNameSortUIView,
            button: fromZtoANameSortRadioButton,
            option: sortOption.byNameZToA
        )
        configureSortUIView(
            name: fromAtoZFaimilyNameSortUIView,
            prevLabel: fromZtoANameSortUIView,
            button: fromAtoZFaimilyNameSortRadioButton,
            option: sortOption.byFaimilyNameAToZ
        )
        configureSortUIView(
            name: fromZtoAFaimilyNameSortUIView,
            prevLabel: fromAtoZFaimilyNameSortUIView,
            button: fromZtoAFaimilyNameSortRadioButton,
            option: sortOption.byFaimilyNameZToA
        )
        
        configureSortUILabel(text: "???? ?????????? (??-?? / A-Z)", on: fromAtoZNameSortUILabel, inView: fromAtoZNameSortUIView)
        configureSortUILabel(text: "???? ?????????? (??-?? / Z-A)", on: fromZtoANameSortUILabel, inView: fromZtoANameSortUIView)
        configureSortUILabel(text: "???? ?????????????? (??-?? / A-Z)", on: fromAtoZFaimilyNameSortUILabel, inView: fromAtoZFaimilyNameSortUIView)
        configureSortUILabel(text: "???? ?????????????? (??-?? / Z-A)", on: fromZtoAFaimilyNameSortUILabel, inView: fromZtoAFaimilyNameSortUIView)
        
        confugureResetButton()
        confugureConformButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    // MARK: - Methods
    private func configureSortUIView(name label: UIView, prevLabel: UIView?, button: BlueRadioButton, option: sortOption) {
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
    
    private func confugureResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.layer.masksToBounds = true
        view.addSubview(resetButton)
        resetButton.setTitle("C??????????????", for: .normal)
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
    
    private func confugureConformButton() {
        conformButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conformButton)
        conformButton.setTitle("??????????????????", for: .normal)
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
    
    @objc
    private func didTapConfirmButton() {
        presenter?.didTapConfirmButton()
        self.dismiss(animated: true)
    }
    
    @objc
    private func didTapResetButton() {
        presenter?.didTapResetButton()
        self.dismiss(animated: true)
    }
}

// MARK: - BlueRadioButtonDelegate
extension SortViewController: BlueRadioButtonDelegate {
    func radioButtonAction(sortOption: sortOption) {
        presenter?.changeButtonsPointIsHidden(sortOption: sortOption)
        presenter?.checkConfirmButtonAccessability()
    }
}

// MARK: - Extension
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
        fromAtoZNameSortRadioButton.bluePoint.isHidden = isHidden
    }
    
    func fromZtoANameSortRadioButtonBluePoint(isHidden : Bool) {
        fromZtoANameSortRadioButton.bluePoint.isHidden = isHidden
    }
    
    func fromAtoZFaimilyNameSortRadioButtonBluePoint(isHidden : Bool) {
        fromAtoZFaimilyNameSortRadioButton.bluePoint.isHidden = isHidden
    }
    
    func fromZtoAFaimilyNameSortRadioButtonBluePoint(isHidden : Bool) {
        fromZtoAFaimilyNameSortRadioButton.bluePoint.isHidden = isHidden
    }
}
