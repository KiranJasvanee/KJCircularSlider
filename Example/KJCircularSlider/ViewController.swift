//
//  ViewController.swift
//  KJCurveSlider
//
//  Created by KiranJasvanee on 03/01/2017.
//  Copyright (c) 2017 KiranJasvanee. All rights reserved.
//

import UIKit
import KJCircularSlider

class ViewController: UIViewController, KJCircularSliderDelegate {
    
    @IBOutlet weak var curveSliderLarge: KJCircularSlider!
    @IBOutlet weak var curveSliderMedium: KJCircularSlider!
    @IBOutlet weak var curveSliderSmall: KJCircularSlider!
    @IBOutlet weak var labelPercentForSmallerCurveSlider: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Larger one
        curveSliderLarge.showPrecision = true
        curveSliderLarge.sliderWidth = 2.0
        curveSliderLarge.sliderColor = UIColor.black
        curveSliderLarge.sliderSelectedAreaColor = UIColor.orange
        curveSliderLarge.sliderSelectedAreaWidth = 10.0
        curveSliderLarge.sliderCapColor = UIColor.green
        curveSliderLarge.sliderCapFillColor = true
        curveSliderLarge.KJCircularDelegate = self
        
        // Medium one
        curveSliderMedium.sliderSelectedAreaColor = UIColor.red
        curveSliderMedium.sliderSelectedAreaWidth = 5.0
        
        // Smaller one
        curveSliderSmall.showPrecision = false
        curveSliderSmall.KJCircularDelegate = self
        curveSliderSmall.sliderSelectedAreaColor = UIColor(red: 255.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        curveSliderSmall.sliderSelectedAreaWidth = 5.0
        labelPercentForSmallerCurveSlider.text = "0%"
        labelPercentForSmallerCurveSlider.font = UIFont(name: "HelveticaNeue", size: 15)
    }

    func getPercentage(circularSliderInstance: KJCircularSlider, percentValue: Float) {
        
        // access of specific small slider values
        if circularSliderInstance == curveSliderSmall {
            labelPercentForSmallerCurveSlider.text = "\(percentValue)%"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

