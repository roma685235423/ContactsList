import UIKit

final class FilterViewCell: UITableViewCell {
    private var checkboxButton = UIButton()
    private let cellBackgroundView = UIView()
    
    func configureCellContent(content: ContactCellContent) {
        configureCellBackgroundView()
        configureImageView(content: content)
        configureMessengerNameLabel(content: content)
        configureFilterSwitch(isSelected: content.isSelected)
    }
    
    private func configureCellBackgroundView() {
        self.selectionStyle = .none
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        cellBackgroundView.backgroundColor = MyColors.black
        cellBackgroundView.layer.cornerRadius = 24
        cellBackgroundView.layer.masksToBounds = true
        self.addSubview(cellBackgroundView)
        
        NSLayoutConstraint.activate([
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 64),
            cellBackgroundView.leadingAnchor.constraint(equalTo: super.leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: super.trailingAnchor)
        ])
    }
    
    
    private func configureImageView(content: ContactCellContent) {
        guard let imageString = content.iconName else { return }
        let messengerImageView = UIImageView()
        messengerImageView.translatesAutoresizingMaskIntoConstraints = false
        messengerImageView.image = UIImage(named: imageString)
        messengerImageView.layer.cornerRadius = 12
        messengerImageView.layer.masksToBounds = true
        cellBackgroundView.addSubview(messengerImageView)
        
        NSLayoutConstraint.activate([
            messengerImageView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor),
            messengerImageView.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor, constant: 16),
            messengerImageView.heightAnchor.constraint(equalToConstant: 40),
            messengerImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureMessengerNameLabel(content: ContactCellContent) {
        let messengerNameLable = UILabel()
        messengerNameLable.translatesAutoresizingMaskIntoConstraints = false
        messengerNameLable.text = content.name
        messengerNameLable.font = UIFont(name: "SFProText-Regular", size: 16)
        messengerNameLable.textColor = MyColors.white
        cellBackgroundView.addSubview(messengerNameLable)
        
        let leftOffset: CGFloat
        if content.iconName != nil {
            leftOffset = 64
        } else {
            leftOffset = 16
        }
        NSLayoutConstraint.activate([
            messengerNameLable.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor, constant: leftOffset),
            messengerNameLable.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor)
        ])
    }
    
    private func configureFilterSwitch(isSelected: Bool) {
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.backgroundColor = .clear
        checkboxButton.setImage(UIImage(named: "filterOff"), for: .normal)
        checkboxButton.addTarget(self, action: #selector(Self.didTapCheckboxButton), for: .touchUpInside)
        cellBackgroundView.addSubview(checkboxButton)
        
        NSLayoutConstraint.activate([
            checkboxButton.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor),
            checkboxButton.rightAnchor.constraint(equalTo: cellBackgroundView.rightAnchor, constant: -22),
            checkboxButton.heightAnchor.constraint(equalToConstant: 20),
            checkboxButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc
    private func didTapCheckboxButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            checkboxButton.setImage(UIImage(named: "filterOn"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(named: "filterOff"), for: .normal)
        }
    }
}
