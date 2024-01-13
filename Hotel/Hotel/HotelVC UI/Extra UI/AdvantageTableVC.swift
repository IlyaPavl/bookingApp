//
//  AdvantageTableVC.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import UIKit

class AdvantageTableVC: UITableViewController {

    let imageName = ["face.smiling", "checkmark.square", "multiply.square"]
    let text = ["Удобства", "Что включено", "Что не включено"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        tableView.register(AdvantageTableViewCell.self, forCellReuseIdentifier: AdvantageTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 52, bottom: 0, right: 15)
        tableView.backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.988, alpha: 1)
        tableView.isScrollEnabled = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdvantageTableViewCell.identifier, for: indexPath) as! AdvantageTableViewCell
        cell.configureCell(imageName: imageName[indexPath.row], title: text[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
