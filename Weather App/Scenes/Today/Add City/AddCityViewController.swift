//
//  AddCityViewController.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import UIKit

protocol AddCityView: class {
    func show(error: String)
    func dismiss()
}

class AddCityViewController: UIViewController {

    var presenter: AddCityPresenter!

    @IBOutlet weak var addCityView: UIView!
    @IBOutlet weak var inputTextField: UITextField!

    lazy var errorView: AddCityErrorView = {
        let errorView = AddCityErrorView()
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 92),
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            errorView.heightAnchor.constraint(equalToConstant: 80)
        ])
        return errorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addCityView.layer.cornerRadius = 30
    }

    @IBAction func addTapped() {
        presenter.plusTapped(input: inputTextField.text ?? "")
    }

    @IBAction func backgroundButtonTapped() {
        dismiss()
    }
}

extension AddCityViewController: AddCityView {

    func show(error: String) {
        errorView.configure(with: error)
        errorView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.errorView.isHidden = true
        }
    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
