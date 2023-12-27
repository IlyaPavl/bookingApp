//
//  RoomViewController.swift
//  HotelPicker
//
//  Created by ily.pavlov on 19.12.2023.
//

import UIKit

final class RoomViewController: UITableViewController, RoomTableViewCellDelegate {
    private var viewModel = RoomViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        setupNavController()
        setupUI()
        
        viewModel.delegate = self
        viewModel.fetchRoomData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    func didSelectRoom() {
        let bookVC = BookingViewController()
        bookVC.title = "Бронирование"
        navigationController?.pushViewController(bookVC, animated: true)
    }
}



// MARK: - RoomViewController setupUI
extension RoomViewController {
    private func setupUI() {
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.frame = view.bounds
        tableView.sectionHeaderHeight = 10
    }
    
    private func setupNavController() {
        let backButtonImage = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
}

// MARK: - RoomViewModelDelegate
extension RoomViewController: RoomViewModelDelegate {
    func roomDataDidUpdate() {
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension RoomViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.roomModel?.rooms.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.identifier, for: indexPath) as! RoomTableViewCell

        if let room = viewModel.roomModel?.rooms[indexPath.section] {
            
            cell.configureCell(imageUrls: room.imageUrls, roomName: room.name, tagCloud: room.peculiarities, minPrice: String(room.price.formattedWithSeparator()), priceDescription: room.pricePer)
            cell.room = viewModel.roomModel?.rooms ?? []
        }
        
        
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.identifier) as? RoomTableViewCell else {
            return UITableView.automaticDimension
        }
        return cell.calculateCellHeight()
    }
}
