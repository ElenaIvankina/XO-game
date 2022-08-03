//
//  GameEnd5StepsState.swift
//  XO-game
//
//  Created by Елена Иванкина on 25.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameEnd5StepsState: GameState {
    var isMoveCompleted: Bool = false
    
    public let winnerPlayer: Player?
    weak var gameViewControler: GameViewController?
    
    init(winnerPlayer: Player?, gameViewControler: GameViewController) {
        self.winnerPlayer = winnerPlayer
        self.gameViewControler = gameViewControler
    }
    
    func addSign(at position: GameboardPosition) {}
    
    func begin() {
        DispatchQueue.main.async {
            self.gameViewControler?.winnerLabel.isHidden = false
            
            if let winnerPlayer = self.winnerPlayer {
                self.gameViewControler?.winnerLabel.text = self.setPlayerName(player: winnerPlayer) + " won"
            } else {
                self.gameViewControler?.winnerLabel.text = "No winner/Draw"
            }
            
            self.gameViewControler?.firstPlayerTurnLabel.isHidden = true
            self.gameViewControler?.secondPlayerTurnLabel.isHidden = true
        }

    }
    
    private func setPlayerName(player: Player) -> String {
        switch player {
        case .first:
            return "First"
        case .second:
            return "Second"
        }
    }
    
}

