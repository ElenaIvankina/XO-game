//
//  PlayerComputerGameState.swift
//  XO-game
//
//  Created by Елена Иванкина on 21.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//
//

import Foundation

class PlayerComputerGameState: GameState {
    var isMoveCompleted: Bool = false
    let player: Player!
    weak var gameViewControler: GameViewController?
    var gameBoard: Gameboard
    var gameBoardView: GameboardView
    var markViewPrototype: MarkView
    
    init(player: Player?, gameViewControler: GameViewController,
         gameBoard: Gameboard,
         gameboardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewControler = gameViewControler
        self.gameBoard = gameBoard
        self.gameBoardView = gameboardView
        self.markViewPrototype = markViewPrototype
    }
    
    func addSign(at position: GameboardPosition) {
        guard !isMoveCompleted else { return }
        
//        let markView = player == .first ? XView() : OView()
        switch player {
             case .first:
             gameViewControler?.gameboardView.placeMarkView(markViewPrototype, at: position)
             gameViewControler?.gameBoard.setPlayer(player, at: position)
             case .second:
             autoPlaceMark(markViewPrototype: markViewPrototype, player: player)
             default:
                 break
             }
             Logger.shared.log(action: .playerSetMarkView(player: player, position: position))
        
        isMoveCompleted = true
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewControler?.firstPlayerTurnLabel.isHidden = false
            gameViewControler?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewControler?.firstPlayerTurnLabel.isHidden = true
            gameViewControler?.secondPlayerTurnLabel.text = "Computer"
            gameViewControler?.secondPlayerTurnLabel.isHidden = false
        case .none:
            break
        }
        
        gameViewControler?.winnerLabel.isHidden = true
    }
    
        private func autoPlaceMark (markViewPrototype: MarkView, player: Player) {
    
            guard let gameViewController = self.gameViewControler else {return}
            let arrayPosition: [GameboardPosition] = [GameboardPosition(column: 0, row: 0),
                                                      GameboardPosition(column: 0, row: 1),
                                                      GameboardPosition(column: 0, row: 2),
                                                      GameboardPosition(column: 1, row: 0),
                                                      GameboardPosition(column: 1, row: 1),
                                                      GameboardPosition(column: 1, row: 2),
                                                      GameboardPosition(column: 2, row: 0),
                                                      GameboardPosition(column: 2, row: 1),
                                                      GameboardPosition(column: 2, row: 2)]
    
            for i in 0...(arrayPosition.count-1) {
                let position = arrayPosition [i]
    
                if gameViewController.gameboardView.canPlaceMarkView(at: position) {
                    gameViewControler?.gameboardView.placeMarkView(markViewPrototype, at: position)
                    gameViewControler?.gameBoard.setPlayer(player, at: position)
                    break
                }
            }
    
        }
    
    
}
