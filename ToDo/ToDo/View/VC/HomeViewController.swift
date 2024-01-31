//
//  HomeViewController.swift
//  ToDo
//
//  Created by Joseph on 1/12/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://spartacodingclub.kr/css/images/scc-og.jpg"

        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }

            let image = UIImage(data: data)

            DispatchQueue.main.sync { [weak self] in
                self?.imageView.image = image
            }
        })
        task.resume()

        // 버튼 레이아웃 설정
        profileBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileBtn)

        view.addSubview(profileBtn)
        profileBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-240)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(110)
            make.height.equalTo(38)
        }
    }

    private let profileBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로필", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(profileBtnTap), for: .touchUpInside)
        return button
    }()

    @objc func profileBtnTap() {
        let profileDesignVC = ProfileDesignViewController()
        //self.navigationController?.pushViewController(profileVC, animated:true)
        self.present(profileDesignVC, animated: true, completion: nil)
    }
}
