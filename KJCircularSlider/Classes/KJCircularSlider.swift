//
//  KJCircularSlider.swift
//  trial-1
//
//  Created by MAC241 on 28/03/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import Foundation
import UIKit

public protocol KJCircularSliderDelegate {
    
    func getPercentage(circularSliderInstance: KJCircularSlider, percentValue: Float)
}

@IBDesignable public class KJCircularSlider: UIView {
    
    // protocol
    public var KJCircularDelegate: KJCircularSliderDelegate?
    
    private let _pathLayer: CAShapeLayer = CAShapeLayer()   // circle path layer.
    private let _path: UIBezierPath = UIBezierPath()        // circle bezier path.
    private let circleLayer: CAShapeLayer = CAShapeLayer()
    
    private var pathPoints:[CGPoint] = []   // array holder of path points.
    private var pathPointsToCount = 0       // total number of path points in circle.
    private var handlePathPointIndex = 0    // Proposed index.
    
    private let handleView = UIView()       // Handler.
    
    // proposed point instance
    private var desiredHandleCenter: CGPoint = CGPoint(x: 0, y: 0)
    
    // Selected area layer
    private let _pathSecoundaryLayer: CAShapeLayer = CAShapeLayer()
    
    // Label to show number of percentage
    private let labelPercentageOfSelection: UILabel = UILabel()
    
    // Public variables
    public var showPrecision = true
    public var sliderColor: UIColor {
        get {
            return self.sliderColor
        }
        set {
            _pathLayer.strokeColor = newValue.cgColor
        }
    }
    public var sliderWidth: Float {
        get {
            return self.sliderWidth
        }
        set {
            _pathLayer.lineWidth = CGFloat(newValue)
        }
    }
    private var sliderSelectedAreaColorPrivate: UIColor = UIColor.red
    public var sliderSelectedAreaColor: UIColor {
        get {
            return self.sliderSelectedAreaColorPrivate
        }
        set {
            self.sliderSelectedAreaColorPrivate = newValue
            _pathSecoundaryLayer.strokeColor = newValue.cgColor
        }
    }
    private var sliderSelectedWidthPrivate: Float = 2.0
    public var sliderSelectedAreaWidth: Float {
        get {
            return self.sliderSelectedWidthPrivate
        }
        set {
            self.sliderSelectedWidthPrivate = newValue
            _pathSecoundaryLayer.lineWidth = CGFloat(newValue)
        }
    }
    private var sliderCapColorPrivate = UIColor.red
    public var sliderCapColor: UIColor {
        get {
            return sliderCapColorPrivate
        }
        set {
            sliderCapColorPrivate = newValue
            circleLayer.strokeColor = newValue.cgColor
        }
    }
    public var sliderCapFillColor: Bool {
        get {
            return self.sliderCapFillColor
        }
        set {
            if newValue {
                circleLayer.fillColor = self.sliderCapColor.cgColor
            }else{
                circleLayer.fillColor = nil
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let recognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        handleView.addGestureRecognizer(recognizer)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Initial path layer support
        self.initPathLayer()
        self.initHandleView()
        self.createPath()
    }
    
    private func initPathLayer() {
        _pathLayer.lineWidth = 2.0
        _pathLayer.fillColor = nil
        _pathLayer.strokeColor = UIColor.black.cgColor
        self.layer.addSublayer(_pathLayer)
    }
    
    private func initHandleView(){
        let radius: Double = Double(bounds.size.height/10)
        let rect: CGRect = CGRect(x: 0, y: 0, width: radius, height: radius)
        circleLayer.fillColor = nil
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 2
        circleLayer.path = UIBezierPath(ovalIn: rect).cgPath
        circleLayer.frame = rect
        
        handleView.frame = rect
        handleView.layer.addSublayer(circleLayer)
        self.addSubview(handleView)
    }
    
    private func createPath() {
        let bounds = self.bounds
        
        // Double(bounds.size.height/10) - it's a radius of circle to be scrolled by gesture
        let radius: Double = Double(bounds.size.height/2) - Double(bounds.size.height/10) // Radius of circle will be 16.67% of height area of your view.
        let topCenter = CGPoint(x: bounds.midX, y: bounds.midY) // What center you want in self.view
        _path.addArc(withCenter: topCenter, radius: CGFloat(radius), startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI - 0.01), clockwise: true)
        _path.close()
        self.createPathPoints()
        
        _pathLayer.path = _path.cgPath
        self.setNeedsLayout()
        
        self.layoutHandleView()
        
        // percentage label
        labelPercentageOfSelection.frame = CGRect(x: 0, y: 0, width: radius, height: radius)
        labelPercentageOfSelection.center = topCenter
        print("Radius: \(radius)")
        let finalFontSize = radius <= 100 ? radius <= 50 ? 0 : 100 : radius
        labelPercentageOfSelection.font = UIFont(name: "HelveticaNeue", size: CGFloat(finalFontSize/6))
        labelPercentageOfSelection.textAlignment = NSTextAlignment.center
        labelPercentageOfSelection.text = "0%"
        self.addSubview(labelPercentageOfSelection)
    }
    
    private func createPathPoints() {
        
        let pathDashed: CGPath = _path.cgPath.copy(dashingWithPhase: 0, lengths: [1.0,5.0]) // Convert UIBezierPath to CGPath with dashed lines.
        // print(pathDashed.getPathElementsPoints())
        pathPoints = pathDashed.getPathElementsPoints()
        pathPointsToCount = pathPoints.count
    }
    
    private func layoutHandleView() {
        
        // get index to pick CGPoint from pathPoints, where exactly handler will be set to center.
        handlePathPointIndex = self.handlePathPointIndexWithOffset(integerOffset: 0)
        
        /*
         Selection layer added in self layer.
         */
        // print("Total count of indexes: \(pathPointsToCount)")
        // Remove _pathSecoundaryLayer from superview, so we will add a new one with new values.
        _pathSecoundaryLayer.removeFromSuperlayer()
        let pathBasedOnPoints = CGMutablePath()
        let range: NSRange = NSMakeRange(pathPoints.startIndex, handlePathPointIndex+1)
        let arrayUpToPoints:[CGPoint] = self.subArray(array: pathPoints, range: range) // Create an array by providing range from starting index of pathPoints to index up to where it scrolled.
        pathBasedOnPoints.addLines(between: arrayUpToPoints)    // add new array of points to pathBasedOnPoints.
        _pathSecoundaryLayer.path = pathBasedOnPoints           // add above path
        _pathSecoundaryLayer.lineWidth = CGFloat(self.sliderSelectedAreaWidth)
        _pathSecoundaryLayer.fillColor = nil
        _pathSecoundaryLayer.strokeColor = self.sliderSelectedAreaColor.cgColor
        self.layer.addSublayer(_pathSecoundaryLayer)
        
        
        var percent = Float(handlePathPointIndex * 100) / Float(pathPointsToCount)
        if percent != 0{
            if handlePathPointIndex+1 == pathPointsToCount {
                percent = 100
            }
            labelPercentageOfSelection.text = "\(showPrecision ? percent.format(f: ".2") : percent.format(f: ".0"))%"
            
            KJCircularDelegate?.getPercentage(circularSliderInstance: self, percentValue: (labelPercentageOfSelection.text?.floatValue())!)
        }
        
        // Set center based on CGPoint you got.
        handleView.center = _pathLayer.convert(pathPoints[handlePathPointIndex], to: self.layer) // Convert fetches CGPoint position in self layer based on CGPoint other layer values you provided.
        
        self.bringSubview(toFront: handleView)
    }
    
    private func subArray<T>(array: [T], range: NSRange) -> [T] {
        if range.location > array.count {
            return []
        }
        return Array(array[range.location..<min(range.length, array.count)])
    }
    
    private func handlePathPointIndexWithOffset(integerOffset: NSInteger) -> NSInteger {
        // print("handlePathPointIndex_: \(handlePathPointIndex_) & integerOffset: \(integerOffset)")
        var index = handlePathPointIndex + integerOffset
        while index < 0 {
            index += pathPointsToCount
        }
        while index >= pathPointsToCount {
            index -= pathPointsToCount
        }
        return index
    }
    
    
    // Handle panned
    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        // print("panned")
        switch gestureRecognizer.state {
        case .began:
            desiredHandleCenter = handleView.center
            break
        case .changed, .ended, .cancelled:
            // print("Monitoring gesture movement")
            let translation = gestureRecognizer.translation(in: self)
            // print("Translation: \(translation)")
            desiredHandleCenter.x += translation.x
            desiredHandleCenter.y += translation.y
            // print("Desired handle: \(desiredHandleCenter_)")
            self.moveHandleTowardPoint(point: desiredHandleCenter)
            break
        default: break
            
        }
        
        gestureRecognizer.setTranslation(CGPoint.zero, in: self)
    }
    
    private func moveHandleTowardPoint(point: CGPoint) {
        let earlierDistance = self.distanceToPoint(point: point, ifHandleMovesByOffSet: -1)
        // print("earlier distance: \(earlierDistance)")
        let currentDistance = self.distanceToPoint(point: point, ifHandleMovesByOffSet: 0)
        // print("current distance: \(currentDistance)")
        let laterDistance = self.distanceToPoint(point: point, ifHandleMovesByOffSet: 1)
        // print("later distance: \(laterDistance)")
        
        if currentDistance <= earlierDistance && currentDistance <= laterDistance {
            return
        }
        
        var direction = 0
        var distance: CGFloat = 0.0
        if earlierDistance < laterDistance {
            direction = -1
            distance = earlierDistance
        }else{
            direction = 1
            distance = laterDistance
        }
        
        var offSet = direction
        while true {
            let nextOffSet = offSet + direction
            // print(nextOffSet)
            let nextDistance = self.distanceToPoint(point: point, ifHandleMovesByOffSet: nextOffSet)
            if nextDistance >= distance {
                break;
            }
            distance = nextDistance
            offSet = nextOffSet
        }
        
        handlePathPointIndex += offSet
        self.layoutHandleView()
    }
    
    private func distanceToPoint(point: CGPoint, ifHandleMovesByOffSet offSet: NSInteger) -> CGFloat {
        let index = self.handlePathPointIndexWithOffset(integerOffset: offSet)
        // print("proposed index: \(index)")
        let proposedHandlePoint = pathPoints[index]
        return hypot(point.x - proposedHandlePoint.x, point.y - proposedHandlePoint.y)
    }
    
    
}

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension String {
    func floatValue() -> Float {
        return (self as NSString).floatValue
    }
}


extension CGPath {
    
    func forEach( body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        // print(MemoryLayout.size(ofValue: body))
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }
    
    
    func getPathElementsPoints() -> [CGPoint] {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
            default: break
            }
        }
        return arrayPoints
    }
    
    func getPathElementsPointsAndTypes() -> ([CGPoint],[CGPathElementType]) {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        var arrayTypes : [CGPathElementType]! = [CGPathElementType]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            default: break
            }
        }
        return (arrayPoints,arrayTypes)
    }
}
