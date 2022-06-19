//
//  GoogleAuthLoginVC.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import UIKit
import GoogleSignIn
import Firebase
// Updated copy
class GoogleAuthLoginVC: ViewController {
    
    let signInButton = GIDSignInButton()
    
    let logoImage = UIImageView()
    
    override func viewDidLoad() {
    
        view.backgroundColor = .white
        
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInButton.style = .wide
        
        logoImage.image = UIImage(named: "egg_with_sign")
        logoImage.contentMode = .scaleAspectFit
        
        view.addSubview(signInButton)
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 400),
            signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 520),

            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -55),
            logoImage.heightAnchor.constraint(equalToConstant: 394),
            logoImage.widthAnchor.constraint(equalToConstant: 274),
        ])
    }
    
    @objc func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            if let error = error {
                print(error.localizedDescription)
                
            } //TODO: add an else here when all testing is done. it forces you to log in
           //  user?.profile.
            self.navigationController?.setViewControllers([WriteLittleVictoryVC()], animated: true)
            if let userToken = user?.authentication.idToken {
                // POST request to the backend that sends them an IDtoken that allows to create a User on their end.
                NetworkManager.sendToken(token: userToken) { User in
                    print(User)
                }
            }
        }

    }
    
}
