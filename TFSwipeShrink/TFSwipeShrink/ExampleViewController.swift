//
//  ExampleViewController.swift
//  TFSwipeShrink
//
//  Created by Taylor Franklin on 2/16/15.
//  Copyright (c) 2015 Taylor Franklin. All rights reserved.
//

import UIKit
import MediaPlayer

class ExampleViewController: UIViewController {
    
    
    @IBOutlet weak var swipeShrinkView: TFSwipeShrinkView!
    var moviePlayerController: MPMoviePlayerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("bayw-HD", ofType: "mp4")
        moviePlayerController = MPMoviePlayerViewController(contentURL: NSURL.fileURLWithPath(path!))
        moviePlayerController.moviePlayer.controlStyle = MPMovieControlStyle.None
        moviePlayerController.moviePlayer.scalingMode = MPMovieScalingMode.AspectFit
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        swipeShrinkView.configureSizeAndPosition(self.view.frame)
        moviePlayerController.view.frame = CGRectMake(0, 0, swipeShrinkView.frame.size.width, swipeShrinkView.frame.size.height)
        swipeShrinkView.addSubview(moviePlayerController.view)
        moviePlayerController.moviePlayer.pause()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playMovie(sender: AnyObject) {
        
        self.swipeShrinkView.hidden = false
        UIView.animateWithDuration(0.4, animations: {
            self.swipeShrinkView.alpha = 1.0
        }, completion: {(done: Bool) in
            self.moviePlayerController.moviePlayer.play()
        })
        
    }

}
