//
//  NetworkServiceProtocol.swift
//  HotelPicker
//
//  Created by ily.pavlov on 18.12.2023.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchHotelData(completion: @escaping (Result<HotelModel, Error>) -> Void)
    func fetchRoomData(completion: @escaping (Result<RoomsModel, Error>) -> Void)
    func fetchBookingData(completion: @escaping (Result<BookingModel, Error>) -> Void)
}
