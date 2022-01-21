//
//  Game.swift
//  tictactoe
//
//  Created by Steve Cooper on 5.07.2021.
//

import Foundation


class Game {
    
    var gameDifficultLevel: GameDifficult?
    let gameBoard:[[Players]] = [[.empty, .empty, .empty],[.empty, .empty, .empty],[.empty, .empty, .empty]]
    var moves:[Move] = Array(repeating: Move(player: .empty, moveIndex: -1), count: 9)
    let winPatterns : Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    init() {
        
    }
}


extension Game {
    
    func checkForHaveAnyWinner(moves: [Move], player: Players) -> Bool {
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPotions = Set(playerMoves.map { $0.moveIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPotions) { return true }
        
        return false
    }
    
    func checkSquareIsEmpty(moves:[Move], at index: Int) -> Bool {
        return moves[index].player == .empty
    }
    
}
