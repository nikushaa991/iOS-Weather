//
//  ForecastViewController.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/6/21.
//

import UIKit

protocol ForecastView: class {
    func reloadData()
    func show(error: String)
    func contentVisibility(isHiden: Bool)
    func spinnerVisibility(isHiden: Bool)
    func errorVisibility(isHiden: Bool)
}

class ForecastViewController: UIViewController {

    var presenter: ForecastPresenter!

    let headerId = "ForecastSectionHeaderView"
    let cellId = "ForecastCellView"

    @IBOutlet var tableView: UITableView!

    private lazy var spinner = Utils.createSpinner(superview: view)
    private lazy var errorView = Utils.createErrorView(superview: view, delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        ForecastConfigurator().confugure(self)
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.refreshTapped()
    }

    @IBAction func refreshTapped() {
        presenter.refreshTapped()
    }
}

extension ForecastViewController: ForecastView {

    func reloadData() {
        tableView.reloadData()
    }

    func show(error: String) {
        errorView.configure(with: error)
    }

    func contentVisibility(isHiden: Bool) {
        tableView.isHidden = isHiden
    }

    func spinnerVisibility(isHiden: Bool) {
        spinner.isHidden = isHiden
        (isHiden ? spinner.stopAnimating : spinner.startAnimating)()
    }

    func errorVisibility(isHiden: Bool) {
        errorView.isHidden = isHiden
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sectionCount()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cellCount(in: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ForecastSectionHeaderView()
        let model = presenter.sectionModel(of: section)
        header.configure(from: model)
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ForecastCellView
        let model = presenter.cellModel(at: indexPath)
        cell.configure(from: model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ForecastViewController: ErrorViewDelegate {

    func reloadTapped() {
        presenter.refreshTapped()
    }
}
