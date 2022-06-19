//
//  AddNewVictoryVC.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import UIKit

class AddNewVictoryVC: UIViewController,UINavigationControllerDelegate {
    
    var imageView: UIImageView = UIImageView()
    
    let questionPrompt: UILabel = {
        let question = UILabel()
        question.text = "What's your little \nvictory today?"
        question.font = UIFont(name: "NoticiaText-Bold", size: 40)
        question.textColor = .black
        question.numberOfLines = 0
        return question
    }()
    
    let responseField: UITextField = {
        let response = UITextField()
        response.placeholder = "Type here..."
        response.backgroundColor = .clear
        response.layer.cornerRadius = 36
        return response
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(postVictory), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "NoticiaText-Bold", size: 18)
        button.backgroundColor = UIColor.lightYellow()
        button.layer.cornerRadius = 25
        return button
    }()
    
    let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "imageicon"), for: .normal)
        button.addTarget(self, action: #selector(displayImagePickerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let addVoiceMessageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "voiceicon"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        view.backgroundColor = .white
        
        [questionPrompt,responseField, submitButton, addPhotoButton, addVoiceMessageButton].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            questionPrompt.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            questionPrompt.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -608),
            questionPrompt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            responseField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            responseField.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            responseField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            responseField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -29),
            
            submitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 191),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            addVoiceMessageButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            addVoiceMessageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            addVoiceMessageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -310),
            
            addPhotoButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            addPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 122),
            addPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -231)
        ])
        
    }
    
    @objc func postVictory() {
        //TODO: Make POST request here
        if let description = responseField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let image = imageView.image?.jpegData(compressionQuality: 1)?.base64EncodedString()
        {
            // Make sure the image is sent in this format ->  image: "data:image/png;base64,\(image)"
            // networking POST call
            NetworkManager.postVictory(date: Int(NSDate().timeIntervalSince1970), description: description, image: "data:image/png;base64,\(image)") { Victory in
            }
        }
        // Dismiss this VC after the new victory is posted
        dismiss(animated: true) {
            
        }
    }
    
    // Allows users to pick an image from their photoLibrary
    @objc func displayImagePickerButtonTapped(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
}

extension AddNewVictoryVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            picker.dismiss(animated: true, completion: nil)
          }
        
    }
}
