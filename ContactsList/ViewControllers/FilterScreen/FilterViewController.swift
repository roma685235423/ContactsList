import UIKit

protocol FilterViewControllerProtocol {
    var presenter: FilterPresenterProtocol? { get set }
}

protocol FilterTransitionDelegate: AnyObject {
    func changeBackgroundToGray()
    func changeBackgroundToFullBlack()
}


final class FilterViewController: UIViewController & FilterViewControllerProtocol {
    var presenter: FilterPresenterProtocol?
    private var filterTableView = UITableView()
    private let resetButton = UIButton()
    private let conformButton = UIButton()
    private let cellID = String(describing: FilterViewCell.self)
    weak var transitionDelegate: FilterTransitionDelegate?
    var startColor = MyColors.fullBlack
    var endColor = MyColors.gray
    
    var interactionController: SwipeInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
        presenter?.copyIsSelectedToTmp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let transitionCoordinator = self.transitionCoordinator else { return }
//        transitionCoordinator.animate(alongsideTransition: { [ weak self ] context in
//            guard let percentComplite = self?.transitionCoordinator?.percentComplete else { return }
//            self?.transitionDelegate?.changeBackgroundToGray(progress: percentComplite)
//        }, completion: nil)
        transitionDelegate?.changeBackgroundToGray()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        transitionDelegate?.changeBackgroundToFullBlack()
        //transitionDelegate?.changeBackgroundToGray()
    }
    
    
    func initialSettings() {
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
    
    func updateBackgroundColor(offsetY: CGFloat) {
        let progress = min(max(offsetY / 100, 0), 1) // ограничиваем прогресс от 0 до 1
        let newColor = UIColor.interpolate(from: startColor, to: endColor, progress: progress)
        self.view.backgroundColor = newColor
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

extension FilterViewController: UITableViewDataSource & UITableViewDelegate {
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
        cell.delegate = self
        cell.configureCellContent(content: cellContent)
        return cell
    }
    
    func selectAllButtonDidTap() {
        presenter?.selectAll()
        filterTableView.reloadData()
    }
}

extension FilterViewController: FilterCellDelegate {
    func filterCheckboxButtonClicked(cell:FilterViewCell) {
        guard let indexPath = filterTableView.indexPath(for: cell),
              let presenter = presenter else { return }
        presenter.changTempIsSelectedFor(row: indexPath.row)
        if indexPath.row == 0 {
            presenter.selectAll()
            changeAllButtonsImage(cell: cell)
        } else {
            if presenter.checkIsAllSelectedNeedDrop() == true {
                dropSelectAllButtonState()
            } else if presenter.checkIsAllSelectedNeedSet() == true {
                setSelectAllButtonState()
            }
        }
    }
}


extension FilterViewController {
    func changeAllButtonsImage(cell: FilterViewCell) {
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
