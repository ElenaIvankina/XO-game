//
//  5ЫеузыШтмщлу.swift
//  XO-game
//
//  Created by Елена Иванкина on 25.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class FiveStepsInvoker {
    
    static let shared = FiveStepsInvoker()
    var gameViewController: GameViewController!
    
    private init () {}
    
    var commands: [FiveStepsCommand] = []
    
    func addCommand(command: FiveStepsCommand) {
        self.commands.append(command)
        if commands.count == 10 {
            executeCommands()
        }
    }
    
    func executeCommands() {
        let queue = DispatchQueue(label: "SerialQueue")
        queue.async {
        for i in 0...4 {
                sleep(1)
                self.commands[i].execute()
                sleep(1)
                self.commands[i+5].execute()
        }
            if let winner = self.gameViewController.referee.determineWinner() {
                self.gameViewController.currentState = GameEnd5StepsState(winnerPlayer: winner, gameViewControler: self.gameViewController)
                   Logger.shared.log(action: .gameFinished(winner: winner))
                   return
            } else {
                Logger.shared.log(action: .gameFinished(winner: nil))
                self.gameViewController.currentState = GameEndState(winnerPlayer: nil, gameViewControler: self.gameViewController)
                return
            }
        }
    }
    
}
