//
//  NetworkManager.swift
//  HotelPicker
//
//  Created by ily.pavlov on 17.12.2023.
//

import Foundation

class NetworkManager: NetworkServiceProtocol {
    static let shared = NetworkManager()
    private init() {}

    func fetchHotelData(completion: @escaping (Result<HotelModel, Error>) -> Void) {
        guard let url = URL(string: APIUrl.hotelURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Data error", code: 1, userInfo: nil)))
                return
            }
            DispatchQueue.main.async {
                do {
                    let hotel = try JSONDecoder().decode(HotelModel.self, from: data)
                    completion(.success(hotel))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchRoomData(completion: @escaping (Result<RoomsModel, Error>) -> Void) {
        guard let url = URL(string: APIUrl.roomURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Data error", code: 1, userInfo: nil)))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let room = try JSONDecoder().decode(RoomsModel.self, from: data)
                    completion(.success(room))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchBookingData(completion: @escaping (Result<BookingModel, Error>) -> Void) {
        guard let url = URL(string: APIUrl.roomURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Data error", code: 1, userInfo: nil)))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let booking = try JSONDecoder().decode(BookingModel.self, from: data)
                    completion(.success(booking))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
