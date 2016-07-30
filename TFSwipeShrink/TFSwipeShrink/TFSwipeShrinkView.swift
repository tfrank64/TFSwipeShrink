//
//  TFSwipeShrinkView.swift
//  TFSwipeShrink
//
//  Created by Taylor Franklin on 2/16/15.
//  Copyright (c) 2015 Taylor Franklin. All rights reserved.
//

import UIKit

class TFSwipeShrinkView: UIView, UIGestureRecognizerDelegate {

    var initialCenter: CGPoint?
    var finalCenter: CGPoint?
    var initialSize: CGSize?
    var finalSize: CGSize?
    var firstX: CGFloat = 0, firstY: CGFloat = 0
    var aspectRatio: CGFloat = 0.5625
    
    var rangeTotal: CGFloat!
    var widthRange: CGFloat!
    var centerXRange: CGFloat!
    
    // Should be called when making view programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initGestures()
    }

    // Should be called when creating view from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initGestures()
    }
    
    func initGestures() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(TFSwipeShrinkView.panning(_:)))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TFSwipeShrinkView.tapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        
    }
    
    /// Method to set up initial and final positions of view
    func configureSizeAndPosition(parentViewFrame: CGRect) {
        
        self.initialCenter = self.center
        self.finalCenter = CGPointMake(parentViewFrame.size.width - parentViewFrame.size.width/4, parentViewFrame.size.height - (self.frame.size.height/4) - 2)
        
        initialSize = self.frame.size
        finalSize = CGSizeMake(parentViewFrame.size.width/2 - 10, (parentViewFrame.size.width/2 - 10) * aspectRatio)
        
        // Set common range totals once
        rangeTotal = finalCenter!.y - initialCenter!.y
        widthRange = initialSize!.width - finalSize!.width
        centerXRange = finalCenter!.x - initialCenter!.x
    }
    
    func panning(panGesture: UIPanGestureRecognizer) {
        let translatedPoint = panGesture.translationInView(self.superview!)
        var gestureState = panGesture.state
        
        let yChange = panGesture.view!.center.y + translatedPoint.y
        if yChange < initialCenter?.y {
            gestureState = UIGestureRecognizerState.Ended
            
        } else if yChange >= finalCenter?.y {
            gestureState = UIGestureRecognizerState.Ended
            
        }

        if gestureState == UIGestureRecognizerState.Began || gestureState == UIGestureRecognizerState.Changed  {

            // modify size as view is panned down
            let progress = ((panGesture.view!.center.y - initialCenter!.y) / rangeTotal)
            
            let invertedProgress = 1 - progress
            let newWidth = finalSize!.width + (widthRange * invertedProgress)
            
            panGesture.view?.frame.size = CGSizeMake(newWidth, newWidth * aspectRatio)
            
            // ensure center x value moves along with size change
            let finalX = initialCenter!.x + (centerXRange * progress)
            
            panGesture.view?.center = CGPointMake(finalX, panGesture.view!.center.y + translatedPoint.y)
            panGesture.setTranslation(CGPointMake(0, 0), inView: self.superview)

        } else if gestureState == UIGestureRecognizerState.Ended {

            let topDistance = yChange - initialCenter!.y
            let bottomDistance = finalCenter!.y - yChange
            
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
    
    func tapped(tapGesture: UITapGestureRecognizer) {
        
        if tapGesture.view?.center == self.finalCenter {
            self.userInteractionEnabled = false
            UIView.animateWithDuration(0.4, animations: {
                tapGesture.view?.frame.size = self.initialSize!
                tapGesture.view?.center = self.initialCenter!
                
                }, completion: {(done: Bool) in
                    self.userInteractionEnabled = true
            })
        }
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
