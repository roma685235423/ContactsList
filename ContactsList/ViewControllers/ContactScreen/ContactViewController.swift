import UIKit

protocol ContactViewControllerProtocol {
    var presenter: ContactViewPresenterProtocol? {get set}
}


final class ContactViewController: UIViewController & ContactViewControllerProtocol{
    // MARK: - Properties
    var presenter: ContactViewPresenterProtocol?
    private var tableView = UITableView()
    private var tableSuperview = UIView()
    private var cellId = "ContactCellID"

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        confugureUIElements()
        tableView.delegate = self
        tableView.dataSource = self
        presenter?.view = self
        view.backgroundColor = .red
        //presenter?.loadData()
        tableView.reloadData()
    }
}

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellModelsCount = self.presenter?.contactCellModels.count else {fatalError("Invalid models configuration")}
        return cellModelsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let contact = self.presenter?.contactCellModels[indexPath.row]
        cell.textLabel?.text = "\(contact?.name ?? "") - \(contact?.phone ?? "")"
        return cell
    }
}

extension ContactViewController: UITableViewDelegate {
    
}

extension ContactViewController {
    private func configureTableSuperview() {
        tableSuperview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableSuperview)
        tableSuperview.backgroundColor = .green
        NSLayoutConstraint.activate([
            tableSuperview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableSuperview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableSuperview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableSuperview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableSuperview.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableSuperview.topAnchor, constant: -25),
            tableView.bottomAnchor.constraint(equalTo: tableSuperview.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableSuperview.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableSuperview.trailingAnchor)
        ])
    }
    
    private func confugureUIElements() {
        configureTableSuperview()
        configureTableView()
    }
}

