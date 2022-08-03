//
//  5StepsCommand.swift
//  XO-game
//
//  Created by Елена Иванкина on 25.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol FiveStepsCommand {
    func execute()
}

class FiveStepsCommandSetPlayerAndPlaceMarkView: FiveStepsCommand {
    var gameBoard: Gameboard
    var gameBoardView: GameboardView
    var player: Player
    var position: GameboardPosition
    
    init(gameBoard: Gameboard, gameBoardView: GameboardView, player: Player, position: GameboardPosition) {
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.player = player
        self.position = position
    }
    
    func execute() {

        DispatchQueue.main.async {
            if !self.gameBoardView.canPlaceMarkView(at: self.position) {
                self.gameBoardView.removeMarkView(at: self.position)
            }
            if self.gameBoard.positions[self.position.column][self.position.row] != nil {
                self.gameBoard.positions[self.position.column][self.position.row] = nil
            }
            self.gameBoardView.placeMarkView(self.player.markViewPrototype, at: self.position)
            self.gameBoard.setPlayer(self.player, at: self.position)

        }
    }
}

