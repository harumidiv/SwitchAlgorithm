//
//  RandomWalkViewController.swift
//  SwitchAlgorithm
//
//  Created by 佐川晴海 on 2019/05/09.
//  Copyright © 2019 佐川晴海. All rights reserved.
//

import UIKit

class RandomWalkViewController: UIViewController {
    var mSwitch:UISwitch?
    var runners:[UISwitch] = []
    
    var moveTimer = true
    var x:[CGFloat] = []
    var y:[CGFloat] = []
    var timer:Timer!
    var scaleX:CGFloat!
    var scaleY:CGFloat!
    var rotate =  CGAffineTransform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RandomWalk"
        
        self.view.backgroundColor = .black
        self.view.isMultipleTouchEnabled = true
        
        for _ in 0..<500{
            let tempSwitch = UISwitch()
            scaleX = 10/tempSwitch.bounds.size.width
            scaleY = 5/tempSwitch.bounds.size.height
            tempSwitch.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            tempSwitch.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
            self.view.addSubview(tempSwitch)
            
            x.append(self.view.frame.width/2)
            y.append(self.view.frame.height/2)
            runners.append(tempSwitch)
            
        }
        
        repeatTimer()
    }
    func repeatTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(walk), userInfo: nil, repeats: true)
    }
    @objc func walk(sender: Timer){
        for  (count, runnner) in runners.enumerated() {
            let addX:CGFloat = CGFloat.random(in: -3...3)
            let addY:CGFloat = CGFloat.random(in: -3...3)
            x[count] = x[count] + addX
            y[count] = y[count] + addY
            
            var angle:CGFloat!
            if(addX > 0 && addY > 0){
                angle = -45*CGFloat.pi/180
                rotate = CGAffineTransform(rotationAngle: angle)
                
            }else if(addX > 0 && addY < 0){
                angle = 45*CGFloat.pi/180
                rotate = CGAffineTransform(rotationAngle: angle)
            }else if(addX < 0 && addY < 0){
                angle = 135*CGFloat.pi/180
                rotate = CGAffineTransform(rotationAngle: angle)
            }else if(addX < 0 && addY > 0){
                angle = -135*CGFloat.pi/180
                rotate = CGAffineTransform(rotationAngle: angle)
            }
            
            
            runnner.transform = rotate.concatenating(CGAffineTransform(scaleX: scaleX, y: scaleY))
            runnner.layer.position = CGPoint(x: x[count], y: y[count])
            self.view.addSubview(runnner)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        var touch:[UITouch] = []
        
        for t:UITouch in touches{
            touch.append(t)
        }
        var posX:[CGFloat] = []
        var posY:[CGFloat] = []
        for pos in touch{
            posX.append(pos.location(in: self.view).x)
            posY.append(pos.location(in: self.view).y)
        }
        
        switch touch.count {
        case 1:
            
            for(i, runner) in runners.enumerated() {
                x[i] = posX[0]
                y[i] = posY[0]
                runner.layer.position = CGPoint(x:posX[0], y: posY[0])
                self.view.addSubview(runner)
            }
            
            break
        case 2:
            for(i, runner) in runners.enumerated() {
                if i % 2 == 0 {
                    x[i] = posX[0]
                    y[i] = posY[0]
                    runner.layer.position = CGPoint(x:posX[0], y: posY[0])
                    self.view.addSubview(runner)
                    continue
                }
                x[i] = posX[1]
                y[i] = posY[1]
                runner.layer.position = CGPoint(x:posX[1], y: posY[1])
                self.view.addSubview(runner)
            }
        case 3:
            for(i, runner) in runners.enumerated() {
                if i % 3 == 0 {
                    x[i] = posX[2]
                    y[i] = posY[2]
                    runner.layer.position = CGPoint(x:posX[2], y: posY[2])
                    self.view.addSubview(runner)
                    continue
                }
                if i % 2 == 0 {
                    x[i] = posX[1]
                    y[i] = posY[1]
                    runner.layer.position = CGPoint(x:posX[1], y: posY[1])
                    self.view.addSubview(runner)
                    continue
                }
                x[i] = posX[0]
                y[i] = posY[0]
                runner.layer.position = CGPoint(x:posX[0], y: posY[0])
                self.view.addSubview(runner)
            }
        default:
            break
        }
        timer.invalidate()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        repeatTimer()
    }
}
