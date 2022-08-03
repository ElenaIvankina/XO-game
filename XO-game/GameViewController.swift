//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    var counter: Int = 0
    public let gameBoard = Gameboard()
    lazy var referee = Referee(gameboard: gameBoard)
    
    var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    var gameModeStrategy: GameModeStrategy = GameModeStrategyAgainstComputer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FiveStepsInvoker.shared.gameViewController = self
        
        gameModeStrategy.firstTurn(gameViewController: self)
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.currentState.addSign(at: position)
            self.counter += 1
            if self.currentState.isMoveCompleted {
                self.gameModeStrategy.nextTurn(gameViewController: self)
            }
            
        }
    }
    
    private func restartGame() {
        gameboardView.clear()
        gameBoard.clear()
        counter = 0
        FiveStepsInvoker.shared.commands = []
        if gameModeStrategy is GameModeStrategy5Steps2Players {
            gameModeStrategy = GameModeStrategy5Steps2Players()
        }
        gameModeStrategy.firstTurn(gameViewController: self)
        
        Logger.shared.log(action: .restartGame)
        
    }
    
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        restartGame()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "StrategyVC":
            if let destinationVC = segue.destination as? StrategyViewController {
                destinationVC.delegate = self
            }
        default:
            break
        }
    }
    
    @IBAction func changeStrategyButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "StrategyVC", sender: nil)
    }
    
}

extension GameViewController: strategyDelegate {
    func chooseStrategy(strategy: Strategy) {
        switch strategy {
        case .twoPlayers:
            self.gameModeStrategy = GameModeStrategyAgainst2ndPlayer()
        case .twoPlayers5Steps:
            self.gameModeStrategy = GameModeStrategy5Steps2Players()
        case .playerVSComputer:
            self.gameModeStrategy = GameModeStrategyAgainstComputer()
        }
        restartGame()
        
    }
    
}

