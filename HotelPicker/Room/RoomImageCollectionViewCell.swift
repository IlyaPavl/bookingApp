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
        activityIndicator.startAnimating()

        for urlString in urls {
            if let imageUrl = URL(string: urlString) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                            self?.activityIndicator.stopAnimating()
                        }
                    }
                }.resume()
            }
        }
    }

}
