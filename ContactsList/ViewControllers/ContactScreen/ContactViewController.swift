import UIKit
import Foundation

protocol ContactViewControllerProtocol {
    var presenter: ContactViewPresenterProtocol? { get set }
    func reloadTableData()
}

protocol SortViewDelegate {
    func sortIndicator(isHidden: Bool)
}

protocol FilterViewDelegate{
    func filterIndicator(isHidden: Bool)
}


final class ContactViewController: UIViewController & ContactViewControllerProtocol{
    // MARK: - Properties
    var presenter: ContactViewPresenterProtocol?
    var tableView = UITableView()
    
    var filterViewController = FilterViewController()
    
    var sortViewController = SortViewController()
    
    var swipeInteractionController: SwipeInteractionController?
    
    private var filterButton = UIButton()
    private var sortButton = UIButton()
    private var headerTextLabel = UILabel()
    private var cellId = String(describing: ContactCell.self)
    private let filterIndicator = UIView()
    private let sortIndicator = UIView()
    
    // MARK: - Life cicle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        initialSettings()
        swipeInteractionController = SwipeInteractionController(viewController: self)
    }
    
    func reloadTableData() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extensions
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


extension ContactViewController: UITableViewDelegate {
    private func configureTableView() {
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
    
    private func createHeaderText() {
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
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
        createHeaderText()
        configureFilterButton()
        configureSortButton()
        presenter?.view = self
        presenter?.loadData()
        view.backgroundColor = MyColors.fullBlack
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        reloadTableData()
        configureSortIndicator(indicator: filterIndicator, on: filterButton)
        configureSortIndicator(indicator: sortIndicator, on: sortButton)
    }
    
    
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

extension ContactViewController: FilterTransitionDelegate {
    func changeBackgroundToGray() {
                let grayToFullBlackAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
                grayToFullBlackAnimation.values = [
                    MyColors.fullBlack,
                    MyColors.gray
                ]
                grayToFullBlackAnimation.timeOffset = 0.1
                grayToFullBlackAnimation.duration = 2
                view.layer.add(grayToFullBlackAnimation, forKey: "backgroundColor")
//        let newColor = UIColor.interpolate(from: MyColors.fullBlack, to: MyColors.fullBlack, progress: progress)
//        print(progress)
//        self.view.backgroundColor = newColor
//        DispatchQueue.main.async { [ weak self ] in
//            guard let self = self else { return }
//            self.view.backgroundColor = MyColors.gray
//        }
    }
    
    func changeBackgroundToFullBlack() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.view.backgroundColor = MyColors.fullBlack
        }
    }
}

extension ContactViewController: FilterViewDelegate {
    func filterIndicator(isHidden: Bool) {
        filterIndicator.isHidden = isHidden
    }
}

extension ContactViewController: SortViewDelegate {
    func sortIndicator(isHidden: Bool) {
        sortIndicator.isHidden = isHidden
    }
}

