//
//  NetworkServiceProtocol.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchHotelData(completion: @escaping (Result<HotelModel, Error>) -> Void)
    func fetchRoomData(completion: @escaping (Result<RoomsModel, Error>) -> Void)
    func fetchBookingData(completion: @escaping (Result<BookingModel, Error>) -> Void)
}
