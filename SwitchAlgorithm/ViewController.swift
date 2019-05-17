//
//  ViewController.swift
//  SwitchAlgorithm
//
//  Created by 佐川晴海 on 2019/05/09.
//  Copyright © 2019 佐川晴海. All rights reserved.
//

import UIKit

enum ScleenType: String {
    case Color = "Color"
    case RandomWalk = "RandomWalk"
    case LifeGame = "LifeGame"
    case Fibonacci = "Fibonacci"
}

class ViewController: UIViewController {
   
    let item: [ScleenType] = [.Color,.RandomWalk, .LifeGame, .Fibonacci]

    override func loadView() {
        let tableView = UITableView()
        self.view = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        switch item[indexPath.row] {
        case .Color:
            self.navigationController?.pushViewController(ColorSwitchViewController(), animated: true)
        case .RandomWalk:
            self.navigationController?.pushViewController(RandomWalkViewController(), animated: true)
            break
        case .LifeGame:
            self.navigationController?.pushViewController(LifeGameViewController(), animated: true)
        case .Fibonacci:
            self.navigationController?.pushViewController(FibonacciViewController(), animated: true)
        }
    }
}
