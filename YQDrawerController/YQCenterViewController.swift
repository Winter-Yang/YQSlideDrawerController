//
//  YQCenterViewController.swift
//  YQDrawerController
//
//  Created by 杨雯德 on 15/11/5.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

import UIKit

class YQCenterViewController: UIViewController,YQDrawerDelegate {
    
    var sdrawer:YQDrawerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled = true
        view.backgroundColor = UIColor.brownColor()
        
        let openDrawerButtn = UIButton(type: UIButtonType.Custom)
        openDrawerButtn.userInteractionEnabled = true
        openDrawerButtn.frame = CGRect(x:30, y: 30, width: 44, height: 44)
        openDrawerButtn.setImage(UIImage(named: "hamburger"), forState: UIControlState.Normal)
        openDrawerButtn.addTarget(self, action:"openDrawer:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(openDrawerButtn)
        
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: "tapGestureRecognized:")
        self.view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }

    func gameDidStart(game: YQDrawerViewController){
        self.sdrawer = game
    }
    
    func openDrawer(sender:UIButton){
        self.sdrawer?.open()
    }
    func tapGestureRecognized(pan:UITapGestureRecognizer){
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
