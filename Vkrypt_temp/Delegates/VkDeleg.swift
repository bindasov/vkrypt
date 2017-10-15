//
//  VkDeleg.swift
//  Vkrypt_temp
//
//  Created by Andrei Bindasov on 14.10.2017.
//  Copyright © 2017 Kodyk Valentina. All rights reserved.
//

import SwiftyVK
import UIKit

class VKDeleg: VKDelegate {
    let appID = "6219564"
    let scope: Set<VK.Scope> = [.messages,.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]

    init() {
        VK.config.logToConsole = true
        VK.configure(withAppId: appID, delegate: self)
    }
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        return scope
    }

    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidAuthorize"), object: nil)
    }

    func vkAutorizationFailedWith(error: AuthError) {
        print("Autorization failed with error: \n\(error)")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidNotAuthorize"), object: nil)
    }

    func vkDidUnauthorize() {}

    func vkShouldUseTokenPath() -> String? {
        return nil
    }

    func vkWillPresentView() -> UIViewController {
        return DispatchQueue.main.sync {
            return UIApplication.shared.delegate!.window!!.rootViewController!
        }
    }
}

