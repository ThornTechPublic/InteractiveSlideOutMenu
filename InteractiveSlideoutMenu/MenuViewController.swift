//
//  MenuViewController.swift
//  InteractiveSlideoutMenu
//
//  Created by Robert Chen on 2/7/16.
//  Copyright © 2016 Thorn Technologies, LLC. All rights reserved.
//

import UIKit

class MenuViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor:Interactor? = nil
    
    var menuActionDelegate:MenuActionDelegate? = nil
    
    let menuItems = ["First", "Second"]
    
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Left)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension MenuViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
}

extension MenuViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            menuActionDelegate?.openSegue("openFirst", sender: nil)
        case 1:
            menuActionDelegate?.openSegue("openSecond", sender: nil)
        default:
            break
        }
    }
}