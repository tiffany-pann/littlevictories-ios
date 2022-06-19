//
//  VictoryTableViewCell.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import UIKit

class VictoryTableViewCell: UITableViewCell {
    static var id = "VicotryTableViewCellID"
    
    var victoryDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NoticiaText-Regular", size: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var victoryDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NoticiaText-Regular", size: 15)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    var backgroundBox: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.pastelYellow()
        box.layer.cornerRadius = 15
        return box
    }()
    
    var blackVerticalLine: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        [backgroundBox, victoryDate, victoryDescription, blackVerticalLine].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            victoryDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            victoryDate.heightAnchor.constraint(equalToConstant: 44),
            victoryDate.widthAnchor.constraint(equalToConstant: 48),
            victoryDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            victoryDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            victoryDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            victoryDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            victoryDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            
            backgroundBox.topAnchor.constraint(equalTo: victoryDescription.topAnchor, constant: -5),
            backgroundBox.bottomAnchor.constraint(equalTo: victoryDescription.bottomAnchor, constant: 5),
            backgroundBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            backgroundBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13),
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure function that sets up this specific View
    func configure(victory: Victory) {
        let stringDate = convertUnixToString(date: victory.date)
        victoryDate.text = stringDate
        victoryDescription.text = victory.description
    }
}
