//
//  RoomViewModel.swift
//  HotelPicker
//
//  Created by ily.pavlov on 19.12.2023.
//

import Foundation

// Протокол для делегирования событий ViewModel
protocol RoomViewModelDelegate: AnyObject {
    func roomDataDidUpdate()
}

class RoomViewModel {
    private let networkManager = NetworkManager.shared
    
    // Свойство для делегата, который будет уведомлен о событиях ViewModel
    weak var delegate: RoomViewModelDelegate?
    
    // Модель отеля, которую будет использовать представление
    private(set) var roomModel: RoomsModel? {
        didSet {
            delegate?.roomDataDidUpdate()
        }
    }
    
    // Метод для получения данных из сети и обновления модели
    func fetchRoomData() {
        networkManager.fetchRoomData { [weak self] result in
            switch result {
            case .success(let room):
                self?.roomModel = room
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
