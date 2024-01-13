//
//  RoomImageCollectionViewCell.swift
//  Hotel
//
//  Created by ily.pavlov on 10.01.2024.
//

import UIKit

class RoomImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "RoomImageCollectionViewCell"

    let imageView = UIImageView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)

        activityIndicator.center = contentView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 257)
        activityIndicator.center = contentView.center
    }
}
