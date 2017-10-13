//
//  SplashViewController.swift
//  Vkrypt_temp
//
//  Created by Kodyk Valentina on 13.10.2017.
//  Copyright © 2017 Kodyk Valentina. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, VKryptLoginDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // if appDelegate.splashDelay not false
        if(!appDelegate.splashDelay) {
            delay(1.0, closure: {
                //smth to do
                self.continueLogin()
            })
        }
    }
    
    func goToLogin() {
        //28.02
        self.performSegue(withIdentifier: "LoginSegue", sender: self )
    }
    
    
    //если польщователь присутствует, даем ему доступ; иначе - надо авторизоваться
    func continueLogin() {
        appDelegate.splashDelay = false
        self.goToLogin()
    }
}
