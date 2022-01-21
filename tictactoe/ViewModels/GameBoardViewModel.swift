//
//  GameBoardViewModel.swift
//  tictactoe
//
//  Created by Steve Cooper on 5.07.2021.
//

import Foundation

protocol GameBoardViewModelProtocol {
    var delegate: GameBoardDelegate? {get set}
    func playForPlayer(at index: Int)
    func playForAI()
    func checkGameAndTurn()
    func exitGame()
}

protocol GameBoardDelegate: AnyObject {
    func showGameOverScreen(winner: Players)
    func play()
    func exitGame()
    func lockPlayer()
    func unlockPlayer()
}

final class GameBoardViewModel {
    weak var delegate: GameBoardDelegate?
    let gameDiffucultLevel: GameDifficult?
    let game: Game!
    let aiPlayer: AIPlayer!
    var isPlayerTurn = true
    
    init(gameDifficultLevel: GameDifficult) {
        self.gameDiffucultLevel = gameDifficultLevel
        self.game = Game()
        self.aiPlayer = AIPlayer(difficultLevel: gameDifficultLevel)
        let random = Int.random(in: 0..<2)
        isPlayerTurn = (random == 0 ? false : true)
        if !isPlayerTurn  {
            delegate?.lockPlayer()
            playForAI()
        }
    }
}


extension GameBoardViewModel: GameBoardViewModelProtocol {
    
    func checkGameAndTurn() {
        
        
        
        if isPlayerTurn {
            if game.checkForHaveAnyWinner(moves: game.moves, player: .player) {
                delegate?.showGameOverScreen(winner: .player)
                return
            }
        } else {
            if game.checkForHaveAnyWinner(moves: game.moves, player: .ai) {
                delegate?.showGameOverScreen(winner: .ai)
                return
            }
        }
        
        
        if !game.moves.contains(where: {$0.player == .empty}) {
            delegate?.showGameOverScreen(winner: .empty)
            return
        }
       
        
        isPlayerTurn = !isPlayerTurn
        
        if isPlayerTurn {
            delegate?.unlockPlayer()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.playForAI()
            })
        }
        
    }
    
    
    func playForAI() {
        let aiPlayerSelection = aiPlayer.play(moves: game.moves)
        game.moves[aiPlayerSelection] = Move(player: .ai, moveIndex: aiPlayerSelection)
        delegate?.play()
        checkGameAndTurn()
    }
    
    func playForPlayer(at index: Int) {
        game.moves[index] = Move(player: .player, moveIndex: index)
        delegate?.play()
        delegate?.lockPlayer()
        checkGameAndTurn()
    }
    
    func exitGame() {
        delegate?.exitGame()
    }
    
}
