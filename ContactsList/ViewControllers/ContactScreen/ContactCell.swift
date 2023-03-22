import UIKit


final class ContactCell: UITableViewCell {
    // MARK: - Properties
    private var contactImage = UIImageView()
    private var contactName = UILabel()
    private var contactPhone = UILabel()
    private let contactCellView = UIView()
    private var icons: [UIImageView] = []
    // MARK: - Methods
    func configureCell(contact: Contact) {
        selectionStyle = .none
        contentView.backgroundColor = MyColors.fullBlack
        let photoData = contact.photoData
        let image = self.configureImage(imageData: photoData)
        configureContactCellView()
        configureContactImage(image: image)
        configureContactName(name: contact.name)
        configureContactPhone(phone: contact.phone)
        configureIcons(messengers: contact.messengers)
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
    
    private func configureContactImage(image: UIImage) {
        contactImage.translatesAutoresizingMaskIntoConstraints = false
        contactImage.backgroundColor = MyColors.gray
        contactImage.layer.cornerRadius = 24
        contactImage.clipsToBounds = true
        contactImage.image = image
        contactCellView.addSubview(contactImage)
        contactImage.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            contactImage.leftAnchor.constraint(equalTo: contactCellView.leftAnchor , constant: 12),
            contactImage.centerYAnchor.constraint(equalTo: contactCellView.centerYAnchor),
            contactImage.heightAnchor.constraint(equalToConstant: 96),
            contactImage.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    private func configureContactName(name: String) {
        contactName.translatesAutoresizingMaskIntoConstraints = false
        contactName.font = UIFont(name: "SFProText-Medium", size: 32)
        contactName.text = name
        contactName.textColor = MyColors.white
        contactCellView.addSubview(contactName)
        NSLayoutConstraint.activate([
            contactName.leftAnchor.constraint(equalTo: contactImage.rightAnchor, constant: 12),
            contactName.rightAnchor.constraint(equalTo: contactCellView.rightAnchor, constant: -5),
            contactName.topAnchor.constraint(equalTo: contactCellView.topAnchor, constant: 14),
            contactName.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func configureContactPhone(phone: String) {
        contactPhone.translatesAutoresizingMaskIntoConstraints = false
        contactPhone.font = UIFont(name: "SFProText-Regular", size: 12)
        contactPhone.textColor = MyColors.gray
        contactPhone.text = phone
        contactCellView.addSubview(contactPhone)
        NSLayoutConstraint.activate([
            contactPhone.leftAnchor.constraint(equalTo: contactName.leftAnchor),
            contactPhone.topAnchor.constraint(equalTo: contactName.bottomAnchor, constant: 8)
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
    
    private func configureIcons(messengers: MessengersIconNames){
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
                iconConstraints.append(iconView.leftAnchor.constraint(equalTo: contactImage.rightAnchor, constant: 12))
            } else {
                let previousIcon = icons[index-1]
                contactCellView.insertSubview(iconView, belowSubview: previousIcon)
                iconConstraints.append(iconView.leftAnchor.constraint(equalTo: previousIcon.rightAnchor, constant: -4))
            }
            iconConstraints.append(iconView.bottomAnchor.constraint(equalTo: contactImage.bottomAnchor))
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
