//
//  PlayerGame5StepsState.swift
//  XO-game
//
//  Created by Елена Иванкина on 25.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerGame5StepsState: GameState {
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
        Logger.shared.log(action: .playerSetMarkView(player: player, position: position))
        
//        gameViewControler?.gameboardView.placeMarkView(markViewPrototype, at: position)
//        gameViewControler?.gameBoard.setPlayer(player, at: position)
//        sleep(2)
//        gameViewControler?.gameboardView.removeMarkView(at: position)
//        gameViewControler?.gameBoard.positions[position.column][position.row] = nil

        let fiveStepsCommandSetPlayerAndPlaceMarkView = FiveStepsCommandSetPlayerAndPlaceMarkView(gameBoard: gameBoard, gameBoardView: gameBoardView, player: player, position: position)
        
        FiveStepsInvoker.shared.addCommand(command: fiveStepsCommandSetPlayerAndPlaceMarkView)
        
        isMoveCompleted = true
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewControler?.firstPlayerTurnLabel.isHidden = false
            gameViewControler?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewControler?.secondPlayerTurnLabel.text = "2nd player"
            gameViewControler?.firstPlayerTurnLabel.isHidden = true
            gameViewControler?.secondPlayerTurnLabel.isHidden = false
        case .none:
            break
        }
        
        gameViewControler?.winnerLabel.isHidden = true
    }
    
    
}

