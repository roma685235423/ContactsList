import UIKit

class BlueRadioButton: UIButton {
    // MARK: - Public properties
    var bluePointView = UIView()
    var radioButton = UIButton()
    weak var delegate: BlueRadioButtonDelegate?
    
    // MARK: - Public methods
    
    func configureRadioButton(onView: UIView, sortOption: sortOption, delegate: BlueRadioButtonDelegate) {
        setTagFromSortOption(option: sortOption)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        radioButton.layer.cornerRadius = radioButton.bounds.size.width / 2
        radioButton.layer.borderWidth = 2
        radioButton.layer.borderColor = MyColors.blue.cgColor
        radioButton.backgroundColor = UIColor.clear
        self.delegate = delegate
        radioButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        onView.addSubview(radioButton)
        NSLayoutConstraint.activate([
            radioButton.centerYAnchor.constraint(equalTo: onView.centerYAnchor),
            radioButton.rightAnchor.constraint(equalTo: onView.rightAnchor, constant: -21),
            radioButton.heightAnchor.constraint(equalToConstant: 22),
            radioButton.widthAnchor.constraint(equalToConstant: 22)
        ])
        configureRadioButtonPoint(onView: onView, name: radioButton)
    }
    
    func configureRadioButtonPoint(onView: UIView, name button: UIButton) {
        bluePointView.translatesAutoresizingMaskIntoConstraints = false
        bluePointView.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        bluePointView.layer.cornerRadius = bluePointView.bounds.size.width / 2
        bluePointView.clipsToBounds = true
        bluePointView.backgroundColor = MyColors.blue
        bluePointView.isHidden = true
        onView.insertSubview(bluePointView, belowSubview: button)
        
        NSLayoutConstraint.activate([
            bluePointView.heightAnchor.constraint(equalToConstant: 14),
            bluePointView.widthAnchor.constraint(equalToConstant: 14),
            bluePointView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            bluePointView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
    
    // MARK: - Private methods
    
    private func setTagFromSortOption (option: sortOption) {
        switch option {
        case .byNameAToZ:
            self.radioButton.tag = 1
        case .byNameZToA:
            self.radioButton.tag = 2
        case .byFaimilyNameAToZ:
            self.radioButton.tag = 3
        case .byFaimilyNameZToA:
            self.radioButton.tag = 4
        default:
            return
        }
    }
    
    private func returnSortOptionByTag(option: Int) -> sortOption {
        switch option {
        case 1:
            return sortOption.byNameAToZ
        case 2:
            return sortOption.byNameZToA
        case 3:
            return sortOption.byFaimilyNameAToZ
        case 4:
            return sortOption.byFaimilyNameZToA
        default:
            return sortOption.cancel
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func radioButtonTapped(_ sender: BlueRadioButton) {
        let tag = self.radioButton.tag
        let option = returnSortOptionByTag(option: tag)
        delegate?.radioButtonAction(sortOption: option)
    }
}
