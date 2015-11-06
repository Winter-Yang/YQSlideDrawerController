//
//  YQDrawerViewController.swift
//  YQDrawerController
//
//  Created by 杨雯德 on 15/11/5.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

import UIKit

enum YQDrawerControllerState{

   case Closed
   case Opening
   case Open
   case Closing

}

let kICSDrawerControllerDrawerDepth:CGFloat = 260.0
let kICSDrawerControllerLeftViewInitialOffset = -60.0
let kICSDrawerControllerAnimationDuration = 0.5



protocol YQDrawerDelegate:NSObjectProtocol {
        func gameDidStart(game: YQDrawerViewController)

}

class YQDrawerViewController: UIViewController {
    
    
    var leftViewController:UIViewController!
    var centerViewController:UIViewController!
    var drawerState:YQDrawerControllerState!
    var tapGesture:UITapGestureRecognizer!
    var panGesture:UIPanGestureRecognizer!
    var panGestureStartLocation:CGPoint!
    var centerView:YQDropShadowView!
    weak var drawerDelegateLeft: YQDrawerDelegate?
    weak var drawerDelegateCenter: YQDrawerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight]
        self.drawerState = YQDrawerControllerState.Closed
        self.centerView = YQDropShadowView()
        self.centerView.frame = self.view.bounds
        self.centerView.autoresizingMask = view.autoresizingMask
        self.view.addSubview(self.centerView)

    }
    
    func initDrawerViewController(leftViewController:UIViewController,centerViewController:UIViewController){
        
        self.leftViewController = leftViewController
        self.centerViewController = centerViewController
        if self.drawerDelegateLeft != nil{
            self.drawerDelegateLeft?.gameDidStart(self)
        }
        if self.drawerDelegateLeft != nil{
            self.drawerDelegateCenter?.gameDidStart(self)
        }

        addCenterViewController()
        setupGesyureRecognizers()

        

    }
    
    func addCenterViewController(){
        self.centerViewController.view.frame = self.view.bounds
        self.centerView.addSubview(self.centerViewController.view)
        self.addChildViewController(self.centerViewController)
        self.centerViewController.didMoveToParentViewController(self)
    }
    
    func setupGesyureRecognizers(){
        self.tapGesture = UITapGestureRecognizer.init(target: self, action: "tapGestureRecognized:")
        self.panGesture = UIPanGestureRecognizer.init(target: self, action: "panGestureRecognized:")
        self.panGesture.maximumNumberOfTouches = 1
        self.centerView.addGestureRecognizer(self.panGesture)
    }
    
    func tapGestureRecognized(tapGestureRecognizer: UITapGestureRecognizer){
        close()
    }
    
    func panGestureRecognized(panGestureRecognizer: UIPanGestureRecognizer){
        let state:UIGestureRecognizerState = panGestureRecognizer.state
        let location = panGestureRecognizer.locationInView(self.view)
        let velocity = panGestureRecognizer.locationInView(self.view)
        
        switch state{
        case UIGestureRecognizerState.Began:
            self.panGestureStartLocation = location
            if self.drawerState == YQDrawerControllerState.Closed{
                willOpen()
            }else{
                willClose()
            }
            break
        case UIGestureRecognizerState.Changed:
            
            var delta:CGFloat = 0.0
            if self.drawerState == YQDrawerControllerState.Opening{
                delta = location.x - self.panGestureStartLocation.x
            }else if self.drawerState == YQDrawerControllerState.Closing{
                delta = kICSDrawerControllerDrawerDepth - (self.panGestureStartLocation.x - location.x)
            }
            
            var c:CGRect = self.centerView.frame
            if delta > kICSDrawerControllerDrawerDepth{
                c.origin.x = kICSDrawerControllerDrawerDepth
            }else if delta < 0.0{
                c.origin.x = 0.0
            }else{
                c.origin.x = delta
            }
            
            self.centerView.frame = c
            break
        case UIGestureRecognizerState.Ended:
            if self.drawerState == YQDrawerControllerState.Opening{
                let centerViewLocation:CGFloat = self.centerView.frame.origin.x
                if centerViewLocation == kICSDrawerControllerDrawerDepth{
                    didOpen()
                }else if centerViewLocation > self.view.bounds.size.width / 3 && velocity.x > 0.0{
                    animateOpening()
                }else{
                    didOpen()
                    willClose()
                    animateClosing()
                }

            }else if self.drawerState == YQDrawerControllerState.Closing{
                let centerViewLocation:CGFloat = self.centerView.frame.origin.x
                if centerViewLocation == 0.0{
                    didClose()
                }else if centerViewLocation < (2 * self.view.bounds.size.width) / 3 {
                    animateClosing()
                }else{
                    didClose()
                    willOpen()
                    animateOpening()
                }
            }
            break
        default:
            break
        
        
        }
    }

    private func animateOpening(){
        var centerViewFinalFrame:CGRect = self.view.bounds
        centerViewFinalFrame.origin.x = kICSDrawerControllerDrawerDepth
        /**
        usingSpringWithDamping 弹簧效果 0-1  数值越小  效果越明显
        
        initialSpringVelocity则表示初始的速度，数值越大一开始移动越快
        */
        
        UIView.animateWithDuration(kICSDrawerControllerAnimationDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1.0,
            options: UIViewAnimationOptions.CurveLinear,
            animations: { () -> Void in
                
                self.centerView.frame = centerViewFinalFrame
            }) { (finish) -> Void in
                
                self.didOpen()
        }
    }
    
    private func animateClosing(){
        let centerViewFinalFrame:CGRect = self.view.bounds
        UIView.animateWithDuration(kICSDrawerControllerAnimationDuration,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1.0,
            options: UIViewAnimationOptions.CurveLinear,
            animations: { () -> Void in
                
                self.centerView.frame = centerViewFinalFrame
            }) { (finish) -> Void in
                
                self.didClose()
        }
    }
    
    func open(){
        willOpen()
        animateOpening()
    
    }
    
    private func willOpen(){
        self.drawerState = YQDrawerControllerState.Opening
        self.leftViewController.view.frame = self.view.bounds
        self.view.insertSubview(self.leftViewController.view, belowSubview: self.centerView)
        self.addChildViewController(self.leftViewController)
    }
    
    private func didOpen(){
        self.leftViewController.didMoveToParentViewController(self)
        self.centerView .addGestureRecognizer(self.tapGesture)
        self.drawerState = YQDrawerControllerState.Open
        self.centerViewController.view.userInteractionEnabled = false
    }
    
    func close(){
        animateClosing()
    }
    
    private func willClose(){
        self.leftViewController .willMoveToParentViewController(nil)
        self.drawerState = YQDrawerControllerState.Closing
    }
    
    private func didClose(){
        
        self.leftViewController.view.removeFromSuperview()
        self.leftViewController.removeFromParentViewController()
        self.centerView .removeGestureRecognizer(self.tapGesture)
        self.drawerState = YQDrawerControllerState.Closed
        self.centerViewController.view.userInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func reloadCenterViewController(animations: (color:UIColor) -> Void){
        self.centerViewController.view.backgroundColor =  UIColor(red: CGFloat(random()%255)/255, green: CGFloat(random()%255)/255, blue: CGFloat(random()%255)/255, alpha: 1.0)
        animations(color: UIColor.blackColor())
    
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


