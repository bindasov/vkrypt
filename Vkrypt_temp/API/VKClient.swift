//
//  VKClient.swift
//  Vkrypt_temp
//
//  Created by Andrei Bindasov on 13.10.2017.
//  Copyright © 2017 Kodyk Valentina. All rights reserved.
//

import Foundation
import SwiftyVK


final class APIWorker {
    
    class func action(_ tag: Int) {
        switch tag {
        case 1:
            authorize()
        case 2:
            logout()
        case 3:
            captcha()
        case 4:
            usersGet()
        case 5:
            friendsGet()
        case 7:
            validation()
        default:
            print("Unrecognized action!")
        }
    }
    
    class func authorize() {
        VK.sessions?.default.logIn(
            onSuccess: { info in
                print("SwiftyVK: success authorize with", info)
                //performSegue(withIdentifier: "ToChatSegue", sender: nil)
        },
            onError: { error in
                print("SwiftyVK: authorize failed with", error)
        }
        )
    }
    
    class func logout() {
        VK.sessions?.default.logOut()
        print("SwiftyVK: LogOut")
    }
    
    class func captcha() {
        VK.API.Custom.method(name: "captcha.force")
            .onSuccess { print("SwiftyVK: captcha.force successed with \n \(JSON($0))") }
            .onError { print("SwiftyVK: captcha.force failed with \n \(JSON($0))") }
            .send()
    }
    
    class func validation() {
        VK.API.Custom.method(name: "account.testValidation")
            .onSuccess { print("SwiftyVK: account.testValidation successed with \n \(JSON($0))") }
            .onError { print("SwiftyVK: account.testValidation failed with \n \(JSON($0))") }
            .send()
    }
    
    class func usersGet() {
        VK.API.Users.get(.empty)
            .configure(with: Config.init(httpMethod: .POST))
            .onSuccess { print("SwiftyVK: users.get successed with \n \(JSON($0))") }
            .onError { print("SwiftyVK: friends.get fail \n \(JSON($0))") }
            .send()
    }
    
    class func friendsGet() {
        VK.API.Friends.get(.empty)
            .onSuccess { print("SwiftyVK: friends.get successed with \n \(JSON($0))") }
            .onError { print("SwiftyVK: friends.get failed with \n \(JSON($0))") }
            .send()
    }
}
