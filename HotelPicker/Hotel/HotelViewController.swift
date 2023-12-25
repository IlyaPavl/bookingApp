//
//  ViewController.swift
//  HotelPicker
//
//  Created by ily.pavlov on 17.12.2023.
//

import UIKit

final class HotelViewController: UIViewController {
    
    private let leftPadding: CGFloat = 16
    
    private var whiteBackgroundTop = UIView()
    private var scrollView: UIScrollView!
    private var collectionView: UICollectionView!
    let pageControl = UIPageControl()
    private let yellowView = UIView()
    private let ratingValueLabel = UILabel()
    private let starImage = UIImageView(image: UIImage(systemName: "star.fill"))
    private let hotelNameLabel = UILabel()
    private let hotelAddressLabel = UILabel()
    private let minPriceLabel = UILabel()
    private let priceDecriptionLabel = UILabel()
    private let aboutHotelLabel = UILabel()
    private let tagCloudView = TagCloudView()
    private let aboutHotelDescriptionLabel = UILabel()
    private let advantage = AdvantageTableVC()
    private let whiteBackgroundBottom = UIView()
    
    private let buttonBackgroundView = UIView()
    private let button = CustomButton(text: "К выбору номера")
    
    var viewModel = HotelViewModel()
    let constants = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Отель"
        setupUI()
        
        viewModel.fetchHotelData()
        viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        whiteBackgroundTop.frame = CGRect(x: 0, y: 8, width: Int(scrollView.frame.width), height: 460)
        
        let ratingValueLabelSize = ratingValueLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        yellowView.frame = CGRect(x: leftPadding, y: collectionView.frame.maxY + 16, width: 0, height: 29)
        ratingValueLabel.frame = CGRect(x: 30, y: 0, width: ratingValueLabelSize.width, height: ratingValueLabelSize.height)
        starImage.frame = CGRect(x: 10, y: 0, width: 15, height: 15)
        starImage.center = CGPoint(x: 10 + starImage.frame.width / 2, y: yellowView.frame.height / 2)
        yellowView.frame.size.width = ratingValueLabel.frame.width + starImage.frame.width + 20 + 2
        ratingValueLabel.center = CGPoint(x: (yellowView.frame.width + 2 + starImage.frame.width) / 2, y: yellowView.frame.height / 2)
        
        let hotelNameLabelSize = hotelNameLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        hotelNameLabel.frame = CGRect(x: leftPadding, y: yellowView.frame.maxY + 8, width: hotelNameLabelSize.width, height: hotelNameLabelSize.height)
        
        let hotelAddressLabelSize = hotelAddressLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        hotelAddressLabel.frame = CGRect(x: leftPadding, y: hotelNameLabel.frame.maxY + 8, width: hotelAddressLabelSize.width, height: hotelAddressLabelSize.height)
        
        let minPriceLabelSize = minPriceLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        minPriceLabel.frame = CGRect(x: leftPadding, y: hotelAddressLabel.frame.maxY + 16, width: minPriceLabelSize.width, height: minPriceLabelSize.height)
        
        let priceDecriptionLabelSize = priceDecriptionLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        priceDecriptionLabel.frame = CGRect(x: minPriceLabel.frame.maxX + 8, y: hotelAddressLabel.frame.maxY + 30, width: priceDecriptionLabelSize.width, height: priceDecriptionLabelSize.height)
        
        aboutHotelLabel.frame = CGRect(x: leftPadding, y: 16, width: 275, height: 26)
        
        let tagCloudViewSize = tagCloudView.sizeThatFits(CGSize(width: 295, height: CGFloat.greatestFiniteMagnitude))
        tagCloudView.frame = CGRect(x: leftPadding, y: aboutHotelLabel.frame.maxY + 16, width: 295, height: tagCloudViewSize.height)
        
        let descriptionLabelSize = aboutHotelDescriptionLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        aboutHotelDescriptionLabel.frame = CGRect(x: leftPadding, y: tagCloudView.frame.maxY + 12, width: descriptionLabelSize.width, height: descriptionLabelSize.height)
        
        whiteBackgroundBottom.frame = CGRect(x: 0, y: whiteBackgroundTop.frame.maxY + 8, width: scrollView.frame.width, height: calculateWhiteBackgroundBottomHeight())
        advantage.view.frame = CGRect(x: 16, y: aboutHotelDescriptionLabel.frame.maxY + 20, width: view.frame.width - 32, height: 205)
        
        buttonBackgroundView.frame = CGRect(x: 0, y: view.frame.maxY - 88, width: view.frame.width, height: 88)
        button.frame = CGRect(x: 0, y: 0, width: 343, height: 48)
        button.center = CGPoint(x: buttonBackgroundView.bounds.midX, y: buttonBackgroundView.bounds.midY - 7)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: whiteBackgroundTop.frame.height + whiteBackgroundBottom.frame.height + buttonBackgroundView.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        // MARK: - Создание UIScrollView
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        // MARK: - Настройка whiteBackgroundTop
        whiteBackgroundTop.layer.cornerRadius = 12
        whiteBackgroundTop.backgroundColor = .white
        scrollView.addSubview(whiteBackgroundTop)
        
        // MARK: - Настройка UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: leftPadding, y: 0, width: view.frame.width - 32, height: 257), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGray6
        collectionView.layer.cornerRadius = 15
        whiteBackgroundTop.addSubview(collectionView)
        collectionView.register(HotelImageCollectionViewCell.self, forCellWithReuseIdentifier: HotelImageCollectionViewCell.reuseIdentifier)
        
        // MARK: - Настройка UIPageControl
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = .white
        pageControl.numberOfPages = 0
        pageControl.center = CGPoint(x: whiteBackgroundTop.frame.width / 2, y: collectionView.frame.maxY - 13)
        whiteBackgroundTop.addSubview(pageControl)
        
        // MARK: - Настройка ScoreTab
        yellowView.backgroundColor = UIColor(red: 1, green: 0.78, blue: 0, alpha: 0.2)
        yellowView.layer.cornerRadius = 5
        whiteBackgroundTop.addSubview(yellowView)
        
        ratingValueLabel.font = UIFont(name: constants.MediumFont, size: 16)
        ratingValueLabel.textColor = UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)
        yellowView.addSubview(ratingValueLabel)
        
        starImage.tintColor = UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)
        yellowView.addSubview(starImage)
        
        // MARK: - Настройка hotelName
        hotelNameLabel.numberOfLines = 0
        hotelNameLabel.font = UIFont(name: constants.MediumFont, size: 22)
        whiteBackgroundTop.addSubview(hotelNameLabel)
        
        // MARK: - Настройка hotelAddress
        hotelAddressLabel.numberOfLines = 0
        hotelAddressLabel.font = UIFont(name: constants.MediumFont, size: 14)
        hotelAddressLabel.textColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
        whiteBackgroundTop.addSubview(hotelAddressLabel)
        
        // MARK: - Настройка minPrice
        minPriceLabel.font = UIFont(name: constants.SemiboldFont, size: 30)
        whiteBackgroundTop.addSubview(minPriceLabel)
        
        // MARK: - Настройка priceDecription
        priceDecriptionLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        priceDecriptionLabel.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackgroundTop.addSubview(priceDecriptionLabel)
        
        // MARK: - Настройка whiteBackgroundBottom
        whiteBackgroundBottom.layer.cornerRadius = 12
        whiteBackgroundBottom.backgroundColor = .white
        scrollView.addSubview(whiteBackgroundBottom)
        
        // MARK: - Настройка aboutHotelLabel
        aboutHotelLabel.text = "Об отеле"
        aboutHotelLabel.font = UIFont(name: constants.MediumFont, size: 22)
        whiteBackgroundBottom.addSubview(aboutHotelLabel)
        
        // MARK: - Настройка tagCloudView
        whiteBackgroundBottom.addSubview(tagCloudView)
        
        // MARK: - Настройка aboutHotelDescriptionLabel
        aboutHotelDescriptionLabel.numberOfLines = 0
        aboutHotelDescriptionLabel.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackgroundBottom.addSubview(aboutHotelDescriptionLabel)
        
        // MARK: - Настройка advantageTable
        advantage.view.layer.cornerRadius = 15
        addChild(advantage)
        whiteBackgroundBottom.addSubview(advantage.view)
        advantage.didMove(toParent: self)
        
        // MARK: - Настройка bottomButton
        buttonBackgroundView.backgroundColor = .white
        view.addSubview(buttonBackgroundView)
        
        button.addAction { [weak self] in
            guard let self = self else { return }
            let roomViewController = RoomViewController()
            roomViewController.title = self.hotelNameLabel.text

            self.navigationController?.pushViewController(roomViewController, animated: true)
        }

        buttonBackgroundView.addSubview(button)
    }
    
    private func configureCollectionView(with urls: [String]) {
        pageControl.numberOfPages = urls.count
        pageControl.currentPage = 0
        collectionView.reloadData()
    }
    
    private func calculateWhiteBackgroundBottomHeight() -> CGFloat {
        let aboutHotelLabelMaxY = aboutHotelLabel.frame.maxY
        let tagCloudViewMaxY = tagCloudView.frame.maxY
        let aboutHotelDescriptionLabelMaxY = aboutHotelDescriptionLabel.frame.height
        let advantageTableMaxY = advantage.view.frame.height
        let backgroundBottomHeight = aboutHotelLabelMaxY + tagCloudViewMaxY + aboutHotelDescriptionLabelMaxY + advantageTableMaxY + 16
        
        return backgroundBottomHeight
    }

}

extension HotelViewController: HotelViewModelDelegate {
    func hotelDataDidUpdate() {
        if let urls = viewModel.hotelModel?.imageUrls {
            configureCollectionView(with: urls)
        }
        if let ratingScore = viewModel.hotelModel?.rating, let ratingName = viewModel.hotelModel?.ratingName {
            ratingValueLabel.text = "\(ratingScore) \(ratingName)"
        }
        if let name = viewModel.hotelModel?.name {
            hotelNameLabel.text = name
        }
        if let address = viewModel.hotelModel?.adress {
            hotelAddressLabel.text = address
        }
        if let minPrice = viewModel.hotelModel?.minimalPrice {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            if let formattedPrice = numberFormatter.string(from: NSNumber(value: minPrice)) {
                self.minPriceLabel.text = "от \(formattedPrice) ₽"
            }
        }
        if let priceDescription = viewModel.hotelModel?.priceForIt {
            priceDecriptionLabel.text = priceDescription
        }
        if let tags = viewModel.hotelModel?.aboutTheHotel.peculiarities {
            tagCloudView.tags = tags
        }
        if let hotelDescription = viewModel.hotelModel?.aboutTheHotel.description {
            aboutHotelDescriptionLabel.text = hotelDescription
        }
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}

extension HotelViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hotelModel?.imageUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelImageCollectionViewCell.reuseIdentifier, for: indexPath) as? HotelImageCollectionViewCell else {
            fatalError("Unable to dequeue ImageCollectionViewCell")
        }
        
        if let imageUrl = viewModel.hotelModel?.imageUrls[indexPath.item] {
            cell.loadImage(from: imageUrl)
        }
        
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
