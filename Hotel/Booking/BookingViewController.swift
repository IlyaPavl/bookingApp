//
//  BookingViewController.swift
//  Hotel
//
//  Created by ily.pavlov on 11.01.2024.
//

import UIKit

final class BookingViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var hotelBlock: HotelBlock!
    private var travelInfoBlock: TravelInfoBlock!
    private var priceBlock: PriceBlock!
    private var buyerInfoBlock: BuyerInfoBlock!
    private var touristInfoBlock: TouristInfoBlock!
    
    private let buttonBackgroundView = UIView()
    private let button = CustomButton(text: "Оплатить")
    
    var viewModel = BookingViewModel()
    let constants = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n", #function)
        viewModel.fetchBookingData()
        viewModel.delegate = self
        
        setupBookingUI()
        hideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
        setupBookingLayout()
        scrollView.contentSize = CGSize(width: view.frame.width, height: hotelBlock.frame.height + travelInfoBlock.frame.height + buyerInfoBlock.frame.height + touristInfoBlock.frame.height + priceBlock.frame.height + buttonBackgroundView.frame.height + constants.leftPadding)
    }
    
    private func setupBookingUI() {
        print(#function)
        view.backgroundColor = constants.viewColor
        
        // MARK: - Настройка scrollView
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        // MARK: - Настройка hotelBlock
        hotelBlock = HotelBlock()
        hotelBlock.frame = CGRect(x: 0, y: constants.commonPadding, width: view.frame.width, height: 120)
        hotelBlock.layer.cornerRadius = constants.commonCornerRadius
        hotelBlock.backgroundColor = .white
        scrollView.addSubview(hotelBlock)
        
        // MARK: - Настройка travelInfoBlock
        travelInfoBlock = TravelInfoBlock()
        travelInfoBlock.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 280)
        travelInfoBlock.layer.cornerRadius = constants.commonCornerRadius
        travelInfoBlock.backgroundColor = .white
        scrollView.addSubview(travelInfoBlock)
        
        // MARK: - Настройка priceBlock
        priceBlock = PriceBlock()
        priceBlock.layer.cornerRadius = constants.commonCornerRadius
        priceBlock.backgroundColor = .white
        priceBlock.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 156)
        scrollView.addSubview(priceBlock)
        
        // MARK: - Настройка buyerInfoBlock
        buyerInfoBlock = BuyerInfoBlock()
        buyerInfoBlock.layer.cornerRadius = constants.commonCornerRadius
        buyerInfoBlock.backgroundColor = .white
        buyerInfoBlock.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 232)
        scrollView.addSubview(buyerInfoBlock)
        
        // MARK: - Настройка touristInfoBlock
        touristInfoBlock = TouristInfoBlock()
        touristInfoBlock.layer.cornerRadius = constants.commonCornerRadius
        touristInfoBlock.backgroundColor = .white
        touristInfoBlock.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 430)
        touristInfoBlock.delegate = self
        scrollView.addSubview(touristInfoBlock)
        
        // MARK: - Настройка bottomButton
        buttonBackgroundView.backgroundColor = .white
        view.addSubview(buttonBackgroundView)
        
        button.addAction {
            if self.touristInfoBlock.validateTouristInfo() && self.buyerInfoBlock.validateBuyerInfo() {
                let confirmVC = ConfirmationViewController()
                confirmVC.title = "Заказ оплачен"
                self.navigationController?.pushViewController(confirmVC, animated: true)
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста, заполните все поля о покупателе и о туристе", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        buttonBackgroundView.addSubview(button)
    }
}

extension BookingViewController: BookingViewModelDelegate {
    func bookingDataDidUpdate() {
        print(#function)
        
        if let ratingScore = viewModel.bookingModel?.horating,
            let ratingName = viewModel.bookingModel?.ratingName,
           let name = viewModel.bookingModel?.hotelName,
           let address = viewModel.bookingModel?.hotelAdress {
            hotelBlock.setHotelBlockDataFor(ratingValue: "\(ratingScore) \(ratingName)",
                                            hotelNameText: name,
                                            hotelAddressText: address)
        }
        
        
        if let departureInfo = viewModel.bookingModel?.departure,
           let arrivalCountry = viewModel.bookingModel?.arrivalCountry,
           let tourDateStart = viewModel.bookingModel?.tourDateStart,
           let numberOfNights = viewModel.bookingModel?.numberOfNights,
           let hotelName = viewModel.bookingModel?.hotelName,
           let room = viewModel.bookingModel?.room,
           let nutrition = viewModel.bookingModel?.nutrition
        {
            travelInfoBlock.setTravelInfo(departureCity: departureInfo,
                                          arrivalCity: arrivalCountry,
                                          date: tourDateStart,
                                          nights: "\(numberOfNights) ночей",
                                          hotel: hotelName,
                                          room: room,
                                          food: nutrition)
        }
        
        if let tourPrice = viewModel.bookingModel?.tourPrice,
           let fuelCharge = viewModel.bookingModel?.fuelCharge,
           let serviceCharge = viewModel.bookingModel?.serviceCharge {
            let toPaySum = serviceCharge + fuelCharge + tourPrice
            priceBlock.setPriceDataFor(tour: "\(toPaySum.formattedWithSeparator()) ₽",
                                       fuel: "\(fuelCharge.formattedWithSeparator()) ₽",
                                       service: "\(serviceCharge.formattedWithSeparator()) ₽",
                                       toPay: "\(toPaySum.formattedWithSeparator()) ₽")
            button.setTitle("Оплатить \(toPaySum.formattedWithSeparator()) ₽", for: .normal)
        }
        
        hotelBlock.setNeedsLayout()
        hotelBlock.layoutIfNeeded()
        travelInfoBlock.setNeedsLayout()
        travelInfoBlock.layoutIfNeeded()
        
        priceBlock.setNeedsLayout()
        priceBlock.layoutIfNeeded()
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}


// MARK: - keyboard setup
extension BookingViewController {
    func hideKeyboardOnTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}

// MARK: - setupLayout
extension BookingViewController {
    private func setupBookingLayout() {
        travelInfoBlock.frame.origin.y = hotelBlock.frame.maxY + constants.commonPadding
        buyerInfoBlock.frame.origin.y = travelInfoBlock.frame.maxY + constants.commonPadding
        touristInfoBlock.frame.origin.y = buyerInfoBlock.frame.maxY + constants.commonPadding
        priceBlock.frame.origin.y = touristInfoBlock.frame.maxY + constants.commonPadding
        
        let buttonBackgroundHeight: CGFloat = 88
        buttonBackgroundView.frame = CGRect(x: 0, y: view.frame.maxY - buttonBackgroundHeight, width: view.frame.width, height: buttonBackgroundHeight)
        button.frame = CGRect(x: (view.frame.width - constants.commonWidth) / 2, y: (buttonBackgroundView.frame.height - constants.buttonHeight - constants.commonPadding) / 2, width: constants.commonWidth, height: constants.buttonHeight)
    }
    func updatePriceBlockPosition(isTouristInfoCollapsed: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.priceBlock.frame.origin.y = isTouristInfoCollapsed ? self.touristInfoBlock.frame.maxY + self.constants.commonPadding : self.touristInfoBlock.frame.maxY + self.constants.commonPadding
        }
    }
}

extension BookingViewController: TouristInfoBlockProtocol {
    func collapseButtonWasTapped(isCollapsed: Bool) {
        updatePriceBlockPosition(isTouristInfoCollapsed: isCollapsed)
        
    }
}
