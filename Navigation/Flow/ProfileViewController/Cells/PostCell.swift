//
//  PostCell.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class PostCell: UITableViewCell {

    public var onTapHander: (() -> Void)? {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapWrapper))
            tap.numberOfTapsRequired = 2
            addGestureRecognizer(tap)
        }
    }

    private let title: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let image: UIImageView = {
        let view = UIImageView()

        view.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let desc: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .systemGray
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let likes: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let heart: UIImageView = {
        let view = UIImageView()

        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .red

        return view
    }()

    private let views: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.textColor = .black
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

    public func configure(with data: PostModel) {
        title.text = data.author
        desc.text = data.description
        image.image = UIImage(named: data.image)
        heart.image = data.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likes.text = "Likes: " + String(data.likes)
        views.text = "Views: " + String(data.views)
    }

    private func setup() {
        backgroundColor = .white
        let subviews = [title, image, desc, likes, views, heart]
        subviews.forEach { addSubview($0) }
        let screenWidth = UIScreen.main.bounds.size.width

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: .safeArea),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),

            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: .safeArea),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.widthAnchor.constraint(equalToConstant: screenWidth),
            image.heightAnchor.constraint(equalToConstant: screenWidth),

            desc.topAnchor.constraint(equalTo: image.bottomAnchor, constant: .safeArea),
            desc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            desc.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),

            heart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            heart.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: .safeArea),
            heart.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.safeArea),

            likes.leadingAnchor.constraint(equalTo: heart.trailingAnchor, constant: .safeArea),
            likes.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: .safeArea),
            likes.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.safeArea),

            views.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            views.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: .safeArea),
            views.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.safeArea),
        ])
    }

    @objc
    private func tapWrapper() {
        if onTapHander != nil {
            onTapHander?()
        }
    }
}

private extension CGFloat {
    static let size: CGFloat = 100
    static let safeArea: CGFloat = 16
    static let vertical: CGFloat = 120
}
