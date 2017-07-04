//
//  ViewController.swift
//  gaugetest
//
//  Created by Jussi Kuosa on 04/07/2017.
//  Copyright © 2017 Jussi Kuosa. All rights reserved.
//

import UIKit
import GaugeView

class ViewController: UIViewController {

    @IBOutlet weak var gaugeView: GaugeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gaugeView.percentage = 80
        gaugeView.thickness = 5
        gaugeView.labelText = "80%"
        gaugeView.labelFont = UIFont.systemFont(ofSize: 40, weight: UIFontWeightThin)
        gaugeView.labelColor = UIColor.lightGray
        gaugeView.gaugeBackgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

