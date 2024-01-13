//
//  RoomViewModel.swift
//  Hotel
//
//  Created by ily.pavlov on 10.01.2024.
//

import UIKit

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
    
    func fetchImage(from url: [String], completion: @escaping ([UIImage]) -> ()) {
        print(#function)
        networkManager.loadRoomImages(from: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let error):
                print("Ошибка загрузки изображения отеля: \(error.localizedDescription)")
            }
        }
    }
}
