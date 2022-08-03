//
//  GameModeStrategy5Steps2Players.swift
//  XO-game
//
//  Created by Елена Иванкина on 25.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class GameModeStrategy5Steps2Players: GameModeStrategy {
    
    var numberOfSteps = 0
    
    func firstTurn(gameViewController: GameViewController) {
        let firstPlayer: Player = .first
    
            gameViewController.currentState = PlayerGame5StepsState(player: firstPlayer,
                                                              gameViewControler: gameViewController,
                                                              gameBoard: gameViewController.gameBoard,
                                                              gameboardView: gameViewController.gameboardView,
                                                              markViewPrototype: firstPlayer.markViewPrototype)
            numberOfSteps += 1
        
    }
    
    func nextTurn(gameViewController: GameViewController){
        
        if let playerState = gameViewController.currentState as? PlayerGame5StepsState {
            var nextPlayer: Player = .first
            if numberOfSteps >= 5 {
                nextPlayer = .second
            }
                gameViewController.currentState = PlayerGame5StepsState(player: nextPlayer,
                                                                  gameViewControler: gameViewController,
                                                                  gameBoard: gameViewController.gameBoard,
                                                                  gameboardView: gameViewController.gameboardView,
                                                                  markViewPrototype: nextPlayer.markViewPrototype)

        }
        numberOfSteps += 1

    }
}

