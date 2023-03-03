import UIKit

protocol ContactViewControllerProtocol {
    var presenter: ContactViewPresenterProtocol? { get set }
    var tableView: UITableView { get set }
}


final class ContactViewController: UIViewController & ContactViewControllerProtocol{
    // MARK: - Properties
    var presenter: ContactViewPresenterProtocol?
    private var
    tableStackView = UIView()
    private var filterButton = UIButton()
    private var sortButton = UIButton()
    var tableView = UITableView()
    private var headerTextLabel = UILabel()
    private var cellId = "ContactCellID"

    // MARK: - Methods
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        configuretableStack()
        tableView.delegate = self
        tableView.dataSource = self
        presenter?.view = self
        presenter?.loadData()
        view.backgroundColor = MyColors.fullBlack
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
        cell.textLabel?.textColor = MyColors.white
        cell.backgroundColor = MyColors.fullBlack
        return cell
    }
}

extension ContactViewController: UITableViewDelegate {
    
}



extension ContactViewController {
    private func configuretableStack() {
        tableStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableStackView)
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            tableStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        configureTableView()
        createHeaderText()
        configureFilterButton()
        configureSortButton()
    }
    
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableStackView.addSubview(tableView)
        tableView.backgroundColor = MyColors.fullBlack
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableStackView.topAnchor, constant: 48),
            tableView.bottomAnchor.constraint(equalTo: tableStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableStackView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableStackView.trailingAnchor)
        ])
    }
    
    private func createHeaderText() {
        headerTextLabel.translatesAutoresizingMaskIntoConstraints = false
        tableStackView.addSubview(headerTextLabel)
        headerTextLabel.font = UIFont(name: "SFProText-Bold", size: 34)
        headerTextLabel.text = "Контакты"
        headerTextLabel.textColor = MyColors.white
        NSLayoutConstraint.activate([
            headerTextLabel.topAnchor.constraint(equalTo: tableStackView.topAnchor),
            headerTextLabel.leadingAnchor.constraint(equalTo: tableStackView.leadingAnchor, constant: 16),
            headerTextLabel.widthAnchor.constraint(equalToConstant: 200),
            headerTextLabel.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
    
    private func configureFilterButton() {
        let filterButtonImage = UIImage(named: "filter")
        guard let unwrappedImage = filterButtonImage else { return }
        filterButton = UIButton.systemButton(with: unwrappedImage, target: self, action: #selector(Self.didTapFilterButton))
        filterButton.tintColor = MyColors.white
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        tableStackView.addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            filterButton.centerYAnchor.constraint(equalTo: headerTextLabel.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: tableStackView.trailingAnchor, constant: -18),
            filterButton.widthAnchor.constraint(equalToConstant: 18),
            filterButton.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func configureSortButton() {
        let sortButtonImage = UIImage(named: "sort")
        guard let unwrappedImage = sortButtonImage else { return }
        sortButton = UIButton.systemButton(with: unwrappedImage, target: self, action: #selector(Self.didTapSortButton))
        sortButton.tintColor = MyColors.white
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        tableStackView.addSubview(sortButton)
        
        NSLayoutConstraint.activate([
            sortButton.centerYAnchor.constraint(equalTo: headerTextLabel.centerYAnchor),
            sortButton.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -20),
            sortButton.widthAnchor.constraint(equalToConstant: 18),
            sortButton.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    @objc
    private func didTapFilterButton() {
        
    }
    
    @objc
    private func didTapSortButton() {
        
    }
}

