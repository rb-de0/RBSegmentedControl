//
//  ViewController.swift
//  RBSegmentedControl
//
//  Created by rb_de0 on 04/09/2016.
//  Copyright (c) 2016 rb_de0. All rights reserved.
//

import UIKit
import RBSegmentedControl

class ViewController: UIViewController {
    @IBOutlet weak var segmentedControl: RBSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
            
        segmentedControl.addSegments("0", "1", "2")
        segmentedControl.delegate = self
        
        // Customize Colors
        segmentedControl.borderColor = UIColor.brownColor()
        segmentedControl.segmentBackgroundColor = UIColor.whiteColor()
        segmentedControl.selectedSegmentBackgroundColor = UIColor.brownColor()
        segmentedControl.segmentTextColor = UIColor.brownColor()
        segmentedControl.selectedSegmentTextColor = UIColor.whiteColor()
    }
}

// MARK: - RBSegmentedControlDelegate
extension ViewController: RBSegmentedControlDelegate{
    func rb_segmentedControl(didChangedSelectedIndex index: Int) {
        print(index)
    }
}
