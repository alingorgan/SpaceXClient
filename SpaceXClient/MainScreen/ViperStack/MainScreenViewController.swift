//
//  MainScreenViewController.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 5/27/21.
//

import UIKit

final class MainScreenViewController: UIViewController, MainScreenView {
    
    private let sections: [TableSection] = [
        .init(title: "Company", cellType: CompanyInfoCell.self),
        .init(title: "Launches", cellType: LaunchInfoCell.self)
    ]
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainScreenPresenter? = nil
    
    var viewModel = MainScreenViewModel.empty {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func setupUI() {
        setupView()
        setupTableView()
        setupRefreshControl()
    }
    
    func setupView() {
        title = "SpaceX"
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupRefreshControl() {
        refreshControl.largeContentTitle = "Loading"
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        presenter?.viewDidRefresh()
    }
    
    func updateUI() {
        switch viewModel {
        case .loadingData:
            refreshControl.beginRefreshing()
        case .loaded(companyInfo: _, launches: _, loadingPhase: let loadingPhase):
            switch loadingPhase {
            case .companyInfo:
                tableView.reloadData()
            case .launches:
                tableView.reloadData()
                refreshControl.endRefreshing()
            }
        case .error(message: let message):
            refreshControl.endRefreshing()
            let alertView = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert)
            
            alertView.show(self, sender: nil)
        default:
            refreshControl.endRefreshing()
        }
    }
}

extension MainScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard case .loaded = viewModel else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemCountForSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = sections[indexPath.section].cellType
        let dequeuedCell = tableView.dequeueReusableCell(
            withIdentifier: cellType.CellIdentifier,
            for: indexPath)
        
        guard
            let cell = dequeuedCell as? IdentifiableCell,
            let displayable = viewModel.displayableForItem(at: indexPath)
        else {
            assertionFailure("Unexpected cell type")
            return dequeuedCell
        }
        
        cell.update(displayable: displayable)
        
        return cell
    }
}

private struct TableSection {
    let title: String
    let cellType: IdentifiableCell.Type
}
