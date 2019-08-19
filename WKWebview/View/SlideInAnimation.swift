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
    
    let dimView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()

    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
       guard let toController = transitionContext.viewController(forKey: .to),
        let fromController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toController.view.bounds.width * 0.6
        let finalHeight = toController.view.bounds.height
        
        if isMenuOpen {
            containerView.addSubview(dimView)
            dimView.frame = containerView.bounds
            containerView.addSubview(toController.view)
            
            // put the frame off the screen
            toController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //anim to screen
        let transform = {
            self.dimView.alpha = 0.5
            toController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        //anim off screen
        let identity = {
            self.dimView.alpha = 0.0
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
