//
//  ViewController.swift
//  SwitchAlgorithm
//
//  Created by 佐川晴海 on 2019/05/09.
//  Copyright © 2019 佐川晴海. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    let item: [ScleenType] = [.ColorSwitch, .LifeSwitch, .RandomWalk]

    override func loadView() {
        let tableView = UITableView()
        self.view = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "SwitchAlgorithm"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = item[indexPath.row].rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
extension ViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch item[indexPath.row] {
        case .ColorSwitch:
            let vc = ColorSwitchViewController()
            self.present(vc, animated: true, completion: nil)
        case .RandomWalk:
            break
        case .LifeSwitch:
            break
        }
    }
}

enum ScleenType: String {
    case ColorSwitch = "ColorSwitch"
    case RandomWalk = "RandomWalk"
    case LifeSwitch = "LifeSwitch"
}
