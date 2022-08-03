//
//  GameModeStrategyAgainst2ndPlayer.swift
//  XO-game
//
//  Created by Елена Иванкина on 21.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

protocol GameModeStrategy: AnyObject {
    func firstTurn(gameViewController: GameViewController)
    func nextTurn(gameViewController: GameViewController)
    
}

class GameModeStrategyAgainst2ndPlayer: GameModeStrategy {
    
    func firstTurn(gameViewController: GameViewController) {
        let firstPlayer: Player = .first
        gameViewController.currentState = PlayerGameState(player: firstPlayer,
                                                          gameViewControler: gameViewController,
                                                          gameBoard: gameViewController.gameBoard,
                                                          gameboardView: gameViewController.gameboardView,
                                                          markViewPrototype: firstPlayer.markViewPrototype)
        
    }
    
    func nextTurn(gameViewController: GameViewController){
        if let winner = gameViewController.referee.determineWinner() {
            gameViewController.currentState = GameEndState(winnerPlayer: winner, gameViewControler: gameViewController)
            Logger.shared.log(action: .gameFinished(winner: winner))
            return
        }
        
        if gameViewController.counter >= 9 {
            Logger.shared.log(action: .gameFinished(winner: nil))
            gameViewController.currentState = GameEndState(winnerPlayer: nil, gameViewControler: gameViewController)
            return
        }
        
        if let playerState = gameViewController.currentState as? PlayerGameState {
            let nextPlayer = playerState.player.next
            gameViewController.currentState = PlayerGameState(player: nextPlayer,
                                                              gameViewControler: gameViewController,
                                                              gameBoard: gameViewController.gameBoard,
                                                              gameboardView: gameViewController.gameboardView,
                                                              markViewPrototype: nextPlayer.markViewPrototype)
        }
    }
}
