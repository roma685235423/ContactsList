import UIKit

class BlueRadioButton: UIButton {
    weak var delegate: BlueRadioButtonDelegate?
    var bluePoint = UIView()
    var button = UIButton()
    
    func configureRadioButton(onView: UIView, sortOption: sortOption, delegate: BlueRadioButtonDelegate) {
        setTagFromSortOption(option: sortOption)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.layer.borderWidth = 2
        button.layer.borderColor = MyColors.blue.cgColor
        button.backgroundColor = UIColor.clear
        self.delegate = delegate
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        onView.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: onView.centerYAnchor),
            button.rightAnchor.constraint(equalTo: onView.rightAnchor, constant: -21),
            button.heightAnchor.constraint(equalToConstant: 22),
            button.widthAnchor.constraint(equalToConstant: 22)
        ])
        configureRadioButtonPoint(onView: onView, name: button)
    }
    
    
    func configureRadioButtonPoint(onView: UIView, name button: UIButton) {
        bluePoint.translatesAutoresizingMaskIntoConstraints = false
        bluePoint.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        bluePoint.layer.cornerRadius = bluePoint.bounds.size.width / 2
        bluePoint.clipsToBounds = true
        bluePoint.backgroundColor = MyColors.blue
        bluePoint.isHidden = true
        onView.insertSubview(bluePoint, belowSubview: button)
        
        NSLayoutConstraint.activate([
            bluePoint.heightAnchor.constraint(equalToConstant: 14),
            bluePoint.widthAnchor.constraint(equalToConstant: 14),
            bluePoint.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            bluePoint.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
    
    private func setTagFromSortOption (option: sortOption) {
        switch option {
        case .byNameAToZ:
            self.button.tag = 1
        case .byNameZToA:
            self.button.tag = 2
        case .byFaimilyNameAToZ:
            self.button.tag = 3
        case .byFaimilyNameZToA:
            self.button.tag = 4
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
    
    @objc
    private func radioButtonTapped(_ sender: BlueRadioButton) {
        let tag = self.button.tag
        let option = returnSortOptionByTag(option: tag)
        delegate?.radioButtonAction(sortOption: option)
    }
}
