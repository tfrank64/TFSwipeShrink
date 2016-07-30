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
        let path = Bundle.main.pathForResource("bayw-HD", ofType: "mp4")
        moviePlayerController = MPMoviePlayerViewController(contentURL: URL(fileURLWithPath: path!))
        moviePlayerController.moviePlayer.controlStyle = MPMovieControlStyle.none
        moviePlayerController.moviePlayer.scalingMode = MPMovieScalingMode.aspectFit
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        swipeShrinkView.configureSizeAndPosition(self.view.frame)
        moviePlayerController.view.frame = CGRect(x: 0, y: 0, width: swipeShrinkView.frame.size.width, height: swipeShrinkView.frame.size.height)
        swipeShrinkView.addSubview(moviePlayerController.view)
        moviePlayerController.moviePlayer.pause()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playMovie(_ sender: AnyObject) {
        
        self.swipeShrinkView.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            self.swipeShrinkView.alpha = 1.0
        }, completion: {(done: Bool) in
            self.moviePlayerController.moviePlayer.play()
        })
        
    }

}
