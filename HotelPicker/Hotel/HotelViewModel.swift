//
//  HotelViewModel.swift
//  HotelPicker
//
//  Created by ily.pavlov on 19.12.2023.
//

import Foundation

// Протокол для делегирования событий ViewModel
protocol HotelViewModelDelegate: AnyObject {
    func hotelDataDidUpdate()
}


class HotelViewModel {
    private let networkManager = NetworkManager.shared
    
    // Свойство для делегата, который будет уведомлен о событиях ViewModel
    weak var delegate: HotelViewModelDelegate?

    private(set) var hotelModel: HotelModel? {
        didSet {
            delegate?.hotelDataDidUpdate()
        }
    }
    
    // Метод для получения данных из сети и обновления модели
    func fetchHotelData() {
        networkManager.fetchHotelData { [weak self] result in
            switch result {
            case .success(let hotel):
                self?.hotelModel = hotel
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

