import UIKit

protocol FilterViewControllerProtocol {
    var presenter: FilterPresenterProtocol? { get set }
}

final class FilterViewController: UIViewController & FilterViewControllerProtocol {
    var presenter: FilterPresenterProtocol?
    private var filterTableView = UITableView()
    private let resetButton = UIButton()
    private let conformButton = UIButton()
    private let cellID = String(describing: FilterViewCell.self)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.delegate = self
        filterTableView.dataSource = self
        presenter?.view = self
        view.backgroundColor = MyColors.fullBlack
        filterTableView.register(FilterViewCell.self, forCellReuseIdentifier: cellID)
        confugureResetButton()
        confugureConformButton()
        configureFilterTableView()
        filterTableView.reloadData()
    }
    
    private func confugureResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetButton)
        resetButton.setTitle("Cбросить", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        resetButton.titleLabel?.textColor = MyColors.white
        resetButton.backgroundColor = MyColors.fullBlack
        resetButton.layer.cornerRadius = 24
        resetButton.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            resetButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            resetButton.heightAnchor.constraint(equalToConstant: 64),
            resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            resetButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 51) / 2)
        ])
    }
    
    private func confugureConformButton() {
        conformButton.translatesAutoresizingMaskIntoConstraints = false
        conformButton.setTitle("Применить", for: .normal)
        conformButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        conformButton.titleLabel?.textColor = MyColors.white
        conformButton.backgroundColor = MyColors.blue
        conformButton.layer.cornerRadius = 24
        conformButton.layer.masksToBounds = true
        view.addSubview(conformButton)
        
        NSLayoutConstraint.activate([
            conformButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            conformButton.heightAnchor.constraint(equalTo: resetButton.heightAnchor),
            conformButton.centerYAnchor.constraint(equalTo: resetButton.centerYAnchor),
            conformButton.widthAnchor.constraint(equalTo: resetButton.widthAnchor)
        ])
    }
    
    private func configureFilterTableView() {
        filterTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterTableView)
        filterTableView.backgroundColor = .clear
        filterTableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            filterTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            filterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 52)
        ])
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        68
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellModelsCount = self.presenter?.messengerData.count else {fatalError("Invalid models configuration")}
        return cellModelsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = filterTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? FilterViewCell,
              let cellContent = presenter?.messengerData[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configureCellContent(content: cellContent)
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    
    
}
