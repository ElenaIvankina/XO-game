//
//  GameModeStrategyAgainstComputer.swift
//  XO-game
//
//  Created by Елена Иванкина on 21.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class GameModeStrategyAgainstComputer: GameModeStrategy {
    
    func firstTurn(gameViewController: GameViewController) {
        let firstPlayer: Player = .first
        gameViewController.currentState = PlayerComputerGameState (player: firstPlayer,
                                                          gameViewControler: gameViewController,
                                                          gameBoard: gameViewController.gameBoard,
                                                          gameboardView: gameViewController.gameboardView,
                                                          markViewPrototype: firstPlayer.markViewPrototype)
        
    }
    
    func nextTurn(gameViewController: GameViewController){
        if let winner = gameViewController.referee.determineWinner() {
            gameViewController.currentState = GameComputerEndState(winnerPlayer: winner, gameViewControler: gameViewController)
            Logger.shared.log(action: .gameFinished(winner: winner))
            return
        }
        
        if gameViewController.counter >= 9 {
            Logger.shared.log(action: .gameFinished(winner: nil))
            gameViewController.currentState = GameComputerEndState(winnerPlayer: nil, gameViewControler: gameViewController)
            return
        }
        
        if let playerState = gameViewController.currentState as? PlayerComputerGameState {
            let nextPlayer = playerState.player.next
            gameViewController.currentState = PlayerComputerGameState (player: nextPlayer,
                                                              gameViewControler: gameViewController,
                                                              gameBoard: gameViewController.gameBoard,
                                                              gameboardView: gameViewController.gameboardView,
                                                              markViewPrototype: nextPlayer.markViewPrototype)
        }
    }
    
    
}
