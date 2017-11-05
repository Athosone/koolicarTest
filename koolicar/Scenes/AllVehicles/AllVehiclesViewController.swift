//
//  AllVehiclesViewController.swift
//  koolicar
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Hero

class AllVehiclesViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    var presenter: AllVehiclesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.updateNavigator(navigationController: navigationController)
        configureUI()
        configureTableView()
        bindPresenter()
    }

    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Véhicules"
        navigationController?.isHeroEnabled = true
        view.backgroundColor = Theme.Color.backgroundColor.color
    }

    func configureTableView() {
        tableView.register(UINib(nibName: AllVehiclesItemCell.reuseID, bundle: nil),
                           forCellReuseIdentifier: AllVehiclesItemCell.reuseID)
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
    }

    func bindPresenter() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = AllVehiclesPresenter.Input(selection: tableView.rx.itemSelected.asDriver(),
                                               trigger: viewWillAppear)
        let output = presenter.transform(input: input)
        output.selectedVehicle.drive().disposed(by: self.disposeBag)
        output.vehicles
            .drive(tableView.rx.items(cellIdentifier: AllVehiclesItemCell.reuseID,
                                      cellType: AllVehiclesItemCell.self)) { (_, item, cell) in
            cell.fillWithItem(item: item)
            cell.vehicleBrandLabel.heroID = "Brand+\(item.vehicleId)"
            cell.vehicleCategoryLabel.heroID = "Category+\(item.vehicleId)"
            cell.vehicleImageView.heroID = "Image+\(item.vehicleId)"
        }.disposed(by: self.disposeBag)
    }

}
