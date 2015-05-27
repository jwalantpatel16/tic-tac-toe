//
//  GameViewController.swift
//  Tic Tac To
//
//  Created by Benjamin Emdon on 2015-05-20.
//  Copyright (c) 2015 Ben Emdon. All rights reserved.
//

import UIKit

class MultiplayerViewController: UIViewController
{
    
    @IBOutlet var playingBoardView: DesignableView!
    
    
    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!
    
    @IBOutlet var ticTacButton1: UIButton!
    @IBOutlet var ticTacButton2: UIButton!
    @IBOutlet var ticTacButton3: UIButton!
    @IBOutlet var ticTacButton4: UIButton!
    @IBOutlet var ticTacButton5: UIButton!
    @IBOutlet var ticTacButton6: UIButton!
    @IBOutlet var ticTacButton7: UIButton!
    @IBOutlet var ticTacButton8: UIButton!
    @IBOutlet var ticTacButton9: UIButton!
    
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var userMessage: UILabel!
    
    
    var plays = [Int: Int]()
    var done = false
    var aiDeciding = false
    
    
    @IBAction func UIButtonClicked(sender:UIButton)
    {
        playingBoardView.scaleX = 0.3
        playingBoardView.scaleY = 0.3
        playingBoardView.animateTo()
        playingBoardView.scaleX = 0.3
        playingBoardView.scaleY = 0.3
        playingBoardView.animate()
        
        userMessage.hidden = true
        if plays[sender.tag] == nil && !aiDeciding && !done
        {
            setImageToSpot(sender.tag, player:1)
        }
        checkForWin()
        aiTurn()
    }
    
    
    
    func setImageToSpot(spot:Int, player:Int)
    {
        var playerMark = player == 1 ? "x-icon2" : "o-icon2"
        plays[spot] = player
        switch spot
        {
        case 1:
            ticTacImg1.image = UIImage(named: playerMark)
        case 2:
            ticTacImg2.image = UIImage(named: playerMark)
        case 3:
            ticTacImg3.image = UIImage(named: playerMark)
        case 4:
            ticTacImg4.image = UIImage(named: playerMark)
        case 5:
            ticTacImg5.image = UIImage(named: playerMark)
        case 6:
            ticTacImg6.image = UIImage(named: playerMark)
        case 7:
            ticTacImg7.image = UIImage(named: playerMark)
        case 8:
            ticTacImg8.image = UIImage(named: playerMark)
        case 9:
            ticTacImg9.image = UIImage(named: playerMark)
        default:
            ticTacImg5.image = UIImage(named: playerMark)
        }
    }
    
    @IBAction func resetButtonClicked(sender:UIButton)
    {
        resetButton.hidden = true
        userMessage.hidden = true
        done = false
        reset()
    }
    
    
    func reset()
    {
        plays = [:]
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
        
        playingBoardView.animation = "slideDown"
        playingBoardView.duration = 1.3
        playingBoardView.opacity = 0
        playingBoardView.animate()
    }
    
    
    func checkForWin()
    {
        var whoWon = ["I":0,"you":1]
        for(key,value) in whoWon
        {
            if  (plays[1] == value && plays[2] == value && plays[3] == value) || //across the top
                (plays[4] == value && plays[5] == value && plays[6] == value) || //across the middle
                (plays[7] == value && plays[8] == value && plays[9] == value) || //across the bottom
                (plays[1] == value && plays[4] == value && plays[7] == value) || //down the left
                (plays[2] == value && plays[5] == value && plays[8] == value) || //down the middle
                (plays[3] == value && plays[6] == value && plays[9] == value) || //down the right
                (plays[1] == value && plays[5] == value && plays[9] == value) || //diag left right
                (plays[3] == value && plays[5] == value && plays[7] == value)//diag right left
            {
                userMessage.text = "Looks like \(key) won!"
                userMessage.hidden = false
                resetButton.hidden = false
                done = true
            }
        }
    }
    
    //ai function
    //requires delay
    
    func checkTop(#value:Int) -> (location:String, pattern:String)
    {
        return ("top", checkFor(value, inList: [1,2,3]))
    }
    func checkMiddle(#value:Int) -> (location:String, pattern:String)
    {
        return ("middle", checkFor(value, inList: [4,5,6]))
    }
    func checkBottom(#value:Int) -> (location:String, pattern:String)
    {
        return ("bottom", checkFor(value, inList: [7,8,9]))
    }
    func checkLeft(#value:Int) -> (location:String, pattern:String)
    {
        return ("left", checkFor(value, inList: [1,4,7]))
    }
    func checkMiddleDown(#value:Int) -> (location:String, pattern:String)
    {
        return ("middleDown", checkFor(value, inList: [2,5,8]))
    }
    func checkRight(#value:Int) -> (location:String, pattern:String)
    {
        return ("right", checkFor(value, inList: [3,6,9]))
    }
    func checkDiagLeftRight(#value:Int) -> (location:String, pattern:String)
    {
        return ("diagLeftRight", checkFor(value, inList: [1,5,9]))
    }
    func checkDiagRightLeft(#value:Int) -> (location:String, pattern:String)
    {
        return ("diagRightLeft", checkFor(value, inList: [7,5,3]))
    }
    
    
    
    
    func checkFor(value:Int, inList:[Int]) -> String
    {
        var conclusion = ""
        for cell in inList
        {
            if plays[cell] == value
            {
                conclusion += "1"
            }
            else
            {
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    
    func rowCheck (#value:Int) -> (location:String, pattern:String)?
    {
        var acceptableFinds = ["110", "011", "101"]
        var findFuncs = [checkTop, checkMiddle, checkBottom, checkLeft, checkMiddleDown, checkRight, checkDiagLeftRight, checkDiagRightLeft]
        for algorithm in findFuncs
        {
            var algorithmResults = algorithm(value:value)
            if (find(acceptableFinds,algorithmResults.pattern) != nil)
            {
                return algorithmResults
            }
        }
        return nil
    }
    
    
    func isOccupied(spot:Int) -> Bool
    {
        return plays[spot] != nil
    }
    
    
    func aiTurn()
    {
        if done
        {
            return
        }
        
        aiDeciding = true
        
        //priority code here
        
        userMessage.hidden = false
        userMessage.text = "It's a tie!"
        
        resetButton.hidden =  false
        
        
        aiDeciding = false
        
    }
    
    //end class
}