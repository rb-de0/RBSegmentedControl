//
//  RBSegmentHelper.swift
//  RBSegmentedControl
//
//  Created by rb_de0 on 2016/04/09.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

class RBSegmentHelper{
    class func compare(value1: String, value2: String) -> Bool{
        let index1 = Int(value1.componentsSeparatedByString("_")[1])
        let index2 = Int(value2.componentsSeparatedByString("_")[1])
        return index1 < index2
    }
}