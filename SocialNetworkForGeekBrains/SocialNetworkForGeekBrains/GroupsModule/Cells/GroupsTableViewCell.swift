//
//  GroupsTableViewCell.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 26.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTModelStorage
import SnapKit
import Kingfisher

class GroupsTableViewCell: UITableViewCell, ModelTransfer {

    private let imageSize = CGSize(width: 200, height: 200)

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with model: GroupModel) {
        if let url = URL(string: model.photoURL) {
            photoImageView.kf.setImage(with: url, placeholder: UIImage(imageLiteralResourceName: "loadingPicture"))
        } else {
            photoImageView.image = UIImage(imageLiteralResourceName: "unknownPhoto")
        }

        nameLabel.text = model.name
        descriptionLabel.text = model.description
    }

    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.size.equalTo(imageSize)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(photoImageView.snp.trailing).offset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(photoImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
        }
    }
}
