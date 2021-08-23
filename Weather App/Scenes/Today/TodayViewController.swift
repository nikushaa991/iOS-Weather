//
//  TodayViewController.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/26/21.
//

import UIKit

protocol TodayView: class {
    func reloadData()
    func show(error: String)
    func contentVisibility(isHiden: Bool)
    func spinnerVisibility(isHiden: Bool)
    func errorVisibility(isHiden: Bool)
}

class TodayViewController: UIViewController {

    var presenter: TodayPresenter!

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    private lazy var spinner = Utils.createSpinner(superview: view)
    private lazy var errorView = Utils.createErrorView(superview: view, delegate: self)

    private var alert: UIAlertController {
        let alert = UIAlertController(title: "Would you like to delete city?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        })
        return alert
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TodayConfigurator().configure(self)

        collectionView.dataSource = self
        collectionView.delegate = self

        let collectionViewSize = UIScreen.main.bounds.size

        let cellWidth = collectionViewSize.width * 0.8
        let cellHeight = collectionViewSize.height * 0.55

        let insetX: CGFloat = (collectionViewSize.width - cellWidth) / 2
        let insetY: CGFloat = 0

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)

        listenToLongPress()

        presenter.viewDidLoad()
    }

    @IBAction func plusTapped() {
        presenter.plusTapped()
    }

    @IBAction func refreshTapped() {
        presenter.refreshTapped()
    }
}

extension TodayViewController: TodayView {

    func reloadData() {
        collectionView.reloadData()
    }

    func show(error: String) {
        errorView.configure(with: error)
    }

    func contentVisibility(isHiden: Bool) {
        contentView.isHidden = isHiden
    }

    func spinnerVisibility(isHiden: Bool) {
        spinner.isHidden = isHiden
        (isHiden ? spinner.stopAnimating : spinner.startAnimating)()
    }

    func errorVisibility(isHiden: Bool) {
        errorView.isHidden = isHiden
    }
}

extension TodayViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCollectionViewCell", for: indexPath) as! TodayCollectionViewCell
        let viewModel = presenter.viewModelForItem(at: indexPath.row)
        cell.configure(from: viewModel)
        return cell
    }
}

extension TodayViewController: UICollectionViewDelegate { }

extension TodayViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)

        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset

        presenter.itemScrolled(to: Int(roundedIndex))
    }
}

extension TodayViewController: UIGestureRecognizerDelegate {

    private func listenToLongPress() {
        let lgpr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        lgpr.minimumPressDuration = 1
        lgpr.delaysTouchesBegan = true
        lgpr.delegate = self
        collectionView.addGestureRecognizer(lgpr)
    }

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state != .ended { return }
        let location = gesture.location(in: self.collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: location) {
            let alert = self.alert
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                self?.presenter.itemPressed(at: indexPath.row)
            })
            present(alert, animated: true, completion: nil)
        } else {
            self.show(error: "Can not find index path")
        }
    }
}

extension TodayViewController: ErrorViewDelegate {

    func reloadTapped() {
        presenter.refreshTapped()
    }
}
