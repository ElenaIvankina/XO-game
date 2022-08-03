//
//  StrategyViewController.swift
//  XO-game
//
//  Created by Елена Иванкина on 24.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class StrategyViewController: UIViewController {
    
    var delegate: strategyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func strategy2PlayersTapped(_ sender: UIButton) {
        delegate?.chooseStrategy(strategy: .twoPlayers )
        dismiss(animated: true, completion: nil)
    }
    @IBAction func strategy2Players5StepsTapped(_ sender: UIButton) {
        delegate?.chooseStrategy(strategy: .twoPlayers5Steps )
        dismiss(animated: true, completion: nil)
    }
    @IBAction func strategyPlayerVSComputerTapped(_ sender: Any) {
        delegate?.chooseStrategy(strategy: .playerVSComputer)
        dismiss(animated: true, completion: nil)
    }
}

protocol strategyDelegate: AnyObject {
    func chooseStrategy(strategy: Strategy)
}
