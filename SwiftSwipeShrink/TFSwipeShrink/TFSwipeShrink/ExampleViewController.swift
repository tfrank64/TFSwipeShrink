//
//  ExampleViewController.swift
//  TFSwipeShrink
//
//  Created by Taylor Franklin on 2/16/15.
//  Copyright (c) 2015 Taylor Franklin. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    
    
    @IBOutlet weak var swipeShrinkView: TFSwipeShrinkView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        swipeShrinkView.initialCenter = swipeShrinkView.center
        swipeShrinkView.finalCenter = CGPointMake(self.view.frame.size.width - self.view.frame.size.width/4, self.view.frame.size.height - (swipeShrinkView.frame.size.height/2))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
