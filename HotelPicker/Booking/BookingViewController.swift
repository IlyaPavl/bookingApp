//
//  BookingViewController.swift
//  HotelPicker
//
//  Created by ily.pavlov on 19.12.2023.
//

import UIKit

final class BookingViewController: UIViewController {
    private let leftPadding: CGFloat = 16
    private let paddingForOrder: CGFloat = 156
    private let paddingForCost: CGFloat = 227
    
    // MARK: - UI elements
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
    private let buyerInfoLabel = UILabel()
    private let phoneField = CommonTextField(placeholder: "+7 (***) ***-**-**", keyboardType: .numberPad, fieldType: .phoneNumber)
    private let emailField = CommonTextField(placeholder: "yourmail@email.com", keyboardType: .emailAddress, fieldType: .email)
    private let disclaimerLabel = UILabel()
    
    private let paddings: CGFloat = 8
    private let whiteBackDataInfo = UIView()
    private let firstTouristLabel = UILabel()
    private let nameTouristField = CommonTextField(placeholder: "Имя", keyboardType: .default, fieldType: .commonText)
    private let surnameTouristField = CommonTextField(placeholder: "Фамилия", keyboardType: .default, fieldType: .commonText)
    private let dateOfBirthField = CommonTextField(placeholder: "Дата рождения", keyboardType: .default, fieldType: .dateOfBirth)
    private let countryField = CommonTextField(placeholder: "Гражданство", keyboardType: .default, fieldType: .commonText)
    private let passportNumberField = CommonTextField(placeholder: "Номер загранпаспорта", keyboardType: .default, fieldType: .commonText)
    private let passportDateField = CommonTextField(placeholder: "Срок действия загранпаспорта", keyboardType: .default, fieldType: .dateOfBirth)
    private let hideShowButton = UIButton()
    private var isDataInfoCollapsed = false
    private var textFields: [UITextField] = []
    
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
    
    // MARK: - viewDidLoad
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
        setupLayout()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        
        // MARK: - Настройка scrollView
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        // MARK: - Настройка whiteBackHotelInfo
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
        
        // MARK: - Настройка hotelNameLabel
        hotelNameLabel.numberOfLines = 0
        hotelNameLabel.font = UIFont(name: constants.MediumFont, size: 22)
        whiteBackHotelInfo.addSubview(hotelNameLabel)
        
        // MARK: - Настройка hotelAddressLabel
        hotelAddressLabel.numberOfLines = 0
        hotelAddressLabel.font = UIFont(name: constants.MediumFont, size: 14)
        hotelAddressLabel.textColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
        whiteBackHotelInfo.addSubview(hotelAddressLabel)
        
        // MARK: - Настройка whiteBackOrderInfo
        whiteBackOrderInfo.backgroundColor = .white
        whiteBackOrderInfo.layer.cornerRadius = 12
        scrollView.addSubview(whiteBackOrderInfo)
        
        // MARK: - Настройка departureCityLabel
        departureCityLabel.text = "Вылет из"
        departureCityLabel.font = UIFont(name: constants.RegularFont, size: 16)
        departureCityLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackOrderInfo.addSubview(departureCityLabel)
        
        // MARK: - Настройка arrivalCityLabel
        arrivalCityLabel.text = "Страна, город"
        arrivalCityLabel.font = UIFont(name: constants.RegularFont, size: 16)
        arrivalCityLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackOrderInfo.addSubview(arrivalCityLabel)
        
        // MARK: - Настройка dateLabel
        dateLabel.text = "Даты"
        dateLabel.font = UIFont(name: constants.RegularFont, size: 16)
        dateLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackOrderInfo.addSubview(dateLabel)
        
        // MARK: - Настройка nightsLabel
        nightsLabel.text = "Кол-во ночей"
        nightsLabel.font = UIFont(name: constants.RegularFont, size: 16)
        nightsLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackOrderInfo.addSubview(nightsLabel)
        
        // MARK: - Настройка hotelLabel
        hotelLabel.text = "Отель"
        hotelLabel.font = UIFont(name: constants.RegularFont, size: 16)
        hotelLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackOrderInfo.addSubview(hotelLabel)
        
        // MARK: - Настройка roomLabel
        roomLabel.text = "Номер"
        roomLabel.font = UIFont(name: constants.RegularFont, size: 16)
        roomLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackOrderInfo.addSubview(roomLabel)
        
        // MARK: - Настройка foodLabel
        foodLabel.text = "Питание"
        foodLabel.font = UIFont(name: constants.RegularFont, size: 16)
        foodLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackOrderInfo.addSubview(foodLabel)
        
        // MARK: - Настройка departureCityInfo
        departureCityInfo.numberOfLines = 0
        departureCityInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackOrderInfo.addSubview(departureCityInfo)
        
        // MARK: - Настройка arrivalCityInfo
        arrivalCityInfo.numberOfLines = 0
        arrivalCityInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackOrderInfo.addSubview(arrivalCityInfo)
        
        // MARK: - Настройка dateInfo
        dateInfo.numberOfLines = 0
        dateInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackOrderInfo.addSubview(dateInfo)
        
        // MARK: - Настройка nightsInfo
        nightsInfo.numberOfLines = 0
        nightsInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackOrderInfo.addSubview(nightsInfo)
        
        // MARK: - Настройка hotelInfo
        hotelInfo.numberOfLines = 0
        hotelInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackOrderInfo.addSubview(hotelInfo)
        
        // MARK: - Настройка roomInfo
        roomInfo.numberOfLines = 0
        roomInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackOrderInfo.addSubview(roomInfo)
        
        // MARK: - Настройка foodInfo
        foodInfo.numberOfLines = 0
        foodInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackOrderInfo.addSubview(foodInfo)
        
        // MARK: - Настройка whiteBackBuyerInfo
        whiteBackBuyerInfo.backgroundColor = .white
        whiteBackBuyerInfo.layer.cornerRadius = 12
        scrollView.addSubview(whiteBackBuyerInfo)
        
        // MARK: - Настройка buyerInfoLabel
        buyerInfoLabel.text = "Информация о покупателе"
        buyerInfoLabel.font = UIFont(name: constants.MediumFont, size: 22)
        whiteBackBuyerInfo.addSubview(buyerInfoLabel)
        
        // MARK: - Настройка phoneField и emailField
        whiteBackBuyerInfo.addSubview(phoneField)
        whiteBackBuyerInfo.addSubview(emailField)
        
        // MARK: - Настройка disclaimerLabel
        disclaimerLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        disclaimerLabel.font = UIFont(name: constants.RegularFont, size: 14)
        disclaimerLabel.numberOfLines = 0
        disclaimerLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        disclaimerLabel.attributedText = NSMutableAttributedString(
            string: "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        whiteBackBuyerInfo.addSubview(disclaimerLabel)
        
        
        // MARK: - Настройка whiteBackDataInfo
        whiteBackDataInfo.backgroundColor = .white
        whiteBackDataInfo.layer.cornerRadius = 12
        scrollView.addSubview(whiteBackDataInfo)
        
        // MARK: - Настройка firstTouristLabel
        firstTouristLabel.text = "Первый турист"
        firstTouristLabel.font = UIFont(name: constants.MediumFont, size: 22)
        whiteBackDataInfo.addSubview(firstTouristLabel)
        
        whiteBackDataInfo.addSubview(nameTouristField)
        whiteBackDataInfo.addSubview(surnameTouristField)
        whiteBackDataInfo.addSubview(dateOfBirthField)
        whiteBackDataInfo.addSubview(countryField)
        whiteBackDataInfo.addSubview(passportNumberField)
        whiteBackDataInfo.addSubview(passportDateField)
        
        hideShowButton.backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 0.1)
        hideShowButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        hideShowButton.layer.cornerRadius = 6
        hideShowButton.addTarget(self, action: #selector(toggleDataInfo), for: .touchUpInside)
        whiteBackDataInfo.addSubview(hideShowButton)
        
        // MARK: - Настройка whiteBackMoneyInfo
        whiteBackMoneyInfo.backgroundColor = .white
        whiteBackMoneyInfo.layer.cornerRadius = 12
        scrollView.addSubview(whiteBackMoneyInfo)
        
        // MARK: - Настройка tourLabel
        tourLabel.text = "Тур"
        tourLabel.font = UIFont(name: constants.RegularFont, size: 16)
        tourLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackMoneyInfo.addSubview(tourLabel)
        
        // MARK: - Настройка tourInfo
        tourInfo.numberOfLines = 0
        tourInfo.textAlignment = .right
        tourInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackMoneyInfo.addSubview(tourInfo)
        
        // MARK: - Настройка fuelLabel
        fuelLabel.text = "Топливный сбор"
        fuelLabel.font = UIFont(name: constants.RegularFont, size: 16)
        fuelLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackMoneyInfo.addSubview(fuelLabel)
        
        // MARK: - Настройка fuelInfo
        fuelInfo.numberOfLines = 0
        fuelInfo.textAlignment = .right
        fuelInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackMoneyInfo.addSubview(fuelInfo)
        
        // MARK: - Настройка serviceLabel
        serviceLabel.text = "Сервисный сбор"
        serviceLabel.font = UIFont(name: constants.RegularFont, size: 16)
        serviceLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackMoneyInfo.addSubview(serviceLabel)
        
        // MARK: - Настройка serviceInfo
        serviceInfo.numberOfLines = 0
        serviceInfo.textAlignment = .right
        serviceInfo.font = UIFont(name: constants.RegularFont, size: 16)
        whiteBackMoneyInfo.addSubview(serviceInfo)
        
        // MARK: - Настройка toPayLabel
        toPayLabel.text = "К оплате"
        toPayLabel.font = UIFont(name: constants.RegularFont, size: 16)
        toPayLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        whiteBackMoneyInfo.addSubview(toPayLabel)
        
        // MARK: - Настройка toPayInfo
        toPayInfo.numberOfLines = 0
        toPayInfo.textAlignment = .right
        toPayInfo.textColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
        toPayInfo.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        whiteBackMoneyInfo.addSubview(toPayInfo)
        
        textFields = [nameTouristField, surnameTouristField, dateOfBirthField, countryField, passportNumberField, passportDateField]
        
        
        // MARK: - Настройка bottomButton
        buttonBackgroundView.backgroundColor = .white
        view.addSubview(buttonBackgroundView)
        
        button.addAction {
            if self.phoneField.text?.isEmpty ?? true || self.emailField.text?.isEmpty ?? true {
                self.phoneField.backgroundColor = UIColor(red: 1, green: 0.8471, blue: 0.8471, alpha: 1.0)
                self.emailField.backgroundColor = UIColor(red: 1, green: 0.8471, blue: 0.8471, alpha: 1.0)
            } else {
                self.phoneField.backgroundColor = UIColor(red: 0.9647, green: 0.9647, blue: 0.9765, alpha: 1.0)
                let confirmVC = ConfirmationViewController()
                confirmVC.title = "Заказ оплачен"
                self.navigationController?.pushViewController(confirmVC, animated: true)
            }
        }
        buttonBackgroundView.addSubview(button)
    }
    
    @objc private func toggleDataInfo() {
        isDataInfoCollapsed.toggle()
        updateDataInfoLayout()
    }
    
    private func updateDataInfoLayout() {
        UIView.animate(withDuration: 0.3) {
            self.textFields.forEach { $0.isHidden = self.isDataInfoCollapsed }
            self.setupLayout()
        }
    }
    
    // MARK: - Вычисление высоты white контейнеров
    private func calculateWhiteBackHotelInfoHeight() -> CGFloat {
        return yellowView.frame.height + hotelNameLabel.frame.height + hotelAddressLabel.frame.height + 56
    }
    
    private func calculateWhiteBackOrderInfoHeight() -> CGFloat {
        return departureCityInfo.frame.height + arrivalCityInfo.frame.height + dateInfo.frame.height + nightsInfo.frame.height + hotelInfo.frame.height + roomInfo.frame.height + foodInfo.frame.height + 16 * 8
    }
    
    private func calculateWhiteBackMoneyInfoHeight() -> CGFloat {
        return tourInfo.frame.height + fuelInfo.frame.height + serviceInfo.frame.height + toPayInfo.frame.height + 16 * 5
    }
    
    private func calculateWhiteBackBuyerInfoHeight() -> CGFloat {
        return buyerInfoLabel.frame.height + phoneField.frame.height + emailField.frame.height + disclaimerLabel.frame.height + 16 * 4
    }
    
    func calculatewhiteBackDataInfoHeight() -> CGFloat {
        return nameTouristField.frame.height + surnameTouristField.frame.height + dateOfBirthField.frame.height + countryField.frame.height + passportNumberField.frame.height + passportDateField.frame.height + 16 * 7
        
    }
}


// MARK: - BookingViewModelDelegate
extension BookingViewController: BookingViewModelDelegate {
    
    func bookingDataDidUpdate() {
        
        if let ratingScore = viewModel.bookingModel?.horating, let ratingName = viewModel.bookingModel?.ratingName {
            ratingValueLabel.text = "\(ratingScore) \(ratingName)"
        }
        
        if let name = viewModel.bookingModel?.hotelName {
            hotelNameLabel.text = name
        }
        if let address = viewModel.bookingModel?.hotelAdress {
            hotelAddressLabel.text = address
        }
        
        if let departureInfo = viewModel.bookingModel?.departure {
            departureCityInfo.text = departureInfo
        }
        
        if let arrivalCountry = viewModel.bookingModel?.arrivalCountry {
            arrivalCityInfo.text = arrivalCountry
        }
        
        if let tourDateStart = viewModel.bookingModel?.tourDateStart {
            dateInfo.text = tourDateStart
        }
        
        if let numberOfNights = viewModel.bookingModel?.numberOfNights {
            nightsInfo.text = "\(numberOfNights) ночей"
        }
        
        if let hotelName = viewModel.bookingModel?.hotelName {
            hotelInfo.text = hotelName
        }
        
        if let room = viewModel.bookingModel?.room {
            roomInfo.text = room
        }
        
        if let nutrition = viewModel.bookingModel?.nutrition {
            foodInfo.text = nutrition
        }
        
        if let tourPrice = viewModel.bookingModel?.tourPrice {
            tourInfo.text = "\(tourPrice.formattedWithSeparator()) ₽"
        }
        
        if let fuelCharge = viewModel.bookingModel?.fuelCharge {
            fuelInfo.text = "\(fuelCharge.formattedWithSeparator()) ₽"
        }
        
        if let serviceCharge = viewModel.bookingModel?.serviceCharge {
            serviceInfo.text = "\(serviceCharge.formattedWithSeparator()) ₽"
        }
        
        if let serviceCharge = viewModel.bookingModel?.serviceCharge,
           let fuelCharge = viewModel.bookingModel?.fuelCharge,
           let tourPrice = viewModel.bookingModel?.tourPrice {
            let toPaySum = serviceCharge + fuelCharge + tourPrice
            toPayInfo.text = "\(toPaySum.formattedWithSeparator()) ₽"
            button.setTitle("Оплатить \(toPaySum.formattedWithSeparator()) ₽", for: .normal)
        }
        
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}

// MARK: - setupUI

extension BookingViewController {
    
}

// MARK: - setupLayout
extension BookingViewController {
    private func setupLayout() {
        whiteBackHotelInfo.frame = CGRect(x: 0, y: 8, width: scrollView.frame.width, height: 150)
        let ratingValueLabelSize = ratingValueLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        yellowView.frame = CGRect(x: leftPadding, y: whiteBackHotelInfo.frame.minY + 16, width: 0, height: 29)
        ratingValueLabel.frame = CGRect(x: 30, y: 0, width: ratingValueLabelSize.width, height: ratingValueLabelSize.height)
        starImage.frame = CGRect(x: 10, y: 0, width: 15, height: 15)
        starImage.center = CGPoint(x: 10 + starImage.frame.width / 2, y: yellowView.frame.height / 2)
        yellowView.frame.size.width = ratingValueLabel.frame.width + starImage.frame.width + 20 + 2
        ratingValueLabel.center = CGPoint(x: (yellowView.frame.width + 2 + starImage.frame.width) / 2, y: yellowView.frame.height / 2)
        
        let hotelNameLabelSize = hotelNameLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        hotelNameLabel.frame = CGRect(x: leftPadding, y: yellowView.frame.maxY + 8, width: hotelNameLabelSize.width, height: hotelNameLabelSize.height)
        let hotelAddressLabelSize = hotelAddressLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        hotelAddressLabel.frame = CGRect(x: leftPadding, y: hotelNameLabel.frame.maxY + 8, width: hotelAddressLabelSize.width, height: hotelAddressLabelSize.height)
        whiteBackHotelInfo.frame.size.height = calculateWhiteBackHotelInfoHeight()
        
        
        whiteBackOrderInfo.frame = CGRect(x: 0, y: whiteBackHotelInfo.frame.maxY + 8, width: scrollView.frame.width, height: 400)
        let departureCityLabelSize = departureCityLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        departureCityLabel.frame = CGRect(x: leftPadding, y: 16, width: departureCityLabelSize.width, height: departureCityLabelSize.height)
        
        departureCityInfo.frame = CGRect(x: whiteBackOrderInfo.frame.minX + paddingForOrder, y: 16, width: 203, height: 19)
        
        let arrivalCityLabelSize = arrivalCityLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        arrivalCityLabel.frame = CGRect(x: leftPadding, y: departureCityLabel.frame.maxY + 16, width: arrivalCityLabelSize.width, height: arrivalCityLabelSize.height)
        
        arrivalCityInfo.frame = CGRect(x: whiteBackOrderInfo.frame.minX + paddingForOrder, y: departureCityInfo.frame.maxY + 16, width: 203, height: 19)
        
        let dateLabelSize = dateLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        dateLabel.frame = CGRect(x: leftPadding, y: arrivalCityLabel.frame.maxY + 16, width: dateLabelSize.width, height: dateLabelSize.height)
        
        dateInfo.frame = CGRect(x: whiteBackOrderInfo.frame.minX + paddingForOrder, y: arrivalCityInfo.frame.maxY + 16, width: 203, height: 19)
        
        let nightsLabelSize = nightsLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        nightsLabel.frame = CGRect(x: leftPadding, y: dateLabel.frame.maxY + 16, width: nightsLabelSize.width, height: nightsLabelSize.height)
        
        nightsInfo.frame = CGRect(x: whiteBackOrderInfo.frame.minX + paddingForOrder, y: dateInfo.frame.maxY + 16, width: 203, height: 19)
        
        let hotelLabelSize = hotelLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        hotelLabel.frame = CGRect(x: leftPadding, y: nightsLabel.frame.maxY + 16, width: hotelLabelSize.width, height: hotelLabelSize.height)
        
        hotelInfo.frame = CGRect(x: whiteBackOrderInfo.frame.minX + paddingForOrder, y: nightsInfo.frame.maxY + 16, width: 203, height: 40)
        
        let roomLabelSize = roomLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        roomLabel.frame = CGRect(x: leftPadding, y: hotelInfo.frame.maxY + 16, width: roomLabelSize.width, height: roomLabelSize.height)
        
        roomInfo.frame = CGRect(x: whiteBackOrderInfo.frame.minX + paddingForOrder, y: hotelInfo.frame.maxY + 16, width: 203, height: 40)
        
        let foodLabelSize = foodLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        foodLabel.frame = CGRect(x: leftPadding, y: roomInfo.frame.maxY + 16, width: foodLabelSize.width, height: foodLabelSize.height)
        
        let foodInfoSize = foodInfo.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        foodInfo.frame = CGRect(x: whiteBackOrderInfo.frame.minX + paddingForOrder, y: roomInfo.frame.maxY + 16, width: 203, height: foodInfoSize.height)
        whiteBackOrderInfo.frame.size.height = calculateWhiteBackOrderInfoHeight()
        
        whiteBackBuyerInfo.frame = CGRect(x: 0, y: whiteBackOrderInfo.frame.maxY + 8, width: scrollView.frame.width, height: 400)
        let buyerInfoLabelSize = buyerInfoLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        buyerInfoLabel.frame = CGRect(x: leftPadding, y: leftPadding, width: buyerInfoLabelSize.width, height: buyerInfoLabelSize.height)
        phoneField.frame = CGRect(x: leftPadding, y: buyerInfoLabel.frame.maxY + 20, width: whiteBackBuyerInfo.frame.width - 32, height: 52)
        emailField.frame = CGRect(x: leftPadding, y: phoneField.frame.maxY + 8, width: whiteBackBuyerInfo.frame.width - 32, height: 52)
        disclaimerLabel.frame = CGRect(x: leftPadding, y: emailField.frame.maxY + 8, width: 343, height: 34)
        whiteBackBuyerInfo.frame.size.height = calculateWhiteBackBuyerInfoHeight()
        
        whiteBackDataInfo.frame = CGRect(x: 0, y: whiteBackBuyerInfo.frame.maxY + 8, width: scrollView.frame.width, height: 400)
        let firstTouristLabelSize = buyerInfoLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        firstTouristLabel.frame = CGRect(x: leftPadding, y: leftPadding, width: firstTouristLabelSize.width, height: firstTouristLabelSize.height)
        nameTouristField.frame = CGRect(x: 16, y: firstTouristLabel.frame.maxY + 20, width: whiteBackDataInfo.frame.width - 32, height: 52)
        surnameTouristField.frame = CGRect(x: 16, y: nameTouristField.frame.maxY + paddings, width: whiteBackDataInfo.frame.width - 32, height: 52)
        dateOfBirthField.frame = CGRect(x: 16, y: surnameTouristField.frame.maxY + paddings, width: whiteBackDataInfo.frame.width - 32, height: 52)
        countryField.frame = CGRect(x: 16, y: dateOfBirthField.frame.maxY + paddings, width: whiteBackDataInfo.frame.width - 32, height: 52)
        passportNumberField.frame = CGRect(x: 16, y: countryField.frame.maxY + paddings, width: whiteBackDataInfo.frame.width - 32, height: 52)
        passportDateField.frame = CGRect(x: 16, y: passportNumberField.frame.maxY + paddings, width: whiteBackDataInfo.frame.width - 32, height: 52)
        hideShowButton.frame = CGRect(x: whiteBackDataInfo.frame.width - 48, y: 13, width: 32, height: 32)
        
        whiteBackDataInfo.frame.size.height = isDataInfoCollapsed ? firstTouristLabelSize.height + 32 : calculatewhiteBackDataInfoHeight()
        
        
        whiteBackMoneyInfo.frame = CGRect(x: 0, y: whiteBackDataInfo.frame.maxY + 8, width: scrollView.frame.width, height: 400)
        let tourLabelSize = tourLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        tourLabel.frame = CGRect(x: leftPadding, y: 16, width: tourLabelSize.width, height: tourLabelSize.height)
        
        let tourInfoSize = tourInfo.sizeThatFits(CGSize(width: 132, height: CGFloat.greatestFiniteMagnitude))
        tourInfo.frame = CGRect(x: whiteBackMoneyInfo.frame.minX + paddingForCost, y: 16, width: 132, height: tourInfoSize.height)
        
        let fuelLabelSize = fuelLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        fuelLabel.frame = CGRect(x: leftPadding, y: tourLabel.frame.maxY + 16, width: fuelLabelSize.width, height: fuelLabelSize.height)
        
        let fuelInfoSize = fuelInfo.sizeThatFits(CGSize(width: 132, height: CGFloat.greatestFiniteMagnitude))
        fuelInfo.frame = CGRect(x: whiteBackMoneyInfo.frame.minX + paddingForCost, y: tourInfo.frame.maxY + 16, width: 132, height: fuelInfoSize.height)
        
        let serviceLabelSize = serviceLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        serviceLabel.frame = CGRect(x: leftPadding, y: fuelLabel.frame.maxY + 16, width: serviceLabelSize.width, height: serviceLabelSize.height)
        
        let serviceInfoSize = serviceInfo.sizeThatFits(CGSize(width: 132, height: CGFloat.greatestFiniteMagnitude))
        serviceInfo.frame = CGRect(x: whiteBackMoneyInfo.frame.minX + paddingForCost, y: fuelInfo.frame.maxY + 16, width: 132, height: serviceInfoSize.height)
        
        let toPayLabelSize = toPayLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        toPayLabel.frame = CGRect(x: leftPadding, y: serviceLabel.frame.maxY + 16, width: toPayLabelSize.width, height: toPayLabelSize.height)
        
        let toPayInfoSize = toPayInfo.sizeThatFits(CGSize(width: 132, height: CGFloat.greatestFiniteMagnitude))
        toPayInfo.frame = CGRect(x: whiteBackMoneyInfo.frame.minX + paddingForCost, y: serviceInfo.frame.maxY + 16, width: 132, height: toPayInfoSize.height)
        whiteBackMoneyInfo.frame = CGRect(x: 0, y: isDataInfoCollapsed ? whiteBackDataInfo.frame.maxY + 8 : whiteBackDataInfo.frame.maxY + 8, width: scrollView.frame.width, height: calculateWhiteBackMoneyInfoHeight())
        
        buttonBackgroundView.frame = CGRect(x: 0, y: view.frame.maxY - 88, width: view.frame.width, height: 88)
        button.frame = CGRect(x: 0, y: 0, width: 343, height: 48)
        button.center = CGPoint(x: buttonBackgroundView.bounds.midX, y: buttonBackgroundView.bounds.midY - 7)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: whiteBackHotelInfo.frame.height + whiteBackOrderInfo.frame.height + whiteBackMoneyInfo.frame.height + whiteBackBuyerInfo.frame.height + whiteBackDataInfo.frame.height + buttonBackgroundView.frame.height + 8)

    }
}
