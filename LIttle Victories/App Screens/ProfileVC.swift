//
//  ProfileVC.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import UIKit
import GoogleSignIn

class ProfileVC: UIViewController {
    
    let contrastBox: UIView = {
        let box = UIView()
        box.backgroundColor = .white
        box.layer.cornerRadius = 59
        return box
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user-circle")
        return image
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.text = "Jacket Team"
        label.font = UIFont(name: "NoticiaText-Bold", size: 32)
        label.textColor = .black
        return label
    }()
    
    let victoriesLoggedLabel: UILabel = {
        let label = UILabel()
        label.text = "8 Little Victories Logged"
        label.font = UIFont(name: "NoticiaText-Bold", size: 20)
        label.textColor = .black
        return label
    }()
    
    let memberSinceLabel: UILabel = {
        let label = UILabel()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd YYYY"
        let todayDate = dateFormatter.string(from: currentDate)
        label.text = "Member since \(todayDate)"
        label.font = UIFont(name: "NoticiaText-Bold", size: 20)
        label.textColor = .black
        return label
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Want to receive monthly recaps of your victories?"
        label.font = UIFont(name: "NoticiaText-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    let userLogoutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(LogOut), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font =  UIFont(name: "NoticiaText-Bold", size: 18)
        button.backgroundColor = UIColor.lightYellow()
        button.layer.cornerRadius = 25
        return button
    }()
    
    let numberInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Add your phone number!"
        input.backgroundColor = .clear
        input.layer.cornerRadius = 10
        return input
    }()
    
    let submitNumber: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "arrow")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(postNumber), for: .touchUpInside)
        return button
    }()
    
    let randomEncouragement: UILabel = {
        let text = UILabel()
        text.font =  UIFont(name: "NoticiaText-Bold", size: 18)
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    let listofEncouragement = [
        "“Discouragement and failure are two of the surest stepping stones to success.” – Dale Carnegie",
        "“Do not let what you cannot do interfere with what you can do.” – John Wooden",
        "“If there is no struggle, there is no progress.“ – Frederick Douglass",
        "“A ship is always safe at the shore – but that is NOT what it is built for.” – Albert Einstein",
        "“Rise above the storm and you will find the sunshine.” – Mario Fernandez",
        "“Count your age by friends, not years. Count your life by smiles, not tears.” – John Lennon",
        "“It does not matter how slowly you go as long as you do not stop.” – Confucius",
        "“Life has no limitations, except the ones you make.” – Les Brown",
        "“Life has got all those twists and turns. You’ve got to hold on tight and off you go.”— Nicole Kidman",
        "“It always seems impossible until it’s done.” – Nelson Mandela",
        "“Thankfully, persistence is a great substitute for talent.” – Steve Martin",
        "“The man who moves a mountain begins by carrying away small stones.”― Confucius",
        "“I’ve failed over and over and over again in my life. And that is why I succeed.” – Michael Jordan",
        "“Failure is the condiment that gives success its flavor.” – Truman Capote"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Generate the random quote each time this screen is loaded.
        let randomInt = Int.random(in: 0..<listofEncouragement.count)
        // Set the text as the randomly generated encouragement! :)
        randomEncouragement.text = listofEncouragement[randomInt]
        
        view.backgroundColor = UIColor.lightYellow()
        
        // Makes the "back" button on the nav bar white instead of blue
        self.navigationController!.navigationBar.tintColor = .white
        
        [contrastBox, profileImage, teamLabel, victoriesLoggedLabel, memberSinceLabel, questionLabel, numberInput, submitNumber,  userLogoutButton, randomEncouragement].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contrastBox.topAnchor.constraint(equalTo: view.topAnchor, constant: 184),
            contrastBox.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8),
            contrastBox.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contrastBox.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 129),
            profileImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -605),
            
            teamLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            teamLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 239),
            teamLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -565),
            
            victoriesLoggedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            victoriesLoggedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 313),
            victoriesLoggedLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -499),
            
            memberSinceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            memberSinceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 355),
            memberSinceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -439),
            
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: contrastBox.topAnchor, constant: 281),
            questionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -313),
            
            numberInput.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            numberInput.trailingAnchor.constraint(equalTo: questionLabel.leadingAnchor,constant: 200),
            numberInput.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: -15),
            numberInput.heightAnchor.constraint(equalToConstant: 30),
            
            submitNumber.centerYAnchor.constraint(equalTo: numberInput.centerYAnchor),
            submitNumber.leadingAnchor.constraint(equalTo: numberInput.trailingAnchor, constant: 10),
            submitNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            userLogoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userLogoutButton.topAnchor.constraint(equalTo: contrastBox.topAnchor, constant: 534),
            userLogoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72),
            userLogoutButton.heightAnchor.constraint(equalToConstant: 54),
            userLogoutButton.widthAnchor.constraint(equalToConstant: 173),
            
            randomEncouragement.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            randomEncouragement.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            randomEncouragement.topAnchor.constraint(equalTo: numberInput.bottomAnchor, constant: 10),
            randomEncouragement.bottomAnchor.constraint(equalTo: userLogoutButton.topAnchor)
        ])
    }
    
    @objc func LogOut() {
        // Set up the signout button to return back to the original Google log in screen
        GIDSignIn.sharedInstance.signOut()
        self.navigationController?.pushViewController(GoogleAuthLoginVC(), animated: true)
    }
    
    @objc func postNumber() {
        // Makes POST request that sends the user's phone number to the backend
        if let number = numberInput.text?.trimmingCharacters(in: .whitespacesAndNewlines), number != "" {
            NetworkManager.sendPhoneNumber(number: Int(number)!) { user in
                print(user)
            }
        }
        
        // Displays an alert that lets the user know that their phone number has been recieved
        let dialogMessage = UIAlertController(title: "Phone Number Recieved!", message: "Look out for a text soon 😄", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Sounds good", style: .default, handler: { (action) -> Void in
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
        
        // Sets the input field back to empty again
        self.numberInput.text = ""
    }
}

