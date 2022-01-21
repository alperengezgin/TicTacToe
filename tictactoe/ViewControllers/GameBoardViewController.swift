//
//  GameBoardViewController.swift
//  tictactoe
//
//  Created by Steve Cooper on 5.07.2021.
//

import UIKit
import GoogleMobileAds

class GameBoardViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: GameBoardViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var gameDiffucultLevel: GameDifficult!
    
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBanner()
        initInterstitial()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = GameBoardViewModel(gameDifficultLevel: gameDiffucultLevel)
    }
    
    func initBanner() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-2069874114308807/6687069682"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func initInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-2069874114308807/6083600306",
                               request: request,
                               completionHandler: { [self] ad, error in
                                if let error = error {
                                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                    return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                               }
        )
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        viewModel.exitGame()
    }
    
    
}



extension GameBoardViewController: GADFullScreenContentDelegate {
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
}

extension GameBoardViewController: GameBoardDelegate {
    
    func lockPlayer() {
        view.isUserInteractionEnabled = false
    }
    
    func unlockPlayer() {
        view.isUserInteractionEnabled = true
    }
    
    func showGameOverScreen(winner: Players) {
        
        var winnerText = ""
        
        if winner == .player {
            winnerText = "You Won"
        } else if winner == .ai {
            winnerText = "AI Won"
        } else {
            winnerText = "Deuce"
        }
        
        let alert = UIAlertController(title: "Game Over", message: winnerText, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: {_ in
            if self.interstitial != nil {
                self.interstitial!.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
                self.dismiss(animated: true, completion: nil)
            }
        })
        alert.addAction(okeyAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func play() {
        self.collectionView.reloadData()
    }
    
    func exitGame() {
        let alert = UIAlertController(title: "Are You Sure?", message: "Do you want leave game? If you leave you can't continue this game.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okeyAction = UIAlertAction(title: "Okey", style: .destructive, handler: {_ in
            if self.interstitial != nil {
                self.interstitial!.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
                self.dismiss(animated: true, completion: nil)
            }
        })
        alert.addAction(cancelAction)
        alert.addAction(okeyAction)
        self.present(alert, animated: true, completion: nil)
    }
}


extension GameBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GameBoardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameboardcell", for: indexPath) as! GameBoardCell
        let moves = viewModel.game.moves
        let currentMove = moves[indexPath.row]
        
        print(indexPath.row)
        print(currentMove.moveIndex)
        print(currentMove.player)
        print("---------------------")
        
        if currentMove.player == .ai {
            cell.imageView.image = UIImage(named: "oTile")
        } else if currentMove.player == .player {
            cell.imageView.image = UIImage(named: "xTile")
        } else {
            cell.imageView.image = nil
        }
        
        if indexPath.row == 0 {
            cell.roundCornersTopLeft(radius: 25)
        } else if indexPath.row == 6 {
            cell.roundCornersTopRight(radius: 25)
        } else if indexPath.row == 2 {
            cell.roundCornersBottomLeft(radius: 25)
        } else if indexPath.row == 8 {
            cell.roundCornersBottomRight(radius: 25)
        } else {
            cell.roundCornersNone(radius: 0)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.game.checkSquareIsEmpty(moves: viewModel.game.moves, at: indexPath.row) {
            viewModel.playForPlayer(at: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
