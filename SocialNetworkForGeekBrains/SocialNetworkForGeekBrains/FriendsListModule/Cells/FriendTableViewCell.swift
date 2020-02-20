//
//  FriendTableViewCell.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 20.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import SnapKit
import DTModelStorage
import RxSwift

class FriendTableViewCell: UITableViewCell, ModelTransfer {

    var disposeBag = DisposeBag()

    private let photoSize = CGSize(width: 150, height: 150)

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()

    lazy var deleteFromFriendsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить из друзей", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(deleteFromFriendsButton)
    }

    private func setupConstraints() {

        photoImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.size.equalTo(photoSize)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
        }

        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(photoImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }

        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.centerX.equalTo(usernameLabel)
        }

        deleteFromFriendsButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(ageLabel.snp.bottom).offset(16)
            make.centerX.equalTo(ageLabel)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    func update(with model: UserModel) {
        photoImageView.image = model.photo ?? UIImage(imageLiteralResourceName: "unknownPhoto")

        usernameLabel.text = model.fullName
        ageLabel.text = model.age.description
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }
}
