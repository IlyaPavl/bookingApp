//
//  ViewController.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import UIKit

final class HotelViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    
    private var topBlock: TopBlock!
    private var bottomBlock: BottomBlock!
    
    private let whiteBackgroundBottom = UIView()
    private let buttonBackgroundView = UIView()
    private let button = CustomButton(text: "К выбору номера")
    
    var viewModel = HotelViewModel()
    let constants = Constants()

    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        navigationItem.title = "Отель"
        viewModel.fetchHotelData()
        viewModel.delegate = self
        
        setupHotelUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLayoutSubviews() {
        print(#function)
        super.viewDidLayoutSubviews()
        setupHotelLayout()
        scrollView.contentSize = CGSize(width: view.frame.width, height: topBlock.frame.height + bottomBlock.frame.height + buttonBackgroundView.frame.height)
    }
}

extension HotelViewController: HotelViewModelDelegate {
    func hotelDataDidUpdate() {
        print(#function)
        if let imageUrls = viewModel.hotelModel?.imageUrls {
            topBlock.imageURLs = imageUrls
            topBlock.pageControl.numberOfPages = imageUrls.count
        }
        
        if let ratingScore = viewModel.hotelModel?.rating,
           let ratingName = viewModel.hotelModel?.ratingName,
           let name = viewModel.hotelModel?.name,
           let address = viewModel.hotelModel?.adress,
           let minPrice = viewModel.hotelModel?.minimalPrice,
           let priceDescription = viewModel.hotelModel?.priceForIt {
            topBlock.setHotelBlockDataFor(ratingValueText: "\(ratingScore) \(ratingName)",
                                hotelNameText: name,
                                hotelAddressText: address,
                                minPriceText: "от \(minPrice.formattedWithSeparator()) ₽",
                                priceDecriptionText: priceDescription)
        }

        if let tags = viewModel.hotelModel?.aboutTheHotel.peculiarities,
           let hotelDescription = viewModel.hotelModel?.aboutTheHotel.description {
            bottomBlock.setBotoomBlockDataFor(tagCloudViewTags: tags, aboutHotelDescription: hotelDescription)
        }
        
        topBlock.setNeedsLayout()
        topBlock.layoutIfNeeded()
        
        bottomBlock.setNeedsLayout()
        bottomBlock.layoutIfNeeded()
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}

// MARK: - setup UI and layout
extension HotelViewController {
    private func setupHotelUI() {
        print(#function)
        view.backgroundColor = constants.viewColor
        // MARK: - scrollView
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        // MARK: - topBlock
        topBlock = TopBlock(frame: CGRect(x: 0, y: constants.commonPadding, width: scrollView.frame.width, height: constants.baseBlockHeight))

        topBlock.backgroundColor = .white
        topBlock.layer.cornerRadius = constants.commonCornerRadius
        topBlock.collectionView.dataSource = self
        topBlock.collectionView.delegate = self
        scrollView.addSubview(topBlock)
        
        bottomBlock = BottomBlock(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: constants.baseBlockHeight))
        bottomBlock.backgroundColor = .white
        bottomBlock.layer.cornerRadius = constants.commonCornerRadius
        scrollView.addSubview(bottomBlock)
        
        // MARK: - Настройка bottomButton
        buttonBackgroundView.backgroundColor = .white
        view.addSubview(buttonBackgroundView)
        
        button.addAction { [weak self] in
            guard let self = self else { return }
            let roomViewController = RoomViewController()
            let navTitle = UILabel()
            navTitle.text = self.viewModel.hotelModel?.name
            navTitle.adjustsFontSizeToFitWidth = true
            navTitle.minimumScaleFactor = 0.5
            navTitle.font = UIFont(name: constants.MediumFont, size: 18)
            roomViewController.navigationItem.titleView = navTitle
            
            self.navigationController?.pushViewController(roomViewController, animated: true)
        }
        buttonBackgroundView.addSubview(button)
    }
    
    private func setupHotelLayout() {
        print(#function)
        bottomBlock.frame.origin.y = topBlock.frame.maxY + constants.commonPadding
        
        let buttonBackgroundHeight: CGFloat = 88
        buttonBackgroundView.frame = CGRect(x: 0, y: view.frame.maxY - buttonBackgroundHeight, width: view.frame.width, height: buttonBackgroundHeight)
        button.frame = CGRect(x: (view.frame.width - constants.commonWidth) / 2, y: (buttonBackgroundView.frame.height - constants.buttonHeight - constants.commonPadding) / 2, width: constants.commonWidth, height: constants.buttonHeight)
        bottomBlock.advantage.view.frame.size.height = 190

    }
}

extension HotelViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topBlock.pageControl.numberOfPages = topBlock.imageURLs.count
        return topBlock.imageURLs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelImageCollectionViewCell.reuseIdentifier, for: indexPath) as? HotelImageCollectionViewCell else {
            fatalError("Unable to dequeue ImageCollectionViewCell")
        }
        
        let imageURL = topBlock.imageURLs[indexPath.item]
        viewModel.fetchImage(from: imageURL) { image in
            cell.imageView.image = image
            cell.activityIndicator.stopAnimating()
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HotelViewController: UIScrollViewDelegate {
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        guard pageWidth > 0 else { return }
        
        let currentPage = Int((scrollView.contentOffset.x + 0.5 * pageWidth) / pageWidth)
        topBlock.pageControl.currentPage = currentPage
    }
}
