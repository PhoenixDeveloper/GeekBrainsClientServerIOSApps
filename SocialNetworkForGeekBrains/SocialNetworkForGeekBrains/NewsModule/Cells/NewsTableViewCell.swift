//
//  NewsTableViewCell.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 20.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import SnapKit
import DTModelStorage

class NewsTableViewCell: UITableViewCell, ModelTransfer {

    private let ownerPhotoSize = CGSize(width: 50, height: 50)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private lazy var ownerPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var ownerName: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        setupConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(ownerName)
        contentView.addSubview(ownerPhoto)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
    }

    private func setupConstrains() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }

        ownerPhoto.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(ownerPhotoSize)
        }

        ownerName.snp.makeConstraints { make in
            make.leading.equalTo(ownerPhoto.snp.trailing).offset(16)
            make.centerY.equalTo(ownerPhoto)
            make.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(ownerName.snp.bottom).offset(8)
            make.leading.greaterThanOrEqualTo(ownerPhoto.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(dateLabel.snp.bottom).offset(16)
            make.top.greaterThanOrEqualTo(ownerPhoto.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    func update(with model: NewsModel) {
        titleLabel.text = model.title

        ownerPhoto.image = model.owner.photo ?? UIImage(imageLiteralResourceName: "unknownPhoto")

        ownerName.text = model.owner.fullName
        dateLabel.text = convertDate(date: model.date)
        descriptionLabel.text = model.description
    }

    private func convertDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yy, HH:mm"
        return dateFormatter.string(from: date)
    }
}
