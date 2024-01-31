//
//  ProfileViewController.swift
//  ToDo
//
//  Created by Joseph on 1/31/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    private let viewModel = ProfileViewModel()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchUserProfile()
    }

    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)

        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }

        ageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
    }

    private func fetchUserProfile() {
        viewModel.fetchUserProfile {
            self.updateUI()
        }
    }

    private func updateUI() {
        nameLabel.text = "이름: \(viewModel.userName)"
        ageLabel.text = "나이: \(viewModel.userAge)"
    }
}
