//
//  CustomSegue.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/10.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class SegueRightToLeft: UIStoryboardSegue {
    override func perform() {
        
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        UIView.animate(
            withDuration: 0.25,
            delay: 0.0,
            options: [.curveEaseIn, .curveEaseOut],
            animations: {
                dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                
        }, completion: {
            finished in
            src.present(dst, animated: false, completion: nil)
            
        })
        
    }
    
}


class SegueLeftToRight: UIStoryboardSegue {
    override func perform() {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        UIView.animate(
        withDuration: 0.25,
        delay: 0.0,
        options: [.curveEaseIn, .curveEaseOut],
        animations: { dst.view.transform = CGAffineTransform(translationX: 0, y: 0) }) { (finished) in src.present(dst, animated: false, completion: nil) }
        
    }
    
    
}

class bottomToUpSegue : UIStoryboardSegue {
    override func perform() {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController

        // Get the screen width and height.
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        // Specify the initial position of the destination view.
        dst.view!.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)

        // Access the app's key window and insert the destination view above the current (source) one.
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)

        // Animate the transition.
        UIView.animate(withDuration: 1, animations: { () -> Void in
            src.view?.frame = (src.view?.frame.offsetBy(dx: 0, dy: screenHeight))!
            dst.view?.frame = (dst.view?.frame.offsetBy(dx: 0, dy: screenHeight))!

        }) { (finished) -> Void in
            self.source.present(self.destination, animated: false, completion: nil)
        }
    }
}
