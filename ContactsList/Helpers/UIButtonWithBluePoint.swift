import UIKit

class BlueRadioButton: UIButton {
    var bluePoint = UIView()
    var button = UIButton()
    
    func configureRadioButton(onView: UIView, sortOption: Int) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.layer.borderWidth = 2
        button.layer.borderColor = MyColors.blue.cgColor
        button.backgroundColor = UIColor.clear
        button.tag = sortOption
        button.addTarget(self.button, action: #selector(Self.radioButtonAction), for: .touchUpInside)
        onView.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: onView.centerYAnchor),
            button.rightAnchor.constraint(equalTo: onView.rightAnchor, constant: -21),
            button.heightAnchor.constraint(equalToConstant: 22),
            button.widthAnchor.constraint(equalToConstant: 22)
        ])
        configureRadioButtonPoint(name: button)
    }
    
    
    func configureRadioButtonPoint(name button: UIButton) {
        bluePoint.translatesAutoresizingMaskIntoConstraints = false
        bluePoint.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        bluePoint.layer.cornerRadius = bluePoint.bounds.size.width / 2
        bluePoint.clipsToBounds = true
        bluePoint.backgroundColor = MyColors.blue
        bluePoint.isHidden = true
        button.addSubview(bluePoint)
        
        NSLayoutConstraint.activate([
            bluePoint.heightAnchor.constraint(equalToConstant: 14),
            bluePoint.widthAnchor.constraint(equalToConstant: 14),
            bluePoint.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            bluePoint.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
    
    
    func showBluePoint() {
        bluePoint.isHidden = false
    }
    
    func hideBluePoint() {
        bluePoint.isHidden = true
    }
    
    @objc func radioButtonAction() {
        bluePoint.isHidden.toggle()
    }
}
