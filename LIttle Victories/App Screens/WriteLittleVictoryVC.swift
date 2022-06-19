//
//  WriteLittleVictoryVC.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import UIKit

class WriteLittleVictoryVC: UIViewController, UINavigationControllerDelegate {
    var imageView: UIImageView = UIImageView()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .black
        dateLabel.font = UIFont(name: "NoticiaText-Regular", size: 20)
        return dateLabel
    }()
    
    let questionPrompt: UILabel = {
        let question = UILabel()
        question.text = "What's your little \nvictory today?"
        question.font = UIFont(name: "NoticiaText-Bold", size: 40)
        question.textColor = .black
        question.numberOfLines = 0
        return question
    }()
    
    let questionResponse: UITextField = {
        let response = UITextField()
        response.placeholder = "Type here..."
        return response
    }()
    
    let laterButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemGray, for: .normal)
        button.setTitleShadowColor(.systemGray6, for: .normal)
        button.titleLabel?.font =  UIFont(name: "NoticiaText-Regular", size: 18)
        button.addTarget(self, action: #selector(pushMainController), for: .touchUpInside)
        return button
    }()
    
    var submitButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "arrow")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(submitVictory), for: .touchUpInside)
        return button
    }()
    
    let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ add image", for: .normal)
        button.titleLabel?.font =  UIFont(name: "NoticiaText-Regular", size: 16)
        button.addTarget(self, action: #selector(displayImagePickerButtonTapped), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let photoIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "imageicon")
        return icon
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // date formatter to display the current date
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        dateLabel.text = dateFormatter.string(from: currentDate)
        
        // later button with the underlline
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NoticiaText-Regular", size: 18)!,
              .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
               string: "later",
               attributes: yourAttributes
            )
        laterButton.setAttributedTitle(attributeString, for: .normal)
        
        // ---
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.lightYellow()
        
        [dateLabel, questionPrompt, questionResponse, laterButton, submitButton, addPhotoButton].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            questionPrompt.topAnchor.constraint(equalTo: view.topAnchor, constant: 255),
            questionPrompt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            questionPrompt.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionPrompt.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            
            questionResponse.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            questionResponse.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -61),
            questionResponse.topAnchor.constraint(equalTo: view.topAnchor, constant: 385),
            
            
            laterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            laterButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            laterButton.topAnchor.constraint(equalTo: questionPrompt.bottomAnchor, constant: 327),
            laterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 21),
            addPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -275),
            addPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 465),
            addPhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -346),
            
            submitButton.leadingAnchor.constraint(equalTo: questionResponse.trailingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            submitButton.topAnchor.constraint(equalTo: questionPrompt.bottomAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: questionPrompt.bottomAnchor, constant: 20)
        ])
    }
    @objc func pushMainController() {
        // Pushes the main VC if the user decides to record their victory later
        navigationController?.setViewControllers([ViewController()], animated: true)
    }
    
    @objc func submitVictory() {
        // Makes POST request here to send a new victory to the backend
        if let description = questionResponse.text?.trimmingCharacters(in: .whitespacesAndNewlines),  let image = imageView.image?.jpegData(compressionQuality: 1)?.base64EncodedString(), description != "" {
            // We have the extra string in front in order to keep the image in base64
            NetworkManager.postVictory(date: Int(NSDate().timeIntervalSince1970), description: description, image: "data:image/png;base64,\(image)") { Victory in
            }
        }
        navigationController?.setViewControllers([ViewController()], animated: true)
    }
    
    @objc func displayImagePickerButtonTapped(_ sender: UIButton) {
        // Brings up the image picker controls for the user to select a image
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
}

extension WriteLittleVictoryVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Stores the selected image and dismisses the image picker UI
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            picker.dismiss(animated: true, completion: nil)
          }
        
    }
}
