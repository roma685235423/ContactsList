import UIKit


final class ContactCell: UITableViewCell {
    // MARK: - Properties
    private var contactImage = UIImageView()
    private var contactName = UILabel()
    private var contactPhone = UILabel()
    private let contactCellView = UIView()
    
    // MARK: - Methods
    func configureCell(contact: Contact) {
        self.selectionStyle = .none
        self.contentView.backgroundColor = MyColors.fullBlack
        let photoData = contact.photoData
        let image = configureImage(imageData: photoData)
        configureContactCellView()
        configureContactImage(image: image)
        configureContactName(name: contact.name)
        configureContactPhone(phone: contact.phone)
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
        imageView.image = UIImage(named: iconName)
        return imageView
    }
    
    private func configureImage(imageData: Data?) -> UIImage {
        guard let data = imageData else {
            return UIImage(named: "avatar") ?? UIImage()
        }
        return UIImage(data: data)!
    }
}

/*
 private func configureIcons(messengers: messengersIconNames) {
     let iconSize: CGFloat = 30
     var iconConstraints = [NSLayoutConstraint]()
     var icons = [UIImageView]()

     if let telegramIcon = messengers.telegram {
         let imageView = createIconImageView(iconName: telegramIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let whatsAppIcon = messengers.whatsApp {
         let imageView = createIconImageView(iconName: whatsAppIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let viberIcon = messengers.viber {
         let imageView = createIconImageView(iconName: viberIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let signalIcon = messengers.signal {
         let imageView = createIconImageView(iconName: signalIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let threemaIcon = messengers.threema {
         let imageView = createIconImageView(iconName: threemaIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let phoneIcon = messengers.phone {
         let imageView = createIconImageView(iconName: phoneIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     if let emailIcon = messengers.email {
         let imageView = createIconImageView(iconName: emailIcon, iconSize: iconSize)
         icons.append(imageView)
     }

     for (index, iconView) in icons.enumerated() {
         contactCellView.addSubview(iconView)

         if index == 0 {
             iconConstraints.append(iconView.leftAnchor.constraint(equalTo: contactImage.rightAnchor, constant: 12))
         } else {
             let previousIcon = icons[index-1]
             iconConstraints.append(iconView.leftAnchor.constraint(equalTo: previousIcon.rightAnchor, constant: 8))
         }

         iconConstraints.append(iconView.centerYAnchor.constraint(equalTo: contactCellView.centerYAnchor))
         iconConstraints.append(iconView.heightAnchor.constraint(equalToConstant: iconSize))
         iconConstraints.append(iconView.widthAnchor.constraint(equalToConstant: iconSize))
     }

     NSLayoutConstraint.activate(iconConstraints)
 }

 private func createIconImageView(iconName: String, iconSize: CGFloat) -> UIImageView {
     let imageView = UIImageView()
     imageView.translatesAutoresizingMaskIntoConstraints = false
     imageView.image = UIImage(named: iconName)
     imageView.contentMode = .scaleAspectFit
     imageView.layer.cornerRadius = iconSize / 2
     imageView.clipsToBounds = true
     return imageView
 }
 */
