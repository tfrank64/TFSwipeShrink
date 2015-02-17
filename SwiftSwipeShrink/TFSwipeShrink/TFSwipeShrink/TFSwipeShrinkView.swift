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
    
    func panning(panGesture: UIPanGestureRecognizer) {
        var translatedPoint = panGesture.translationInView(self.superview!)
//        println("Panning: \(translatedPoint)")
        
        var yChange = panGesture.view!.center.y + translatedPoint.y
        println("Y: \(yChange) :::: \(initialCenter!.y)")
        if yChange < initialCenter?.y {
            if abs(yChange) < 5 {
                // ensure frame is at highest position
                self.frame = CGRectMake(self.frame.origin.x, initialCenter!.y, self.frame.size.width, self.frame.size.height)
            }
            return
        } else if yChange > finalCenter?.y {
            if abs(yChange) < 5 {
                // emsure frame is at lowest position
                self.frame = CGRectMake(self.frame.origin.x, finalCenter!.y, self.frame.size.width, self.frame.size.height)
            }
            return
        }

        if panGesture.state == UIGestureRecognizerState.Began {

        } else if panGesture.state == UIGestureRecognizerState.Changed {
            
        }
        
        panGesture.view?.center = CGPointMake(panGesture.view!.center.x, panGesture.view!.center.y + translatedPoint.y)
        panGesture.setTranslation(CGPointMake(0, 0), inView: self.superview)
    }

}
