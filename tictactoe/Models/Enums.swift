//
//  Enums.swift
//  tictactoe
//
//  Created by Steve Cooper on 5.07.2021.
//

import Foundation


enum GameDifficult {
    case easy
    case medium
    case hard
}

enum Players {
    case ai
    case player
    case empty
}

struct Move {
    let player: Players
    let moveIndex: Int
}
