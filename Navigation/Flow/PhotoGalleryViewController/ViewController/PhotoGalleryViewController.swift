//
//  PhotoGalleryViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit
import iOSIntPackage

final class PhotoGalleryViewController: UIViewController {

    var dataItems: [UIImage] = ProfileRepository().photoItems

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")

        return view
    }()

    // MARK: - Initializers

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        title = "Photo Gallery"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        applyImageFilter()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Private methods

    private func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func applyImageFilter() {
        let startDefault = CFAbsoluteTimeGetCurrent()
        ImageProcessor().processImagesOnThread(sourceImages: dataItems,
                                               filter: .monochrome(color: .red, intensity: 1.0),
                                               qos: .userInteractive) { result in
            self.dataItems = result.compactMap { UIImage(cgImage: $0!) }
            let end = CFAbsoluteTimeGetCurrent()
            let time = end - startDefault
            print("userInteractive time evaluated: \(time)")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return .photoSection
        }
    }
}

extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.configure(with: dataItems[indexPath.row])
        return cell
    }
}

// MARK: NSCollectionLayoutSection

private extension NSCollectionLayoutSection {
    static let photoSection: NSCollectionLayoutSection = {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: .inset, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0/3.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = .inset
        section.contentInsets = NSDirectionalEdgeInsets(top: .inset, leading: 0, bottom: .inset, trailing: .inset)

        return section
    }()
}

private extension CGFloat {
    static let inset: CGFloat = 8
}
