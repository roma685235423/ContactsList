import UIKit
import Foundation

// MARK: - ContactViewControllerProtocol
protocol ContactViewControllerProtocol {
    var presenter: ContactViewPresenterProtocol? { get set }
    func reloadTableData()
    func isNeedToHideNoSuitableContactsLabel(isHidden: Bool)
}



// MARK: - SortViewDelegate
protocol SortViewDelegate {
    func sortIndicator(isHidden: Bool)
}



// MARK: - FilterViewDelegate
protocol FilterViewDelegate{
    func filterIndicator(isHidden: Bool)
}



final class ContactViewController: UIViewController & ContactViewControllerProtocol{
    // MARK: - UI
    var tableView = UITableView()
    private var filterButton = UIButton()
    private var sortButton = UIButton()
    private var headerTextLabel = UILabel()
    private let filterIndicatorView = UIView()
    private let sortIndicatorView = UIView()
    private let noSuitableContactsLabel = UILabel()
    
    // MARK: - Properties
    private var cellId = String(describing: ContactCell.self)
    var filterViewController = FilterViewController()
    var sortViewController = SortViewController()
    var presenter: ContactViewPresenterProtocol?
    
    
    
    // MARK: - Life cicle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        initialSettings()
    }
    
    
    // MARK: - Methods
    func reloadTableData() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    
    func isNeedToHideNoSuitableContactsLabel(isHidden: Bool) {
        noSuitableContactsLabel.isHidden = isHidden
    }
}



// MARK: - Extension ContactViewController
extension ContactViewController {
    // MARK: - UI Configuration
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.indicatorStyle = .white
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 116),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    private func configureHeaderTextLabel() {
        headerTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerTextLabel)
        headerTextLabel.font = UIFont(name: "SFProText-Bold", size: 34)
        headerTextLabel.text = "Контакты"
        headerTextLabel.textColor = MyColors.white
        NSLayoutConstraint.activate([
            headerTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headerTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerTextLabel.widthAnchor.constraint(equalToConstant: 200),
            headerTextLabel.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
    
    
    private func configureNoSuitableContactsLabel() {
        noSuitableContactsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noSuitableContactsLabel)
        noSuitableContactsLabel.font = UIFont(name: "SFProText-Regular", size: 16)
        noSuitableContactsLabel.text = "Таких контактов нет, выберите другие фильтры"
        noSuitableContactsLabel.textAlignment = .center
        noSuitableContactsLabel.numberOfLines = 0
        noSuitableContactsLabel.isHidden = true
        noSuitableContactsLabel.textColor = MyColors.white
        NSLayoutConstraint.activate([
            noSuitableContactsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noSuitableContactsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noSuitableContactsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    private func configureFilterButton() {
        let filterButtonImage = UIImage(named: "filter")
        guard let unwrappedImage = filterButtonImage else { return }
        filterButton = UIButton.systemButton(with: unwrappedImage, target: self, action: #selector(Self.didTapFilterButton))
        filterButton.tintColor = MyColors.white
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.centerYAnchor.constraint(equalTo: headerTextLabel.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
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
        view.addSubview(sortButton)
        NSLayoutConstraint.activate([
            sortButton.centerYAnchor.constraint(equalTo: headerTextLabel.centerYAnchor),
            sortButton.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -20),
            sortButton.widthAnchor.constraint(equalToConstant: 18),
            sortButton.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    private func configureSortIndicator(indicator: UIView, on button: UIButton) {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        indicator.layer.cornerRadius = indicator.bounds.size.width / 2
        indicator.layer.borderWidth = 2
        indicator.clipsToBounds = true
        indicator.layer.borderColor = MyColors.fullBlack.cgColor
        indicator.backgroundColor = MyColors.red
        indicator.isHidden = true
        button.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.heightAnchor.constraint(equalToConstant: 16),
            indicator.widthAnchor.constraint(equalToConstant: 16),
            indicator.centerYAnchor.constraint(equalTo: button.topAnchor),
            indicator.centerXAnchor.constraint(equalTo: button.rightAnchor)
        ])
    }
    
    
    private func initialSettings() {
        view.backgroundColor = MyColors.fullBlack
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        presenter?.view = self
        configureTableView()
        configureHeaderTextLabel()
        configureFilterButton()
        configureSortButton()
        reloadTableData()
        configureSortIndicator(indicator: filterIndicatorView, on: filterButton)
        configureSortIndicator(indicator: sortIndicatorView, on: sortButton)
        configureNoSuitableContactsLabel()
    }
    
    
    // MARK: - Actions
    @objc
    private func didTapFilterButton() {
        filterViewController.modalPresentationStyle = .pageSheet
        present(filterViewController, animated: true)
    }
    
    
    @objc
    private func didTapSortButton() {
        sortViewController.modalPresentationStyle = .pageSheet
        present(sortViewController, animated: true)
    }
}



// MARK: - Extension UITableViewDataSource
extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        124
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellModelsCount = self.presenter?.contactCellModels.count else {fatalError("Invalid models configuration")}
        return cellModelsCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contactCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ContactCell,
              let contact = self.presenter?.contactCellModels[indexPath.row]
        else {
            return UITableViewCell()
        }
        contactCell.configureCell(contact: contact)
        return contactCell
    }
}



// MARK: - Extension UITableViewDelegate
extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAlert = UIAlertController(
            title: nil,
            message: "Уверены что хотите удалить контакт?",
            preferredStyle: .actionSheet
        )
        let alertAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            self?.presenter?.removeCellModel(index: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAlert.addAction(alertAction)
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Удалить"
        ) { [weak self]  _, _, completion in
            self?.present(deleteAlert, animated: true)
        }
        deleteAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        for subview in tableView.subviews {
            if NSStringFromClass(type(of: subview)) == "_UITableViewCellSwipeContainerView" {
                for swipeContainerSubview in subview.subviews {
                    if NSStringFromClass(type(of: swipeContainerSubview)) == "UISwipeActionPullView" {
                        swipeContainerSubview.backgroundColor = MyColors.red
                        swipeContainerSubview.layer.cornerRadius = 24
                        swipeContainerSubview.clipsToBounds = true
                        for case let button as UIButton in swipeContainerSubview.subviews {
                            button.layer.cornerRadius = 24
                            button.clipsToBounds = true
                        }
                    }
                }
            }
        }
    }
}



// MARK: - Extension FilterViewDelegate
extension ContactViewController: FilterViewDelegate {
    func filterIndicator(isHidden: Bool) {
        filterIndicatorView.isHidden = isHidden
    }
}



// MARK: - Extension SortViewDelegate
extension ContactViewController: SortViewDelegate {
    func sortIndicator(isHidden: Bool) {
        sortIndicatorView.isHidden = isHidden
    }
}
