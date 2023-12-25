//
//  BookingViewController.swift
//  HotelPicker
//
//  Created by ily.pavlov on 19.12.2023.
//

import UIKit

class BookingViewController: UIViewController {
    private let leftPadding: CGFloat = 16
    private var scrollView = UIScrollView()
    
    private let whiteBackHotelInfo = UIView()
    private let yellowView = UIView()
    private let ratingValueLabel = UILabel()
    private let starImage = UIImageView(image: UIImage(systemName: "star.fill"))
    private let hotelNameLabel = UILabel()
    private let hotelAddressLabel = UILabel()
    
    private let whiteBackOrderInfo = UIView()
    private let departureCityLabel = UILabel()
    private let departureCityInfo = UILabel()
    private let arrivalCityLabel = UILabel()
    private let arrivalCityInfo = UILabel()
    private let dateLabel = UILabel()
    private let dateInfo = UILabel()
    private let nightsLabel = UILabel()
    private let nightsInfo = UILabel()
    private let hotelLabel = UILabel()
    private let hotelInfo = UILabel()
    private let roomLabel = UILabel()
    private let roomInfo = UILabel()
    private let foodLabel = UILabel()
    private let foodInfo = UILabel()
    
    private let whiteBackBuyerInfo = UIView()
    private let phoneField = UITextField()
    private let emailField = UITextField()
    private let disclaimerLabel = UILabel()
    
    private let whiteBackTouristInfo = UILabel()
    private let touristCountLabel = UILabel()
    private let nameTouristField = UITextField()
    private let surnameTouristField = UITextField()
    private let dateOfBirthField = UITextField()
    private let countryField = UITextField()
    private let passportNumberField = UITextField()
    private let passportDateField = UITextField()
    
    private let whiteBackMoneyInfo = UIView()
    private let tourLabel = UILabel()
    private let tourInfo = UILabel()
    private let fuelLabel = UILabel()
    private let fuelInfo = UILabel()
    private let serviceLabel = UILabel()
    private let serviceInfo = UILabel()
    private let toPayLabel = UILabel()
    private let toPayInfo = UILabel()
    
    private let buttonBackgroundView = UIView()
    private let button = CustomButton(text: "Оплатить")
    
    var viewModel = BookingViewModel()
    let constants = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.fetchBookingData()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        whiteBackHotelInfo.frame = CGRect(x: 0, y: 8, width: Int(scrollView.frame.width), height: 120)
        
        
        let ratingValueLabelSize = ratingValueLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        yellowView.frame = CGRect(x: leftPadding, y: whiteBackHotelInfo.frame.minY + 16, width: 0, height: 29)
        ratingValueLabel.frame = CGRect(x: 30, y: 0, width: ratingValueLabelSize.width, height: ratingValueLabelSize.height)
        starImage.frame = CGRect(x: 10, y: 0, width: 15, height: 15)
        starImage.center = CGPoint(x: 10 + starImage.frame.width / 2, y: yellowView.frame.height / 2)
        yellowView.frame.size.width = ratingValueLabel.frame.width + starImage.frame.width + 20 + 2
        ratingValueLabel.center = CGPoint(x: (yellowView.frame.width + 2 + starImage.frame.width) / 2, y: yellowView.frame.height / 2)
        
        
        
        buttonBackgroundView.frame = CGRect(x: 0, y: view.frame.maxY - 88, width: view.frame.width, height: 88)
        button.frame = CGRect(x: 0, y: 0, width: 343, height: 48)
        button.center = CGPoint(x: buttonBackgroundView.bounds.midX, y: buttonBackgroundView.bounds.midY - 7)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        
        // MARK: - Настройка scrollView
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        whiteBackHotelInfo.backgroundColor = .white
        whiteBackHotelInfo.layer.cornerRadius = 12
        scrollView.addSubview(whiteBackHotelInfo)
        
        // MARK: - Настройка ScoreTab
        yellowView.backgroundColor = UIColor(red: 1, green: 0.78, blue: 0, alpha: 0.2)
        yellowView.layer.cornerRadius = 5
        whiteBackHotelInfo.addSubview(yellowView)
        
        ratingValueLabel.font = UIFont(name: constants.MediumFont, size: 16)
        ratingValueLabel.textColor = UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)
        yellowView.addSubview(ratingValueLabel)
        
        starImage.tintColor = UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)
        yellowView.addSubview(starImage)
        
        
        // MARK: - Настройка bottomButton
        buttonBackgroundView.backgroundColor = .white
        view.addSubview(buttonBackgroundView)
        
        button.addAction { [weak self] in
            let confirmVC = ConfirmationViewController()
            confirmVC.title = "Заказ оплачен"
            self?.navigationController?.pushViewController(confirmVC, animated: true)
        }
        buttonBackgroundView.addSubview(button)
    }
    
}

extension BookingViewController: BookingViewModelDelegate {
    
    func bookingDataDidUpdate() {
        
        if let ratingScore = viewModel.bookingModel?.horating, let ratingName = viewModel.bookingModel?.ratingName {
            ratingValueLabel.text = "\(ratingScore) \(ratingName)"
        }
        
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}
