//
//  LifeGameViewController.swift
//  SwitchAlgorithm
//
//  Created by 佐川晴海 on 2019/05/09.
//  Copyright © 2019 佐川晴海. All rights reserved.
//

import UIKit

class LifeGameViewController: UIViewController {
    let fieldWidth:Int = 7
    let fieldHeigh:Int = 22
    var mySwitch:[[UISwitch]] = []
    var switchAlive: [[Bool]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addItems()
    }
    
    func addItems(){
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        for x in 0..<fieldWidth{
            for y in 0..<fieldHeigh{
                let tempSwitch: UISwitch = {
                    let mSwitch = UISwitch()
                    let dispSize: CGSize = CGSize(width: viewWidth/7,
                                                  height:viewHeight/25)
                    let scaleX: CGFloat = dispSize.width / mSwitch.bounds.size.width
                    let scaleY: CGFloat = dispSize.height / mSwitch.bounds.size.height
                    mSwitch.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                    mSwitch.layer.position = CGPoint(x: CGFloat(x)*mSwitch.layer.frame.width+mSwitch.layer.frame.width/2, y: CGFloat(y)*mSwitch.layer.frame.height+mSwitch.layer.frame.height/2)
                    return mSwitch
                }()
                self.view.addSubview(tempSwitch)
                //配列の中に格納
                if(mySwitch.indices.contains(x)){
                    //配列が存在する場合
                    mySwitch[x].append(tempSwitch)
                    switchAlive[x].append(false)
                }else{
                    //配列が存在しない場合
                    mySwitch.append([tempSwitch])
                    switchAlive.append([false])
                }
            }
            let lifeChangeButton: UIButton = {
                let button = UIButton()
                button.layer.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight/25 - (viewHeight/25 * 3))
                button.layer.position = CGPoint(x: button.frame.width/2, y: viewHeight - viewHeight/25 * 3 + button.frame.height/2)
                button.setTitle("次の世代へ", for: .normal)
                button.backgroundColor = .red
                button.addTarget(self, action: #selector(changeGeneration), for: .touchUpInside)
                return button
            }()
            self.view.addSubview(lifeChangeButton)
        }
    }
    
    @objc func changeGeneration(_ sendor: UIButton){
        for x in 0..<fieldWidth{
            for y in 0..<fieldHeigh{
                let n = getAdjustCount(_x: x, _y: y)
                //booleannの中の書き換え
                switchAlive[x][y] = mySwitch[x][y].isOn
                if(mySwitch[x][y].isOn){
                    //過疎または過密であればセルは死ぬ
                    if(n <= 1 || 4 <= n){
                        switchAlive[x][y] = false
                    }
                }else{
                    if(n == 3){
                        switchAlive[x][y] = true
                    }
                }
            }
        }
        //生死の書き換え
        for x in 0..<fieldWidth{
            for y in 0..<fieldHeigh{
                mySwitch[x][y].isOn = switchAlive[x][y]
            }
        }
    }
    
    func getAdjustCount(_x: Int, _y: Int) -> Int{
        var count = 0
        
        for x in -1...1{
            for y in -1...1{
                //真ん中は自分なので考慮しない
                if(x==0 && y==0){continue}
                //あまりで求めないと配列の範囲外を参照してしまう恐れがある。
                let x2 = (fieldWidth + x + _x) % fieldWidth
                let y2 = (fieldHeigh + y + _y) % fieldHeigh
                if(mySwitch[x2][y2].isOn){
                    count += 1
                }
            }
        }
        return count
    }
}
