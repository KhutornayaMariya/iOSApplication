//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {

    private let title: UILabel = {
        let view = UILabel()

        view.textColor = .label
        view.font = .systemFont(ofSize: 24, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "PHOTO".localized

        return view
    }()

    private let arrow: UIImageView = {
        let view = UIImageView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "arrow.right", withConfiguration: .none)?.withRenderingMode(.alwaysTemplate)
        view.tintColor = UIColor.createColor(lightMode: .black, darkMode: .white)

        return view
    }()

    private func photos() -> [UIImageView] {
        let names = ["one", "two", "three", "four"]
        var images: [UIImageView] = []
        names.forEach {
            let view = UIImageView()

            let screenSize = UIScreen.main.bounds.size.width
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 6
            view.clipsToBounds = true
            view.contentMode = .scaleAspectFill
            view.image = UIImage(named: $0)
            view.heightAnchor.constraint(equalToConstant: (screenSize - 48)/4).isActive = true
            view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true

            images.append(view)
        }
        return images
    }

    private let photosStackView: UIStackView = {
        let view = UIStackView()

        view.axis = .horizontal
        view.alignment = .top
        view.distribution = .fill
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let subviews = photos()
        subviews.forEach { photosStackView.addArrangedSubview($0) }
        [title, arrow, photosStackView].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: .safeArea),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),

            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            arrow.centerYAnchor.constraint(equalTo: title.centerYAnchor),

            photosStackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: .safeArea),
            photosStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            photosStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.safeArea),
        ])
    }
}

private extension CGFloat {
    static let safeArea: CGFloat = 12
}
