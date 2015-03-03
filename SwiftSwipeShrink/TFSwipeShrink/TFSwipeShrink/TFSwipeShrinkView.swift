//
//  TFSwipeShrinkView.swift
//  TFSwipeShrink
//
//  Created by Taylor Franklin on 2/16/15.
//  Copyright (c) 2015 Taylor Franklin. All rights reserved.
//

import UIKit

class TFSwipeShrinkView: UIView {

    var initialCenter: CGPoint?
    var finalCenter: CGPoint?
    var initialSize: CGSize?
    var finalSize: CGSize?
    var firstX: CGFloat = 0, firstY: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var panGesture = UIPanGestureRecognizer(target: self, action: "panning:")
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGesture)
    }
    
    func configureSizeAndPosition(parentView: CGRect) {
        
        self.initialCenter = self.center
        self.finalCenter = CGPointMake(parentView.size.width - parentView.size.width/4, parentView.size.height - (self.frame.size.height/4) - 5)
        
        initialSize = self.frame.size
        finalSize = CGSizeMake(parentView.size.width/2 - 20, (parentView.size.width/2 - 20) * 0.5625)
    }
    
    func panning(panGesture: UIPanGestureRecognizer) {
        var translatedPoint = panGesture.translationInView(self.superview!)
        var gestureState = panGesture.state
        
        var yChange = panGesture.view!.center.y + translatedPoint.y
        println("Y: \(yChange) :::: \(initialCenter!.y)")
        if yChange < initialCenter?.y {
            gestureState = UIGestureRecognizerState.Ended
            
        } else if yChange >= finalCenter?.y {
            gestureState = UIGestureRecognizerState.Ended
            
        }

        if gestureState == UIGestureRecognizerState.Began || gestureState == UIGestureRecognizerState.Changed  {
            panGesture.view?.center = CGPointMake(panGesture.view!.center.x, panGesture.view!.center.y + translatedPoint.y)
            panGesture.setTranslation(CGPointMake(0, 0), inView: self.superview)
            //TODO: change frame size constantly

        } else if gestureState == UIGestureRecognizerState.Ended {
            println("ENDED")
            var topDistance = yChange - initialCenter!.y
            var bottomDistance = finalCenter!.y - yChange
            
            var chosenCenter: CGPoint = CGPointZero
            var chosenSize: CGSize = CGSizeZero
            self.userInteractionEnabled = false
            
            if topDistance > bottomDistance {
                // animate to bottom
                chosenCenter = finalCenter!
                chosenSize = finalSize!
                
            } else {
                // animate to top
                chosenCenter = initialCenter!
                chosenSize = initialSize!
            }
            println("Chosens: \(chosenCenter) and \(chosenSize)")
            
            if panGesture.view?.center != chosenCenter {
                UIView.animateWithDuration(0.4, animations: {
                    panGesture.view?.frame.size = chosenSize
                    panGesture.view?.center = chosenCenter
                    
                }, completion: {(done: Bool) in
                    self.userInteractionEnabled = true
                })
            } else {
                self.userInteractionEnabled = true
            }
        }
        
    }

}
