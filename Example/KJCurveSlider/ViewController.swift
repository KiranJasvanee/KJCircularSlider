//
//  ViewController.swift
//  KJCurveSlider
//
//  Created by KiranJasvanee on 03/01/2017.
//  Copyright (c) 2017 KiranJasvanee. All rights reserved.
//

import UIKit
import KJCurveSlider

class ViewController: UIViewController, KJCurveSliderDelegate {
    
    @IBOutlet weak var curveSliderLarge: KJCurveSlider!
    @IBOutlet weak var curveSliderMedium: KJCurveSlider!
    @IBOutlet weak var curveSliderSmall: KJCurveSlider!
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
        curveSliderLarge.KJCurveDelegate = self
        
        // Medium one
        curveSliderMedium.sliderSelectedAreaColor = UIColor.red
        curveSliderMedium.sliderSelectedAreaWidth = 5.0
        
        // Smaller one
        curveSliderSmall.showPrecision = false
        curveSliderSmall.KJCurveDelegate = self
        curveSliderSmall.sliderSelectedAreaColor = UIColor(red: 255.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        curveSliderSmall.sliderSelectedAreaWidth = 5.0
        labelPercentForSmallerCurveSlider.text = "0%"
        labelPercentForSmallerCurveSlider.font = UIFont(name: "HelveticaNeue", size: 15)
    }

    func getPercentage(curveSliderInstance: KJCurveSlider, percentValue: Float) {
        
        // access of specific small slider values
        if curveSliderInstance == curveSliderSmall {
            labelPercentForSmallerCurveSlider.text = "\(percentValue)%"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

