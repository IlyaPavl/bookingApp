//
//  NetworkManager.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import UIKit

class NetworkManager: NetworkServiceProtocol {
    
    static let shared = NetworkManager()
    private init() {}
    
    private func getData<T: Decodable>(from url: URL, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.noData))
                return
            }
            DispatchQueue.main.async {
                do {
                    let decodedData = try JSONDecoder().decode(modelType, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(APIError.decodingError))
                }
            }
        }.resume()
    }
    
    func fetchData<T: Decodable>(for type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url.absoluteString) else {
            completion(.failure(APIError.wrongURL))
            return
        }
        getData(from: url, modelType: type, completion: completion)
    }
    
    func fetchHotelData(completion: @escaping (Result<HotelModel, Error>) -> Void) {
        fetchData(for: HotelModel.self, from: URL(string: APIUrl.hotelURL)!, completion: completion)
    }
    
    func fetchRoomData(completion: @escaping (Result<RoomsModel, Error>) -> Void) {
        fetchData(for: RoomsModel.self, from: URL(string: APIUrl.roomURL)!, completion: completion)
        
    }
    
    func fetchBookingData(completion: @escaping (Result<BookingModel, Error>) -> Void) {
        fetchData(for: BookingModel.self, from: URL(string: APIUrl.bookingURL)!, completion: completion)
    }
    
    func loadHotelImages(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let imageUrl = URL(string: url) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.noData))
                    return
                }
                
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(APIError.decodingError))
                }
            }.resume()
        } else {
            completion(.failure(APIError.wrongURL))
        }
    }
    
    func loadRoomImages(from urls: [String], completion: @escaping (Result<[UIImage], Error>) -> Void) {
        var loadedImages = [UIImage]()
        let group = DispatchGroup()
        
        for urlString in urls {
            group.enter()
            
            if let imageUrl = URL(string: urlString) {
                URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                    defer {
                        group.leave()
                    }
                    
                    if let data = data, let image = UIImage(data: data) {
                        loadedImages.append(image)
                    } else if let error = error {
                        completion(.failure(error))
                    }
                }.resume()
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(.success(loadedImages))
        }
    }
}
