//
//  BookingViewModel.swift
//  HotelPicker
//
//  Created by ily.pavlov on 19.12.2023.
//

import Foundation

// Протокол для делегирования событий ViewModel
protocol BookingViewModelDelegate: AnyObject {
    func bookingDataDidUpdate()
}


class BookingViewModel {
    private let networkManager = NetworkManager.shared
    
    // Свойство для делегата, который будет уведомлен о событиях ViewModel
    weak var delegate: BookingViewModelDelegate?

    private(set) var bookingModel: BookingModel? {
        didSet {
            delegate?.bookingDataDidUpdate()
        }
    }
    
    // Метод для получения данных из сети и обновления модели
    func fetchBookingData() {
        networkManager.fetchBookingData { [weak self] result in
            switch result {
            case .success(let booking):
                self?.bookingModel = booking
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
