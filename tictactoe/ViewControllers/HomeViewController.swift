//
//  HomeViewController.swift
//  tictactoe
//
//  Created by Steve Cooper on 5.07.2021.
//

import UIKit

class HomeViewController: UIViewController {

    
    var viewModel: HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = HomeViewModel()
    }

    @IBAction func startGame(_ sender: UIButton) {
        viewModel.startGame(at: sender.tag)
    }
    
    
    
    
}



extension HomeViewController: HomeViewModelDelegate {
    func startGame(diffucult: GameDifficult) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameBoardViewController") as! GameBoardViewController
        vc.modalPresentationStyle = .fullScreen
        vc.gameDiffucultLevel = diffucult
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
