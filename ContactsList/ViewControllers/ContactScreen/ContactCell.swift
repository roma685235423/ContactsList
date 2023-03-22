import UIKit


final class ContactCell: UITableViewCell {
    // MARK: - Properties
    private var contactImageView = UIImageView()
    private var contactNameLabel = UILabel()
    private var contactPhoneLabel = UILabel()
    private let contactCellView = UIView()
    private var icons: [UIImageView] = []
    // MARK: - Methods
    func configureCell(contact: Contact) {
        selectionStyle = .none
        contentView.backgroundColor = MyColors.fullBlack
        let photoData = contact.photoData
        let image = self.configureImage(imageData: photoData)
        configureContactCellView()
        configureContactImageView(image: image)
        configureContactNameLabel(name: contact.name)
        configureContactPhoneLabel(phone: contact.phone)
        configureIconLabeles(messengers: contact.messengers)
    }
    
    private func configureContactCellView() {
        contactCellView.translatesAutoresizingMaskIntoConstraints = false
        contactCellView.backgroundColor = MyColors.black
        contactCellView.layer.cornerRadius = 24
        contactCellView.clipsToBounds = true
        self.addSubview(contactCellView)
        NSLayoutConstraint.activate([
            contactCellView.heightAnchor.constraint(equalToConstant: 120),
            contactCellView.widthAnchor.constraint(equalToConstant: self.frame.width)
        ])
    }
    
    private func configureContactImageView(image: UIImage) {
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactImageView.backgroundColor = MyColors.gray
        contactImageView.layer.cornerRadius = 24
        contactImageView.clipsToBounds = true
        contactImageView.image = image
        contactCellView.addSubview(contactImageView)
        contactImageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            contactImageView.leftAnchor.constraint(equalTo: contactCellView.leftAnchor , constant: 12),
            contactImageView.centerYAnchor.constraint(equalTo: contactCellView.centerYAnchor),
            contactImageView.heightAnchor.constraint(equalToConstant: 96),
            contactImageView.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    private func configureContactNameLabel(name: String) {
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactNameLabel.font = UIFont(name: "SFProText-Medium", size: 32)
        contactNameLabel.text = name
        contactNameLabel.textColor = MyColors.white
        contactCellView.addSubview(contactNameLabel)
        NSLayoutConstraint.activate([
            contactNameLabel.leftAnchor.constraint(equalTo: contactImageView.rightAnchor, constant: 12),
            contactNameLabel.rightAnchor.constraint(equalTo: contactCellView.rightAnchor, constant: -5),
            contactNameLabel.topAnchor.constraint(equalTo: contactCellView.topAnchor, constant: 14),
            contactNameLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func configureContactPhoneLabel(phone: String) {
        contactPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        contactPhoneLabel.font = UIFont(name: "SFProText-Regular", size: 12)
        contactPhoneLabel.textColor = MyColors.gray
        contactPhoneLabel.text = phone
        contactCellView.addSubview(contactPhoneLabel)
        NSLayoutConstraint.activate([
            contactPhoneLabel.leftAnchor.constraint(equalTo: contactNameLabel.leftAnchor),
            contactPhoneLabel.topAnchor.constraint(equalTo: contactNameLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func configureIconImageView(iconName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 24, height: 24)
        imageView.image = UIImage(named: iconName)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = MyColors.black.cgColor
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func configureImage(imageData: Data?) -> UIImage {
        guard let data = imageData else {
            return UIImage(named: "avatar") ?? UIImage()
        }
        return UIImage(data: data)!
    }
    
    private func configureIconLabeles(messengers: MessengersIconNames){
        var iconConstraints = [NSLayoutConstraint]()
        var icons = [UIImageView]()
        let messengerStrings = [
            messengers.telegram,
            messengers.whatsApp,
            messengers.viber,
            messengers.signal,
            messengers.threema,
            messengers.phone,
            messengers.email
        ].compactMap { $0 }
        for messenger in messengerStrings {
            let icon = messenger
            let imageView = self.configureIconImageView(iconName: icon)
            icons.append(imageView)
        }
        for (index, iconView) in icons.enumerated() {
            if index == 0 {
                contactCellView.addSubview(iconView)
                iconConstraints.append(iconView.leftAnchor.constraint(equalTo: contactImageView.rightAnchor, constant: 12))
            } else {
                let previousIcon = icons[index-1]
                contactCellView.insertSubview(iconView, belowSubview: previousIcon)
                iconConstraints.append(iconView.leftAnchor.constraint(equalTo: previousIcon.rightAnchor, constant: -4))
            }
            iconConstraints.append(iconView.bottomAnchor.constraint(equalTo: contactImageView.bottomAnchor))
            iconConstraints.append(iconView.heightAnchor.constraint(equalToConstant: 24))
            iconConstraints.append(iconView.widthAnchor.constraint(equalToConstant: 24))
        }
        NSLayoutConstraint.activate(iconConstraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for views in contactCellView.subviews {
            views.removeFromSuperview()
        }
    }
}
