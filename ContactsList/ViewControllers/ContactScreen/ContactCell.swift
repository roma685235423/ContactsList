import UIKit


final class ContactCell: UITableViewCell {
    // MARK: - Properties
    private var contactImage = UIImageView()
    private var contactName = UILabel()
    private var contactPhone = UILabel()
    private let contactCellView = UIView()
    let cellId = "ContactCellID"
    
    // MARK: - Methods
    func configureCell(name: String, phone: String, imageData: Data?) {
        self.selectionStyle = .none
        self.backgroundView?.backgroundColor = .clear
        let image = configureImage(imageData: imageData)
        configureContactCellView()
        configureContactImage(image: image)
        configureContactName(name: name)
        configureContactPhone(phone: phone)
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
        contactCellView.addSubview(contactName)
        
        NSLayoutConstraint.activate([
            contactName.leftAnchor.constraint(equalTo: contactImage.rightAnchor, constant: 12),
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
    
    private func configureImage(imageData: Data?) -> UIImage {
        guard let data = imageData else {
            return UIImage(named: "avatar") ?? UIImage()
        }
        return UIImage(data: data)!
    }
}
