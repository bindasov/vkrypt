//
//  VkDeleg.swift
//  Vkrypt_temp
//
//  Created by Andrei Bindasov on 14.10.2017.
//  Copyright © 2017 Kodyk Valentina. All rights reserved.
//

import SwiftyVK
import UIKit

class VKDeleg: SwiftyVKDelegate {
    
    let appID = "6218409"
    let scopes: Scopes = [.messages,.offline,.friends,.email]
    
    init() {
        VK.setUp(appId: appID, delegate: self)
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            rootController.present(viewController, animated: true, completion: nil)
        }
    }
    
    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token updated in session \(sessionId) with info \(info)")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
    }
}

