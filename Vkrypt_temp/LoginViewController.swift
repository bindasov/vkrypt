//
//  LoginViewController.swift
//  Vkrypt_temp
//
//  Created by team on 13.10.2017.
//  Copyright © 2017 team. All rights reserved.
//

import UIKit

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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logoVerticalConstraint.isActive = false
        logoMovedToTopConstraint.isActive = true
        
        //подключаем
        logoHeightOriginalConstraint.isActive = false
        //отключаем
        logoHeightSmallerConstraint.isActive = true
        
        UIView.animate(withDuration: 1.5) {
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
