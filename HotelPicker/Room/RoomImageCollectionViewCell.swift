//
//  RoomImageCollectionViewCell.swift
//  HotelPicker
//
//  Created by ily.pavlov on 24.12.2023.
//

import UIKit

class RoomImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "RoomImageCollectionViewCell"

    private let imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.frame = contentView.bounds
        contentView.addSubview(imageView)
    }

    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = contentView.center
        activityIndicator.startAnimating()
        contentView.addSubview(activityIndicator)
    }

    func loadImages(from urls: [String]) {
        guard !urls.isEmpty else {
            activityIndicator.stopAnimating()
            return
        }

        var loadedImages = [UIImage?]()

        for url in urls {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        loadedImages.append(image)
                    } else {
                        loadedImages.append(nil)
                    }

                    if loadedImages.count == urls.count {
                        DispatchQueue.main.async {
                            if let firstLoadedImage = loadedImages.first {
                                self?.imageView.image = firstLoadedImage
                            }
                            self?.activityIndicator.stopAnimating()
                        }
                    }
                }.resume()
            } else {
                loadedImages.append(nil)
            }
        }
    }

}
