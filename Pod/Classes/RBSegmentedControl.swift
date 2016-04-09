//
//  RBSegmentedControl.swift
//  RBSegmentedControl
//
//  Created by rb_de0 on 2016/04/09.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import UIKit

class RBSegmentedControl: UIView{
    
    private var segmentMap = [String: RBSegment]()
    private var segmentConstrains = [NSLayoutConstraint]()
    
    private var borderMap = [String: UIView]()
    
    private(set) var selectedSegmentIndex = 0
    
    weak var delegate: RBSegmentedControlDelegate?
    
    var selectedSegmentTextColor = RBSegmentControlConst.DefaultSelectedTextColor
    var segmentTextColor = RBSegmentControlConst.DefaultTextColor
    
    var selectedSegmentBackgroundColor = RBSegmentControlConst.DefaultSelectedBackgroundColor
    var segmentBackgroundColor = RBSegmentControlConst.DefaultBackgroundColor
    
    var borderColor = RBSegmentControlConst.DefaultBorderColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.CGColor
    }
}

// MARK: - add/remove
extension RBSegmentedControl{
    func addSegments(titles: String...){
        
        for (index, title) in titles.enumerate(){
            let newSegment = RBSegment(title: title)
            newSegment.translatesAutoresizingMaskIntoConstraints = false
            newSegment.addTarget(self, action: #selector(RBSegmentedControl.onTapped(_:)), forControlEvents: .TouchUpInside)
            segmentMap.updateValue(newSegment, forKey: "segment_\(viewMap.count)")
            addSubview(newSegment)
            
            if index != titles.count - 1{
                let newBorder = UIView()
                newBorder.translatesAutoresizingMaskIntoConstraints = false
                newBorder.backgroundColor = borderColor
                borderMap.updateValue(newBorder, forKey: "border_\(viewMap.count)")
                addSubview(newBorder)
            }
        }
        
        updateSegments()
        updateColors()
    }
    
    func removeSegments(count: Int){
        let targetSegments = segmentMap.sort({RBSegmentHelper.compare($0.0, value2: $1.0)}).suffix(count)
        targetSegments.forEach{
            segmentMap.removeValueForKey($0.0)
            $0.1.removeFromSuperview()
        }
        
        let targetBorders = borderMap.sort({RBSegmentHelper.compare($0.0, value2: $1.0)}).suffix(count)
        targetBorders.forEach{
            borderMap.removeValueForKey($0.0)
            $0.1.removeFromSuperview()
        }
        
        selectedSegmentIndex = 0
        updateSegments()
        updateColors()
    }
    
    func onTapped(sender: RBSegment){
        
        for (index, segment) in segmentMap.sort({RBSegmentHelper.compare($0.0, value2: $1.0)}).map({$0.1}).enumerate(){
            if segment == sender && selectedSegmentIndex != index{
                delegate?.rb_segmentedControl(didChangedSelectedIndex: index)
                selectedSegmentIndex = index
                break
            }
        }
        
        updateColors()
    }
}

// MARK: - update
extension RBSegmentedControl{
    private var viewMap: [String: UIView]{
        var viewMap = [String: UIView]()
        
        segmentMap.forEach{viewMap.updateValue($0.1, forKey: $0.0)}
        borderMap.forEach{viewMap.updateValue($0.1, forKey: $0.0)}
        
        return viewMap
    }
    
    private func updateSegments(){
        if segmentMap.count <= 1{
            return
        }
        
        removeSegmentConstrains()
        
        updateHorizontalMarigin()
        updateVerticalMargin()
        updateSegmentWidth()
        updateBorderWidth()
        
        layoutIfNeeded()
    }
    
    private func updateBorderWidth(){
        let keys = borderMap.keys.sort(RBSegmentHelper.compare)
        
        for key in keys{
            let width = NSLayoutConstraint.constraintsWithVisualFormat("[\(key)(1)]", options: NSLayoutFormatOptions(), metrics: nil, views: borderMap)
            addSegmentConstrains(width)
        }
    }
    
    private func updateSegmentWidth(){
        let keys = segmentMap.keys.sort(RBSegmentHelper.compare)
        let first = keys.first!
        
        for key in keys where key != first{
            let equalWidth = NSLayoutConstraint.constraintsWithVisualFormat("[\(first)(==\(key))]", options: NSLayoutFormatOptions(), metrics: nil, views: segmentMap)
            addSegmentConstrains(equalWidth)
        }
    }
    
    private func updateVerticalMargin(){
        for key in segmentMap.keys{
            let verticalMargin = NSLayoutConstraint.constraintsWithVisualFormat("V:|[\(key)]|", options: NSLayoutFormatOptions(), metrics: nil, views: segmentMap)
            addSegmentConstrains(verticalMargin)
        }
        
        for key in borderMap.keys{
            let verticalMargin = NSLayoutConstraint.constraintsWithVisualFormat("V:|[\(key)]|", options: NSLayoutFormatOptions(), metrics: nil, views: borderMap)
            addSegmentConstrains(verticalMargin)
        }
    }
    
    private func updateHorizontalMarigin(){
        let keys = viewMap.keys.sort(RBSegmentHelper.compare)
        let visualFormat = keys.reduce(""){$0 + "[\($1)]"}
        
        let horizontalMargin = NSLayoutConstraint.constraintsWithVisualFormat("H:|\(visualFormat)|", options: NSLayoutFormatOptions(), metrics: nil, views: viewMap)
        addSegmentConstrains(horizontalMargin)
        
    }
    
    private func addSegmentConstrains(segmentConstraints: [NSLayoutConstraint]){
        segmentConstrains.appendContentsOf(segmentConstraints)
        addConstraints(segmentConstraints)
    }
    
    private func removeSegmentConstrains(){
        segmentConstrains.forEach(removeConstraint)
        segmentConstrains.removeAll()
    }
    
    private func updateColors(){
        for (index, segment) in segmentMap.sort({RBSegmentHelper.compare($0.0, value2: $1.0)}).map({$0.1}).enumerate(){
            if selectedSegmentIndex != index{
                segment.setBackgroundColor(selectedSegmentBackgroundColor.colorWithAlphaComponent(0.2), forUIControlState: .Highlighted)
                segment.setBackgroundColor(segmentBackgroundColor, forUIControlState: .Normal)
                segment.setTitleColor(segmentTextColor.colorWithAlphaComponent(0.8), forState: .Highlighted)
                segment.setTitleColor(segmentTextColor, forState: .Normal)
            }else{
                segment.setBackgroundColor(selectedSegmentBackgroundColor.colorWithAlphaComponent(0.8), forUIControlState: .Highlighted)
                segment.setBackgroundColor(selectedSegmentBackgroundColor, forUIControlState: .Normal)
                segment.setTitleColor(selectedSegmentTextColor.colorWithAlphaComponent(0.8), forState: .Highlighted)
                segment.setTitleColor(selectedSegmentTextColor, forState: .Normal)
            }
        }
    }
}

