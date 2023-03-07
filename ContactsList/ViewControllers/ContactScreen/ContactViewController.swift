import UIKit
import Foundation

protocol ContactViewControllerProtocol {
    var presenter: ContactViewPresenterProtocol? { get set }
    func reloadTableData()
}


final class ContactViewController: UIViewController & ContactViewControllerProtocol{
    // MARK: - Properties
    var presenter: ContactViewPresenterProtocol?
    var tableView = UITableView()
    
    private var filterButton = UIButton()
    private var sortButton = UIButton()
    private var headerTextLabel = UILabel()
    private var cellId = String(describing: ContactCell.self)
    
    // MARK: - Methods
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        initialSettings()
    }
    
    func reloadTableData() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        124
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellModelsCount = self.presenter?.contactCellModels.count else {fatalError("Invalid models configuration")}
        return cellModelsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contactCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = self.presenter?.contactCellModels[indexPath.row]
        let contactName = "\(contact?.name ?? "")"
        let contactPhone = "\(contact?.phone ?? "")"
        let contactData = contact?.photoData
        contactCell.configureCell(name: contactName, phone: contactPhone, imageData: contactData)
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
    }
    
    
    @objc
    private func didTapFilterButton() {
        let filterViewController = FilterViewController()
        let filterPresenter = FilterPresenter()
        filterViewController.presenter = filterPresenter
        filterViewController.modalPresentationStyle = .pageSheet
        filterViewController.transitionDelegate = self
        present(filterViewController, animated: true)
    }
    
    @objc
    private func didTapSortButton() {
        
    }
}

extension ContactViewController: FilterTransitionDelegate {
    func changeBackgroundToGray() {
        //        let grayToFullBlackAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        //        grayToFullBlackAnimation.values = [
        //            MyColors.fullBlack,
        //            MyColors.gray
        //        ]
        //        grayToFullBlackAnimation.timeOffset = 0.1
        //        grayToFullBlackAnimation.duration = 0.2
        //
        //        view.layer.add(grayToFullBlackAnimation, forKey: "backgroundColor")
//        let newColor = UIColor.interpolate(from: MyColors.fullBlack, to: MyColors.fullBlack, progress: progress)
//        print(progress)
//        self.view.backgroundColor = newColor
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.view.backgroundColor = MyColors.gray
        }
    }
    
    func changeBackgroundToFullBlack() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.view.backgroundColor = MyColors.fullBlack
        }
    }
}
