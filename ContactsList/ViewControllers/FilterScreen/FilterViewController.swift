import UIKit

protocol FilterViewControllerProtocol {
    var presenter: FilterPresenterProtocol? { get set }
    func makeConfirmButtonEnabled()
    func makeConfirmButtonUnEnabled()
    func updateButtonsImage()
}


final class FilterViewController: UIViewController {
    var presenter: FilterPresenterProtocol?
    private var filterTableView = UITableView()
    private let resetButton = UIButton()
    private let conformButton = UIButton()
    private let cellID = String(describing: FilterViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
        presenter?.copyIsSelectedToTmp()
        presenter?.checkConfirmButtonAccessability()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.copyIsSelectedToTmp()
        updateButtonsImage()
        presenter?.checkConfirmButtonAccessability()
    }
    
    
    
    func initialSettings() {
        filterTableView.delegate = self
        filterTableView.dataSource = self
        presenter?.view = self
        view.backgroundColor = MyColors.fullBlack
        filterTableView.register(FilterViewCell.self, forCellReuseIdentifier: cellID)
        configureFilterTableView()
        confugureResetButton()
        confugureConformButton()
        filterTableView.reloadData()
    }
    
    private func confugureResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.layer.masksToBounds = true
        view.addSubview(resetButton)
        resetButton.setTitle("Cбросить", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        resetButton.titleLabel?.textColor = MyColors.white
        resetButton.backgroundColor = MyColors.fullBlack
        resetButton.layer.cornerRadius = 24
        resetButton.addTarget(self, action: #selector(Self.didTapResetButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resetButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            resetButton.heightAnchor.constraint(equalToConstant: 64),
            resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            resetButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 51) / 2)
        ])
    }
    
    private func confugureConformButton() {
        conformButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conformButton)
        conformButton.setTitle("Применить", for: .normal)
        conformButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        conformButton.titleLabel?.textColor = MyColors.white
        conformButton.backgroundColor = MyColors.blue
        conformButton.layer.cornerRadius = 24
        conformButton.layer.masksToBounds = true
        conformButton.addTarget(self, action: #selector(Self.didTapConfirmButton), for: .touchUpInside)
        
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
            filterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -52)
        ])
    }
    
    @objc
    private func didTapConfirmButton() {
        presenter?.didTapConfirmButton()
        self.dismiss(animated: true)
    }
    
    @objc
    private func didTapResetButton() {
        presenter?.didTapResetButton()
        changeAllButtonsImage()
    }
}

extension FilterViewController: UITableViewDataSource & UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        68
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellModelsCount = self.presenter?.messengerFiltersData.count else {fatalError("Invalid models configuration")}
        return cellModelsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = filterTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? FilterViewCell,
              let cellContent = presenter?.messengerFiltersData[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configureCellContent(content: cellContent)
        return cell
    }
}

extension FilterViewController: FilterCellDelegate {
    func filterCheckboxButtonClicked(cell:FilterViewCell) {
        guard let indexPath = filterTableView.indexPath(for: cell),
              let presenter = presenter else { return }
        presenter.changeTempIsSelectedFor(row: indexPath.row)
        if indexPath.row == 0 {
            presenter.cangeSelectAll()
            changeAllButtonsImage()
        } else {
            if presenter.checkIsAllSelectedNeedDrop() == true {
                dropSelectAllButtonState()
            } else if presenter.checkIsAllSelectedNeedSet() == true {
                setSelectAllButtonState()
            }
        }
        presenter.checkConfirmButtonAccessability()
    }
}


extension FilterViewController {
    func changeAllButtonsImage() {
        guard let tmpIsSelected = presenter?.tmpIsSelected else { return }
        let selectAll: Bool = tmpIsSelected[0]
        for visibleCell in filterTableView.visibleCells {
            guard let filterCell = visibleCell as? FilterViewCell,
                  let indexPath = filterTableView.indexPath(for: filterCell) else { continue }
            if indexPath.row == 0 {
                filterCell.changeCheckboxButtonImage(isSelected: selectAll)
            } else {
                let isSelected = tmpIsSelected[indexPath.row]
                filterCell.changeCheckboxButtonImage(isSelected: isSelected)
                filterCell.isSelected = selectAll
            }
        }
    }
    

    func updateButtonsImage() {
        guard let tmpIsSelected = presenter?.tmpIsSelected else { return }
        for visibleCell in filterTableView.visibleCells {
            guard let filterCell = visibleCell as? FilterViewCell,
                  let indexPath = filterTableView.indexPath(for: filterCell) else { continue }
            let isSelected = tmpIsSelected[indexPath.row]
            filterCell.changeCheckboxButtonImage(isSelected: isSelected)
            filterCell.isSelected = isSelected
        }
    }
    
    func dropSelectAllButtonState() {
        let firstCell = filterTableView.visibleCells.first as? FilterViewCell
        presenter?.dropSelectAll()
        firstCell?.changeCheckboxButtonImage(isSelected: false)
    }
    
    func setSelectAllButtonState() {
        let firstCell = filterTableView.visibleCells.first as? FilterViewCell
        presenter?.setSelectAll()
        firstCell?.changeCheckboxButtonImage(isSelected: true)
    }
}


extension FilterViewController: FilterViewControllerProtocol {
    func makeConfirmButtonEnabled() {
        conformButton.isEnabled = true
        conformButton.backgroundColor = MyColors.blue
    }
    
    func makeConfirmButtonUnEnabled() {
        conformButton.isEnabled = false
        conformButton.backgroundColor = MyColors.gray
    }
}
