//
//  ViewController.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import UIKit
// aka home page of the app
class ViewController: UIViewController {
    
    // Victories that are currently being displayed
    var shownVictories: [Victory] = []
    
    let refreshControl = UIRefreshControl()
    
    let whiteContrastBox: UIView = {
        let box = UIView()
        box.backgroundColor = .white
        box.layer.cornerRadius = 59
        return box
    }()
    
    let monthDisplay: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NoticiaText-Regular", size: 30)
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        let todayDate = dateFormatter.string(from: currentDate)
        label.text = todayDate
        label.textColor = .black
        return label
    }()
    
    let victoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(VictoryTableViewCell.self, forCellReuseIdentifier: VictoryTableViewCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.white
        return tableView
    }()
    
    let homeIcon: UIButton = {
        let icon = UIButton()
        let buttonImage = UIImage(named: "home")
        icon.setImage(buttonImage, for: .normal)
        return icon
    }()
    
    let grayCircle: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "graycircle")
        return icon
    }()
    
    let yellowCircle: UIButton = {
        let icon = UIButton()
        let buttonImage = UIImage(named: "yellowcircle")
        icon.setImage(buttonImage, for: .normal)
        icon.addTarget(self, action: #selector(pushWriteLittleVictoryVC), for: .touchUpInside)
        return icon
    }()
    
    let plusIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "plus")
        return icon
    }()
    
    let profileIcon: UIButton = {
        let icon = UIButton()
        let buttonImage = UIImage(named: "user")
        icon.setImage(buttonImage, for: .normal)
        icon.addTarget(self, action: #selector(pushProfileVC), for: .touchUpInside)
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Loads up the victories every time this VC loads
        refreshData()
        
        // set up refresh control
        victoriesTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.lightYellow()
        
        [whiteContrastBox, monthDisplay, victoriesTableView, homeIcon, grayCircle, yellowCircle, plusIcon, profileIcon].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // set the TableView's data source and delegate
        victoriesTableView.dataSource = self
        victoriesTableView.delegate = self
        
        NSLayoutConstraint.activate([
            whiteContrastBox.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            whiteContrastBox.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8),
            whiteContrastBox.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteContrastBox.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            monthDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monthDisplay.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            victoriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            victoriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            victoriesTableView.topAnchor.constraint(equalTo: whiteContrastBox.topAnchor, constant: 20),
            victoriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            
            homeIcon.heightAnchor.constraint(equalToConstant: 35),
            homeIcon.widthAnchor.constraint(equalToConstant: 35),
            homeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            homeIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -27),
            
            grayCircle.heightAnchor.constraint(equalToConstant: 14),
            grayCircle.widthAnchor.constraint(equalToConstant: 14),
            grayCircle.centerXAnchor.constraint(equalTo: homeIcon.centerXAnchor),
            grayCircle.topAnchor.constraint(equalTo: homeIcon.bottomAnchor, constant: 5),
            
            yellowCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yellowCircle.heightAnchor.constraint(equalToConstant: 64),
            yellowCircle.widthAnchor.constraint(equalToConstant: 64),
            yellowCircle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            
            plusIcon.centerXAnchor.constraint(equalTo: yellowCircle.centerXAnchor),
            plusIcon.centerYAnchor.constraint(equalTo: yellowCircle.centerYAnchor),
            
            profileIcon.heightAnchor.constraint(equalToConstant: 35),
            profileIcon.widthAnchor.constraint(equalToConstant: 35),
            profileIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 293),
            profileIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -27)
        ])
    }
    
    @objc func pushWriteLittleVictoryVC() {
        navigationController?.present(AddNewVictoryVC(), animated: true, completion: {
            // Upon completion when the VC is swiped back down, we need to reload the data to contain the newly added victory entry
            self.refreshData()
        })
    }
    
    @objc func pushProfileVC() {
        // Push ProfileVC upon that button being clicked
        navigationController?.pushViewController(ProfileVC(), animated: true)
    }
    
    @objc func refreshData() {
        //GET request here to update the shownVictories list.
        NetworkManager.getVictories { victories in
            self.shownVictories = victories.victories
            self.victoriesTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.sortVictoryData()
        }
    }
    
    func sortVictoryData() {
        // Sorts the Victories by the most recent to least recent.
        shownVictories.sort { (leftVictory, rightVictory) -> Bool in
            return leftVictory.date > rightVictory.date
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownVictories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VictoryTableViewCell.id, for: indexPath) as! VictoryTableViewCell
        cell.configure(victory: shownVictories[indexPath.item])
        return cell
    }
    // Creates the animation for each item when they are sliding in
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? VictoryTableViewCell {
            let delay = 0.05 * Double(indexPath.row)
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
                    UIView.animate(
                        withDuration: 2,
                        delay: delay,
                        usingSpringWithDamping: 0.8,
                        initialSpringVelocity: 0.5,
                        options: [.curveEaseInOut],
                        animations: {
                            cell.transform = CGAffineTransform.identity
            })
        }
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Creates the white space in between each table view cell
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerColor: UIView = {
            let header = UIView()
            header.backgroundColor = .clear
            return header
        }()
        return headerColor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Pushes the view with the photo of the victory and initializing it with its date + image.
        let viewer = SpecificVictoryVC(victory: shownVictories[indexPath.item], index: indexPath.item)
        navigationController?.present(viewer, animated: true)
    }
}

extension UITableView {
    
    func fadeEdges(with modifier: CGFloat) {
        
        let visibleCells = self.visibleCells
        
        guard !visibleCells.isEmpty else { return }
        guard let topCell = visibleCells.first else { return }
        guard let bottomCell = visibleCells.last else { return }
        
        visibleCells.forEach {
            $0.contentView.alpha = 1
        }
        
        let cellHeight = topCell.frame.height - 1
        let tableViewTopPosition = self.frame.origin.y
        let tableViewBottomPosition = self.frame.maxY
        
        guard let topCellIndexpath = self.indexPath(for: topCell) else { return }
        let topCellPositionInTableView = self.rectForRow(at:topCellIndexpath)
        
        guard let bottomCellIndexpath = self.indexPath(for: bottomCell) else { return }
        let bottomCellPositionInTableView = self.rectForRow(at: bottomCellIndexpath)
        
        let topCellPosition = self.convert(topCellPositionInTableView, to: self.superview).origin.y
        let bottomCellPosition = self.convert(bottomCellPositionInTableView, to: self.superview).origin.y + cellHeight
        let topCellOpacity = (1.0 - ((tableViewTopPosition - topCellPosition) / cellHeight) * modifier)
        let bottomCellOpacity = (1.0 - ((bottomCellPosition - tableViewBottomPosition) / cellHeight) * modifier)
        
        topCell.contentView.alpha = topCellOpacity
        bottomCell.contentView.alpha = bottomCellOpacity
    }
}

