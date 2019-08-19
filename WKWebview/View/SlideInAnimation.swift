//
//  SlideInAnimation.swift
//  WKWebview
//
//  Created by hackeru on 19/08/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

class SlideInAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    //flag
    var isMenuOpen: Bool = false
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
       guard let toController = transitionContext.viewController(forKey: .to),
        let fromController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toController.view.bounds.width * 0.8
        let finalHeight = toController.view.bounds.height
        
        if isMenuOpen {
            containerView.addSubview(toController.view)
            
            // put the frame off the screen
            toController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        // Move on screen
        let transform = {
            toController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        
        // Move back off screen
        let identity = {
            fromController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isMenuOpen ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
        
    }
    
    
}
