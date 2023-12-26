//
//  RoomTableViewCell.swift
//  HotelPicker
//
//  Created by ily.pavlov on 24.12.2023.
//

import UIKit

protocol RoomTableViewCellDelegate: AnyObject {
    func didSelectRoom()
}

class RoomTableViewCell: UITableViewCell {
    
    static let identifier = "RoomCell"
    
    private let leftPadding: CGFloat = 16
    
    private var collectionView: UICollectionView!
    private let pageControl = UIPageControl()
    private let roomNameLabel = UILabel()

    private let blueView = UIView()
    private let moreInfoLabel = UILabel()
    private let chevronImage = UIImageView(image: UIImage(systemName: "chevron.forward"))
    private var tagCloudView = TagCloudView()

    private let minPriceLabel = UILabel()
    private let priceDecriptionLabel = UILabel()
    
    private let button = CustomButton(text: "Выбрать номер")
    
    var room : [Room] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private let constants = Constants()
    
    weak var delegate: RoomTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let roomNameLabelSize = roomNameLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        roomNameLabel.frame = CGRect(x: leftPadding, y: collectionView.frame.maxY + 8, width: 343, height: roomNameLabelSize.height)
        
        let tagCloudViewSize = tagCloudView.sizeThatFits(CGSize(width: 295, height: CGFloat.greatestFiniteMagnitude))
        tagCloudView.frame = CGRect(x: leftPadding, y: roomNameLabel.frame.maxY + 8, width: 295, height: tagCloudViewSize.height)
        
        let moreInfoLabelSize = moreInfoLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        blueView.frame = CGRect(x: leftPadding, y: tagCloudView.frame.maxY + 13, width: moreInfoLabelSize.width, height: 29)
        moreInfoLabel.frame = CGRect(x: 10, y: (blueView.frame.height - moreInfoLabelSize.height) / 2, width: moreInfoLabelSize.width, height: moreInfoLabelSize.height)
        chevronImage.frame = CGRect(x: moreInfoLabel.frame.maxX + 2, y: (blueView.frame.height - 15) / 2, width: 15, height: 15)
        blueView.frame.size.width = moreInfoLabel.frame.width + chevronImage.frame.width + 20 + 2
        
        let minPriceLabelSize = minPriceLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        minPriceLabel.frame = CGRect(x: leftPadding, y: blueView.frame.maxY + 16, width: minPriceLabelSize.width, height: minPriceLabelSize.height)
        
        let priceDecriptionLabelSize = priceDecriptionLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        priceDecriptionLabel.frame = CGRect(x: minPriceLabel.frame.maxX + 8, y: blueView.frame.maxY + 30, width: priceDecriptionLabelSize.width, height: priceDecriptionLabelSize.height)
        
        button.frame = CGRect(x: 16, y: priceDecriptionLabel.frame.maxY + 19, width: self.bounds.width - 32, height: 48)
        collectionView.frame.size.width = self.bounds.width - 32
        pageControl.center = CGPoint(x: collectionView.bounds.midX, y: collectionView.frame.maxY - 13)

    }
    
    func configureCell(imageUrls: [String], roomName: String, tagCloud: [String], minPrice: String, priceDescription: String) {
    
        configureCollectionView(with: [imageUrls])
        self.roomNameLabel.text = roomName
        self.tagCloudView.tags = tagCloud
        self.minPriceLabel.text = ("\(minPrice) ₽")
        self.priceDecriptionLabel.text = priceDescription
        collectionView.reloadData()
    }

    private func setupUI() {
        // MARK: - Настройка UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: leftPadding, y: 16, width: 0, height: 257), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGray6
        collectionView.layer.cornerRadius = 15
        contentView.addSubview(collectionView)
        collectionView.register(RoomImageCollectionViewCell.self, forCellWithReuseIdentifier: RoomImageCollectionViewCell.reuseIdentifier)
        
        // MARK: - Настройка UIPageControl
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = .white
        pageControl.numberOfPages = 0
        collectionView.addSubview(pageControl)
        
        // MARK: - Настройка roomName
        roomNameLabel.numberOfLines = 0
        roomNameLabel.font = UIFont(name: constants.MediumFont, size: 22)
        roomNameLabel.backgroundColor = .white
        contentView.addSubview(roomNameLabel)
        
        // MARK: - Настройка tagCloudView
        contentView.addSubview(tagCloudView)

        // MARK: - Настройка UIPageControl
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = .white
        pageControl.numberOfPages = 0
        pageControl.center = CGPoint(x: self.frame.width / 2, y: collectionView.frame.maxY - 13)
        contentView.addSubview(pageControl)
        
        // MARK: - Настройка MoreTab
        blueView.backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 0.1)
        blueView.layer.cornerRadius = 5
        contentView.addSubview(blueView)
        
        moreInfoLabel.font = UIFont(name: constants.MediumFont, size: 16)
        moreInfoLabel.textColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
        moreInfoLabel.text = "Подробнее о номере"
        blueView.addSubview(moreInfoLabel)
        
        chevronImage.tintColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
        blueView.addSubview(chevronImage)

        // MARK: - Настройка minPrice
        minPriceLabel.font = UIFont(name: constants.SemiboldFont, size: 30)
        contentView.addSubview(minPriceLabel)
        
        // MARK: - Настройка priceDecription
        priceDecriptionLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        priceDecriptionLabel.font = UIFont(name: constants.RegularFont, size: 16)
        contentView.addSubview(priceDecriptionLabel)
        
        // MARK: - Настройка bottomButton
        button.addAction {
            self.delegate?.didSelectRoom()
        }
        contentView.addSubview(button)

    }
    
    private func configureCollectionView(with urls: [[String]]) {
        pageControl.numberOfPages = urls.count
        pageControl.currentPage = 0
        collectionView.reloadData()
    }
}

extension RoomTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return room.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomImageCollectionViewCell.reuseIdentifier, for: indexPath) as? RoomImageCollectionViewCell else {
            fatalError("Unable to dequeue ImageCollectionViewCell")
        }

        let room = self.room[indexPath.item]
        cell.loadImages(from: room.imageUrls)

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        guard pageWidth > 0 else { return}
        
        let currentPage = Int((scrollView.contentOffset.x + 0.5 * pageWidth) / pageWidth)
        pageControl.currentPage = currentPage
    }
}
