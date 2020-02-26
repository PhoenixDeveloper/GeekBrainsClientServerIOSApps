//
//  PhotosTableViewCell.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 26.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTModelStorage
import SnapKit
import Alamofire

class PhotosTableViewCell: UITableViewCell, ModelTransfer {

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(photoImageView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with model: PhotoModel) {
        guard let photo = model.sizes.last, let url = URL(string: photo.url) else {
            photoImageView.image = UIImage(imageLiteralResourceName: "unknownPhoto")
            return
        }

        photoImageView.kf.setImage(with: url, placeholder: UIImage(imageLiteralResourceName: "loadingPicture"))
    }

    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
