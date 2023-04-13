import UIKit

// MARK: - FilterCellDelegate
protocol FilterCellDelegate: AnyObject {
    func filterCheckboxButtonClicked(cell:FilterViewCell)
}



final class FilterViewCell: UITableViewCell {
    // MARK: - UI
    private var checkboxIndicatorView = UIImageView()
    private let cellBackgroundView = UIView()
    private var checkboxButtonIsSelected: Bool = false
    
    weak var delegate: FilterCellDelegate?
    
    
    // MARK: - UI Configuration
    func configureCellContent(content: ContactCellContent) {
        configureCellBackgroundView()
        configureImageView(content: content)
        configureMessengerNameLabel(content: content)
        configureCheckboxButton(isSelected: content.isSelected)
        checkboxButtonIsSelected = content.isSelected
    }
    
    private func configureCellBackgroundView() {
        self.selectionStyle = .none
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        cellBackgroundView.backgroundColor = MyColors.black
        cellBackgroundView.layer.cornerRadius = 24
        cellBackgroundView.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Self.cellDidTap))
        self.addGestureRecognizer(tapGesture)
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
    
    private func configureCheckboxButton(isSelected: Bool) {
        checkboxIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        checkboxIndicatorView.backgroundColor = .clear
        checkboxIndicatorView.image = UIImage(named: "filterOff")
        cellBackgroundView.addSubview(checkboxIndicatorView)
        NSLayoutConstraint.activate([
            checkboxIndicatorView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor),
            checkboxIndicatorView.rightAnchor.constraint(equalTo: cellBackgroundView.rightAnchor, constant: -22),
            checkboxIndicatorView.heightAnchor.constraint(equalToConstant: 20),
            checkboxIndicatorView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    // MARK: - Method
     func changeCheckboxButtonImage(isSelected: Bool) {
         DispatchQueue.main.async { [weak self] in
             guard let self = self else { return }
             if isSelected {
                 self.checkboxIndicatorView.image = UIImage(named: "filterOn")
             } else {
                 self.checkboxIndicatorView.image = UIImage(named: "filterOff")
             }
         }
    }
    
    
    // MARK: - Action
    @objc
    private func cellDidTap() {
        self.isSelected = !self.isSelected
        let isSelected = self.isSelected
        changeCheckboxButtonImage(isSelected: isSelected)
        delegate?.filterCheckboxButtonClicked(cell:self)
    }
}
