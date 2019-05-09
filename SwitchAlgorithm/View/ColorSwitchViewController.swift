//
//  ColorSwitchViewController.swift
//  SwitchAlgorithm
//
//  Created by 佐川晴海 on 2019/05/09.
//  Copyright © 2019 佐川晴海. All rights reserved.
//

import UIKit

class ColorSwitchViewController: UIViewController {

    var red: CGFloat = 125/255
    var blue: CGFloat = 125/255
    var green: CGFloat = 125/255
    var timer:Timer!
    
    var colorSwitch = UISwitch()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color"
        
        colorSwitch.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        let scaleX = self.view.frame.width/colorSwitch.bounds.size.width
        let scaleY = self.view.frame.height/colorSwitch.bounds.size.height
        let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let rotate = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
        colorSwitch.transform = rotate.concatenating(scale)
        colorSwitch.onTintColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        self.view.addSubview(colorSwitch)
        repeatTimer()
    }
    func repeatTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(colorChange), userInfo: nil, repeats: true)
    }
    @objc func colorChange(sender: Timer){
        red = red + CGFloat.random(in: 0 ... 3)/255
        green = green + CGFloat.random(in: 0 ... 0.03)
        blue = blue + CGFloat.random(in: 0 ... 0.03)
        
        if red > 1.0 || green > 1.0 || blue > 1.0 {
            red = CGFloat.random(in: 0 ... 255)/255
            blue = CGFloat.random(in: 0 ... 255)/255
            green = CGFloat.random(in: 0 ... 255)/255
        }
        
        self.view.backgroundColor = UIColor(red: 1.0-red, green: 1.0-blue, blue: 1.0-green, alpha: 1.0)
        colorSwitch.onTintColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        self.view.addSubview(colorSwitch)
    }
    
}
