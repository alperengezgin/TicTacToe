//
//  HomeViewModel.swift
//  tictactoe
//
//  Created by Steve Cooper on 5.07.2021.
//


protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? {get set}
    func startGame(at index: Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func startGame(diffucult: GameDifficult)
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
}


extension HomeViewModel: HomeViewModelProtocol {
    func startGame(at index: Int) {
        if index == 0 {
            delegate?.startGame(diffucult: .easy)
        } else if index == 1 {
            delegate?.startGame(diffucult: .medium)
        } else {
            delegate?.startGame(diffucult: .hard)
        }
    }
    
    
}
