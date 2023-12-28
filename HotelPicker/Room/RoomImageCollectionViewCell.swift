//
//  RoomImageCollectionViewCell.swift
//  HotelPicker
//
//  Created by ily.pavlov on 24.12.2023.
//

import UIKit

class RoomImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "RoomImageCollectionViewCell"
    
    let imageView = UIImageView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        self.imageView.image = image
        self.activityIndicator.stopAnimating()
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
}
