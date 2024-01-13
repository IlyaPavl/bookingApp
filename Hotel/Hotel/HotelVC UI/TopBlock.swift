//
//  TopBlock.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import UIKit

final class TopBlock: UIView {
    
    // MARK: - CollectionView Elements
    var collectionView: UICollectionView!
    var pageControl = UIPageControl()
    var imageURLs: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - TopBlock UI
    private let yellowView = UIView()
    private let ratingValueLabel = UILabel()
    private let starImage = UIImageView(image: UIImage(systemName: "star.fill"))
    private let hotelNameLabel = UILabel()
    private let hotelAddressLabel = UILabel()
    private let minPriceLabel = UILabel()
    private let priceDecriptionLabel = UILabel()
    
    weak var dataSource: UICollectionViewDataSource?
    weak var delegate: UICollectionViewDelegateFlowLayout?
    
    let constants = Constants()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTopLayout()
    }
    
    func setHotelBlockDataFor(ratingValueText: String, hotelNameText: String, hotelAddressText: String, minPriceText: String, priceDecriptionText: String) {
        ratingValueLabel.text = ratingValueText
        hotelNameLabel.text = hotelNameText
        hotelAddressLabel.text = hotelAddressText
        minPriceLabel.text = minPriceText
        priceDecriptionLabel.text = priceDecriptionText
    }

    private func setupTopUI() {
        print(#function)

        // MARK: - CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: CGRect(x: constants.commonPadding * 2, y: 0, width: self.frame.width - constants.leftPadding * 2, height: 257), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 15
        collectionView.backgroundColor = .systemGray6
        addSubview(collectionView)
        collectionView.register(HotelImageCollectionViewCell.self, forCellWithReuseIdentifier: HotelImageCollectionViewCell.reuseIdentifier)
        
        // MARK: - Настройка pageControl
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundColor = .white
        pageControl.layer.cornerRadius = 5
        addSubview(pageControl)

        
        // MARK: - Настройка ScoreTab
        yellowView.backgroundColor = constants.ratingBgColor
        yellowView.layer.cornerRadius = 5
        addSubview(yellowView)
        
        ratingValueLabel.font = UIFont(name: constants.MediumFont, size: 16)
        ratingValueLabel.textColor = constants.ratingTextColor
        yellowView.addSubview(ratingValueLabel)
        
        starImage.tintColor = constants.starColor
        yellowView.addSubview(starImage)
        
        // MARK: - Настройка hotelName
        hotelNameLabel.numberOfLines = 0
        hotelNameLabel.font = UIFont(name: constants.MediumFont, size: 22)
        addSubview(hotelNameLabel)
        
        // MARK: - Настройка hotelAddress
        hotelAddressLabel.numberOfLines = 0
        hotelAddressLabel.font = UIFont(name: constants.MediumFont, size: 14)
        hotelAddressLabel.textColor = constants.blueTextColor
        addSubview(hotelAddressLabel)
        
        // MARK: - Настройка minPrice
        minPriceLabel.font = UIFont(name: constants.SemiboldFont, size: 30)
        addSubview(minPriceLabel)
        
        // MARK: - Настройка priceDecription
        priceDecriptionLabel.textColor = constants.lightGreyTextColor
        priceDecriptionLabel.font = UIFont(name: constants.RegularFont, size: 16)
        addSubview(priceDecriptionLabel)
    
    }
    
    private func setupTopLayout() {
        print(#function)

        let ratingValueLabelSize = ratingValueLabel.sizeThatFits(CGSize(width: constants.commonWidth, height: CGFloat.greatestFiniteMagnitude))
        yellowView.frame = CGRect(x: constants.leftPadding, y: collectionView.frame.maxY + constants.commonPadding * 2, width: 0, height: 29)
        ratingValueLabel.frame = CGRect(x: 30, y: 0, width: ratingValueLabelSize.width, height: ratingValueLabelSize.height)
        starImage.frame = CGRect(x: 10, y: 0, width: 15, height: 15)
        starImage.center = CGPoint(x: 10 + starImage.frame.width / 2, y: yellowView.frame.height / 2)
        yellowView.frame.size.width = ratingValueLabel.frame.width + starImage.frame.width + 20 + 2
        ratingValueLabel.center = CGPoint(x: (yellowView.frame.width + 2 + starImage.frame.width) / 2, y: yellowView.frame.height / 2)
        
        let hotelNameLabelSize = hotelNameLabel.sizeThatFits(CGSize(width: constants.commonWidth, height: CGFloat.greatestFiniteMagnitude))
        hotelNameLabel.frame = CGRect(x: constants.leftPadding, y: yellowView.frame.maxY + constants.commonPadding,
                                      width: hotelNameLabelSize.width, height: hotelNameLabelSize.height)
        
        let hotelAddressLabelSize = hotelAddressLabel.sizeThatFits(CGSize(width: constants.commonWidth, height: CGFloat.greatestFiniteMagnitude))
        hotelAddressLabel.frame = CGRect(x: constants.leftPadding, y: hotelNameLabel.frame.maxY + constants.commonPadding,
                                         width: hotelAddressLabelSize.width, height: hotelAddressLabelSize.height)
        
        let minPriceLabelSize = minPriceLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        minPriceLabel.frame = CGRect(x: constants.leftPadding, y: hotelAddressLabel.frame.maxY + constants.commonPadding * 2,
                                     width: minPriceLabelSize.width, height: minPriceLabelSize.height)
        
        let priceDecriptionLabelSize = priceDecriptionLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        priceDecriptionLabel.frame = CGRect(x: minPriceLabel.frame.maxX + constants.commonPadding, y: hotelAddressLabel.frame.maxY + 30,
                                            width: priceDecriptionLabelSize.width, height: priceDecriptionLabelSize.height)
        
        let pageControlSize = pageControl.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 15))
        pageControl.frame = CGRect(x: collectionView.center.x - pageControlSize.width / 2, y: collectionView.frame.maxY - 25, width: pageControlSize.width, height: 20)
        pageControl.numberOfPages = imageURLs.count
        
        let totalHeight = collectionView.collectionViewLayout.collectionViewContentSize.height + yellowView.frame.height + hotelNameLabel.frame.height + hotelAddressLabel.frame.height + minPriceLabel.frame.height + (constants.commonPadding * 7)
        self.frame.size.height = totalHeight
    }
}
