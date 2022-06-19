//
//  SpecificVictoryVC.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/18/22.
//

import UIKit
import SDWebImage

class SpecificVictoryVC: UIViewController {
    
    let cameraTheme: UIImageView = {
        let theme = UIImageView()
        theme.image = UIImage(named: "camera")
        return theme
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "NoticiaText-Regular", size: 36)
        return label
    }()
    
    let victoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOffset = CGSize.init(width: 5, height: 5)
        return image
    }()
    
    let pencilIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "pencil")
        return icon
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "NoticiaText-Bold", size: 20)
        label.numberOfLines = 0
        return label
    }()

    
    
    // Initializes the VC with the information passed from the VC
    init(victory: Victory, index: Int) {
        super.init(nibName: nil, bundle: nil)
        // Convert victory date from UNIX form to a string that can be displayed
        dateLabel.text = convertUnixToStringFullDate(date: victory.date)
        // Convert image from an AWS bucket link into a displayable image
        victoryImage.sd_setImage(with: URL(string: victory.image), placeholderImage: UIImage(named: "shimmering"))
        descriptionLabel.text = victory.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        [victoryImage, descriptionLabel, dateLabel, pencilIcon].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        view.backgroundColor = .white
        NSLayoutConstraint.activate([

            // Scratched original theme for this page - May return to this in the future because I liked it.
//            cameraTheme.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            cameraTheme.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            cameraTheme.topAnchor.constraint(equalTo: view.topAnchor),
//            cameraTheme.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300),
        
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            victoryImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 261),
            victoryImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -294),
            victoryImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            victoryImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            pencilIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            pencilIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 341),
            pencilIcon.heightAnchor.constraint(equalToConstant: 20),
            pencilIcon.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}

func convertUnixToStringFullDate(date: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(date))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EST") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd MMMM YYYY"//Specify your format that you want
    let strDate = dateFormatter.string(from: date)
    
    return strDate
}
