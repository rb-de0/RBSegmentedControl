//
//  RBSegment.swift
//  RBSegmentedControl
//
//  Created by rb_de0 on 2016/04/09.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import UIKit

class RBSegment: UIButton{
    
    init(title: String){
        super.init(frame: CGRectZero)
        setTitle(title, forState: .Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RBSegment {
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setBackgroundColor(color: UIColor, forUIControlState state: UIControlState) {
        setBackgroundImage(imageWithColor(color), forState: state)
    }
}