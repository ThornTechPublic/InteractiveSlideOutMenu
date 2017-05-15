//
//  MainViewController.swift
//  InteractiveSlideoutMenu
//
//  Created by Robert Chen on 2/7/16.
//
//  Copyright (c) 2016 Thorn Technologies LLC
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

protocol MenuActionDelegate {
    func openSegue(_ segueName: String, sender: AnyObject?)
    func reopenMenu()
}

class MainViewController: UIViewController {

    let interactor = Interactor()

    @IBAction func openMenu(_ sender: AnyObject) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    @IBAction func edgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MenuViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor
            destinationViewController.menuActionDelegate = self
        }
    }

}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

extension MainViewController : MenuActionDelegate {
    func openSegue(_ segueName: String, sender: AnyObject?) {
        dismiss(animated: true){
            self.performSegue(withIdentifier: segueName, sender: sender)
        }
    }
    func reopenMenu(){
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}
