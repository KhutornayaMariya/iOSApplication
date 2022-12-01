//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotosCollectionViewCell"

    private let photo: UIImageView = {
        let view = UIImageView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with image: UIImage) {
        photo.image = image
    }

    private func setup() {
        backgroundColor = .systemGray6
        addSubview(photo)

        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: topAnchor),
            photo.leadingAnchor.constraint(equalTo: leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
