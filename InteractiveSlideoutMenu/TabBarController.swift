//
//  TabBarController.swift
//  InteractiveSlideoutMenu
//
//  Created by Robert Chen on 3/11/16.
//  Copyright © 2016 Thorn Technologies, LLC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToTabOne", name: "goToTabOne", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToTabTwo", name: "goToTabTwo", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func goToTabOne(){
        selectedIndex = 0
    }
    
    func goToTabTwo(){
        selectedIndex = 1
    }
    
}