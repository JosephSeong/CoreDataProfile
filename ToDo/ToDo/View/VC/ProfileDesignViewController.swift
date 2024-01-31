//
//  ProfileDesignViewController.swift
//  ToDo
//
//  Created by Joseph on 1/29/24.
//

import UIKit
import SnapKit

class ProfileDesignViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        setupUI()
        setupConstraints()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let spacing: CGFloat = 2
            let itemSize = (view.bounds.width - 2 * spacing) / 3
            layout.itemSize = CGSize(width: itemSize, height: itemSize)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let menuBtn: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let menuSymbol = UIImage(systemName: "line.horizontal.3", withConfiguration: symbolConfiguration)
        button.setImage(menuSymbol, for: .normal)
        button.tintColor = UIColor.black
        return button
    }()

    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse 1")
        imageView.tintColor = UIColor.systemBlue
        return imageView
    }()

    private let postNum: UILabel = {
        let label = UILabel()
        label.text = "7"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        return label
    }()

    private let postLabel: UILabel = {
        let label = UILabel()
        label.text = "게시물"
        label.textAlignment = .center
        return label
    }()

    private lazy var postStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postNum, postLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private let followerNum: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        return label
    }()

    private let followerLabel: UILabel = {
        let label = UILabel()
        label.text = "팔로워"
        label.textAlignment = .center
        return label
    }()

    private lazy var followerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followerNum, followerLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private let followingNum: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .bold)
        return label
    }()

    private let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "팔로잉"
        label.textAlignment = .center
        return label
    }()

    private lazy var followingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followingNum, followingLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postStackView, followerStackView, followingStackView])
        stackView.axis = .horizontal
        stackView.spacing = 40
        return stackView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "seong"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .semibold)
        return label
    }()

    private let explaneLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer 🍎"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()

    private let linkLabel: UILabel = {
        let label = UILabel()
        label.text = "spartacodingclub.kr"
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()

    private let followBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("팔로우", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
        button.layer.cornerRadius = 5
        return button
    }()

    private let messageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("메세지", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()

    private let moreBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()

    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray
        return view
    }()

    private let gridBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        button.tintColor = .black
        return button
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private let profileBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(profileBtnTap), for: .touchUpInside)
        return button
    }()

    private let cellIdentifier = "PhotoCell"

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(menuBtn)
        view.addSubview(profileImage)
//        view.addSubview(postNum)
//        view.addSubview(postLabel)
        view.addSubview(postStackView)
//        view.addSubview(followerNum)
//        view.addSubview(followerLabel)
        view.addSubview(followerStackView)
//        view.addSubview(followingNum)
//        view.addSubview(followingLabel)
        view.addSubview(followingStackView)
        view.addSubview(infoStackView)
        view.addSubview(nameLabel)
        view.addSubview(explaneLabel)
        view.addSubview(linkLabel)
        view.addSubview(followBtn)
        view.addSubview(messageBtn)
        view.addSubview(moreBtn)
        view.addSubview(dividerView)
        view.addSubview(gridBtn)
        view.addSubview(collectionView)
        view.addSubview(profileBtn)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
        }

        menuBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.trailing.equalToSuperview().offset(-10)
        }

        profileImage.snp.makeConstraints { make in
            make.top.equalTo(menuBtn.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(88)
        }

        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-28)
        }

        //
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }

        explaneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }

        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(explaneLabel.snp.bottom).offset(4)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }

        //
        followBtn.snp.makeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }

        messageBtn.snp.makeConstraints { make in
            make.centerY.equalTo(followBtn.snp.centerY)
            make.leading.equalTo(followBtn.snp.trailing).offset(8)
            make.width.equalTo(150)
        }

        moreBtn.snp.makeConstraints { make in
            make.centerY.equalTo(followBtn.snp.centerY)
            make.leading.equalTo(messageBtn.snp.trailing).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.height.equalTo(30)
        }

        //
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(followBtn.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.2)
        }

        gridBtn.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(15)
            make.width.equalTo(view.snp.width).dividedBy(3) // 3등분
        }

        //
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(gridBtn.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(profileBtn.snp.top).offset(-15)
        }

        profileBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCell

        cell.imageView.image = UIImage(named: "picture")
        return cell
    }

    @objc private func profileBtnTap() {
        let profileVC = ProfileViewController()
        self.present(profileVC, animated: true, completion: nil)
        //navigationController?.pushViewController(profileViewController, animated: true)
    }
}




// MARK: - Extension
extension ProfileDesignViewController {

}
