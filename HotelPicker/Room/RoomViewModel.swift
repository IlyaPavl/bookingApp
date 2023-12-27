//
//  RoomViewModel.swift
//  HotelPicker
//
//  Created by ily.pavlov on 19.12.2023.
//

import Foundation

protocol RoomViewModelDelegate: AnyObject {
    func roomDataDidUpdate()
}

class RoomViewModel {
    private let networkManager = NetworkManager.shared
    
    weak var delegate: RoomViewModelDelegate?

    private(set) var roomModel: RoomsModel? {
        didSet {
            delegate?.roomDataDidUpdate()
        }
    }
    
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
