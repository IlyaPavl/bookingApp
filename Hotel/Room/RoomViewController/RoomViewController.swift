//
//  RoomViewController.swift
//  Hotel
//
//  Created by ily.pavlov on 09.01.2024.
//

import UIKit

final class RoomViewController: UITableViewController, RoomTableViewCellDelegate {
    private var viewModel = RoomViewModel()

    override func viewDidLoad() {
        print(" ")
        print(#function)
        super.viewDidLoad()
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        setupNavController()
        setupTableUI()
        
        viewModel.delegate = self
        viewModel.fetchRoomData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)

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
    private func setupTableUI() {
        print(#function)

        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.frame = view.bounds
        tableView.sectionHeaderHeight = 10
    }
    
    private func setupNavController() {
        print(#function)
        let backButtonImage = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
}

// MARK: - RoomViewModelDelegate
extension RoomViewController: RoomViewModelDelegate {
    func roomDataDidUpdate() {
        print(#function)
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
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.identifier, for: indexPath) as! RoomTableViewCell

        if let room = viewModel.roomModel?.rooms[indexPath.section] {
            cell.configureCell(roomName: room.name, tagCloud: room.peculiarities, minPrice: String(room.price.formattedWithSeparator()), priceDescription: room.pricePer)
            cell.room = viewModel.roomModel?.rooms ?? []
            
            viewModel.fetchImage(from: room.imageUrls) { images in
                cell.images = images
            }
        }
        
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function)

        return 566
    }
}
