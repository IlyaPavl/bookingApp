//
//  NetworkManager.swift
//  HotelPicker
//
//  Created by ily.pavlov on 17.12.2023.
//

import UIKit

class NetworkManager: NetworkServiceProtocol {
    static let shared = NetworkManager()
    private init() {}

    private func fetchData<T: Decodable>(from url: URL, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Data error", code: 1, userInfo: nil)))
                return
            }

            DispatchQueue.main.async {
                do {
                    let decodedData = try JSONDecoder().decode(modelType, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func fetchData<T: Decodable>(for type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url.absoluteString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        fetchData(from: url, modelType: type, completion: completion)
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
                    completion(.failure(error ?? NSError(domain: "Image Data Error", code: 1, userInfo: nil)))
                    return
                }
                
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NSError(domain: "Image Decoding Error", code: 2, userInfo: nil)))
                }
            }.resume()
        } else {
            completion(.failure(NSError(domain: "Invalid Image URL", code: 0, userInfo: nil)))
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
            // Все изображения загружены, вызываем completion
            completion(.success(loadedImages))
        }
    }
}
