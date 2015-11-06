//
//  YQDropShadowView.swift
//  YQDrawerController
//
//  Created by 杨雯德 on 15/11/5.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

import UIKit

class YQDropShadowView: UIView {


    
    
 
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        self.backgroundColor = UIColor.redColor()
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.7
        
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.shadowPath = shadowPath.CGPath

    }


}
