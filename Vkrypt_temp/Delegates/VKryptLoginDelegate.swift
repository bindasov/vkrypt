//
//  VKryptLoginDelegate.swift
//  Vkrypt_temp
//
//  Created by team on 13.10.2017.
//  Copyright © 2017 team. All rights reserved.
//

import UIKit

//Для того, чтобы если пользователь залогинен,
// то он переходит к функционалу приложения
// иначе ему будет предложено авторизоваться
protocol VKryptLoginDelegate : class {
    func continueLogin()
}
