//
//  PresentMenuAnimator.swift
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

class PresentMenuAnimator : NSObject {
}

extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView()
            else {
                return
        }
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        // replace main view with snapshot
        let snapshot = fromVC.view.snapshotViewAfterScreenUpdates(false)
        snapshot.tag = MenuHelper.snapshotNumber
        snapshot.userInteractionEnabled = false
        snapshot.layer.shadowOpacity = 0.7
        containerView.insertSubview(snapshot, aboveSubview: toVC.view)
        fromVC.view.hidden = true
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            animations: {
                snapshot.center.x += UIScreen.mainScreen().bounds.width * MenuHelper.menuWidth
            },
            completion: { _ in
                fromVC.view.hidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        )
    }
}