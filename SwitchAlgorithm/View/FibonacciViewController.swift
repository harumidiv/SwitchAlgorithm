//
//  FibonacciViewController.swift
//  SwitchAlgorithm
//
//  Created by 佐川晴海 on 2019/05/17.
//  Copyright © 2019 佐川晴海. All rights reserved.
//

import UIKit

class FibonacciViewController: UIViewController {
    lazy var point = CGPoint(x: 100, y:  50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<90 {
            let digits = checkDigits(num: fibo(number: i))
            for j in 0...digits {
                addSwitch(count: i, digit: j)
            }
        }
    }
    func checkDigits(num: Int) -> Int {
        var digit = 0
        var value = num
        while(value > 10){
            value = value / 10;
            digit = digit + 1
        }
        return digit
    }
    func rec(f2:Int, f1:Int, n:Int) -> Int{
        if n == 1{
            return f1
        }
        return rec(f2: f1, f1: f2+f1, n: n-1)
    }
    func fibo(number n:Int) -> Int{
        return n < 2 ? n: rec(f2: 0, f1: 1, n: n)
    }
    
    func addSwitch(count: Int,digit: Int){
        let swith = UISwitch()
        let scaleX = 12/swith.bounds.size.width
        let scaleY = 8/swith.bounds.size.height
        swith.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        swith.isOn = true
        swith.layer.position = CGPoint(x: point.x + swith.frame.width * CGFloat(digit), y: point.y + swith.frame.height * CGFloat(count))
        self.view.addSubview(swith)
    }
}
