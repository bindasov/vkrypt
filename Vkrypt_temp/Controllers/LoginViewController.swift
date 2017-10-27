//
//  LoginViewController.swift
//  Vkrypt_temp
//
//  Created by team on 13.10.2017.
//  Copyright © 2017 team. All rights reserved.
//

import UIKit
import SwiftyVK

class LoginViewController: UIViewController {

    @IBOutlet weak var logoVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoMovedToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightOriginalConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightSmallerConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var buttonContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Gradient
        let color1 = UIColor(red: 83.0/255.0, green: 130.0/255.0, blue: 182.0/255.0, alpha: 1.0)
        //let color2 = UIColor(red: 88.0/255.0, green: 178.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        let color3 = UIColor(red: 102.0/255.0, green: 153.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        let color4 = UIColor(red: 141.0/255.0, green: 177.0/255.0, blue: 228.0/255.0, alpha: 1.0)

        let gradientColor: [CGColor] = [color1.cgColor, color3.cgColor, color4.cgColor]
        let gradientLocations: [Float] = [0.0, 0.75, 1.0]

        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        gradientLayer.locations = gradientLocations as [NSNumber]

        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        buttonContainerView.layer.cornerRadius = 5
        
        buttonContainerView.alpha = 0
        titleLabel.alpha = 0
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logoVerticalConstraint.isActive = false
        logoMovedToTopConstraint.isActive = true
        
        //подключаем
        logoHeightOriginalConstraint.isActive = false
        //отключаем
        logoHeightSmallerConstraint.isActive = true
        
        UIView.animate(withDuration: 1.0 ) {
            self.view.layoutIfNeeded()
            
            self.buttonContainerView.alpha = 1
            self.titleLabel.alpha = 1
            
            
            //self.buttonContainerView.frame = CGRectOffset(self.buttonContainerView.frame, 0, -20)
            //self.buttonContainerView.frame = CGRect.offsetBy(self.buttonContainerView.frame)
            //3944
            //self.buttonContainerView.frame = CGRect.offsetBy(0, -20)
//            extension CGRect {
//                mutating func offsetInPlace(dx: CGFloat, dy: CGFloat) {
//                    self = self.offsetBy(dx: dx, dy: dy)
//                }
//            }
            //self.buttonContainerView.frame = CGRectOffset
            
        }
    }
    
    @IBAction func onloginButton() {
        //авторизация пользователя
//        VK.sessions?.default.logIn(onSuccess: <#T##([String : String]) -> ()#>, onError: <#T##RequestCallbacks.Error##RequestCallbacks.Error##(VKError) -> ()#>)
        APIWorker.action(1)
       
    }
    
    
    func goToLogin() {
        //28.02
        self.performSegue(withIdentifier: "LoginSegue", sender: nil )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
