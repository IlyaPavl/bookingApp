//
//  BookingViewModel.swift
//  HotelPicker
//
//  Created by ily.pavlov on 19.12.2023.
//

import Foundation

protocol BookingViewModelDelegate: AnyObject {
    func bookingDataDidUpdate()
}


class BookingViewModel {
    private let networkManager = NetworkManager.shared
    
    weak var delegate: BookingViewModelDelegate?

    private(set) var bookingModel: BookingModel? {
        didSet {
            delegate?.bookingDataDidUpdate()
        }
    }
    
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
