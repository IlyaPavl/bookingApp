//
//  HotelViewModel.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import UIKit

protocol HotelViewModelDelegate: AnyObject {
    func hotelDataDidUpdate()
}

class HotelViewModel {
    private let networkManager = NetworkManager.shared
    weak var delegate: HotelViewModelDelegate?
    
    private(set) var hotelModel: HotelModel? {
        didSet {
            delegate?.hotelDataDidUpdate()
        }
    }
    
    func fetchHotelData() {
        print(#function)
        networkManager.fetchHotelData { [weak self] result in
            switch result {
            case .success(let hotel):
                self?.hotelModel = hotel
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchImage(from url: String, completion: @escaping (UIImage) -> ()) {
        print(#function)
        networkManager.loadHotelImages(from: url) { result in
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
