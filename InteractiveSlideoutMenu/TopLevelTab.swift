//
//  TopLevelTab.swift
//  InteractiveSlideoutMenu
//
//  Created by Robert Chen on 3/11/16.
//  Copyright © 2016 Thorn Technologies, LLC. All rights reserved.
//

import UIKit

class TopLevelTab: UITabBarController {

    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToTabs", name: "goToTabs", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToExtraPage", name: "goToExtraPage", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func goToTabs(){
        selectedIndex = 0
    }
    
    func goToExtraPage(){
        selectedIndex = 1
    }
}
