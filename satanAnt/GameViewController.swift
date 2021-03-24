//
//  GameViewController.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    //5 * 7
    //10 room
    var sceneList = [GameScene]()
    var sceneRow = 5
    var sceneCol = 7
    var bornRoomNumberInList: Int!
    var map = Map.map1
    var player: Player!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneList()
        self.bornRoomNumberInList = Int.random(in: 0..<sceneList.count)

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = sceneList[self.bornRoomNumberInList]
                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
            scene.levelNum = 1
            scene.player = Player()
            
                // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
    
    func setupSceneList()  {
        //new scene
        for y in 0..<sceneRow{
            for x in 0..<sceneCol{
                if self.map[y][x] != 0{
                    let gameScene = GameScene(fileNamed: "GameScene")!
                    gameScene.YX = GridYX(y: y, x: x)
                    sceneList.append(gameScene)
                }
            }
        }
        
        
        //set relation
        
        for i in 0..<sceneList.count {
            
            let x = sceneList[i].YX.x!
            let y = sceneList[i].YX.y!
            
            //check top
            if y == 0 {sceneList[i].top = nil}
            else{ if map[y-1][x] != 0 {
                for j in 0..<sceneList.count {
                    if sceneList[j].YX.x == x && sceneList[j].YX.y == y-1 {
                        sceneList[i].top = sceneList[j]
                    }
                }
            }}
            
            //check bottom
            if y == 4 {sceneList[i].bototm = nil}
            else{ if map[y+1][x] != 0 {
                for j in 0..<sceneList.count {
                    if sceneList[j].YX.x == x && sceneList[j].YX.y == y+1 {
                        sceneList[i].bototm = sceneList[j]
                    }
                }
            }}
            
            //check left
            if x == 0 {sceneList[i].left = nil}
            else{ if map[y][x-1] != 0 {
                for j in 0..<sceneList.count {
                    if sceneList[j].YX.x == x-1 && sceneList[j].YX.y == y {
                        sceneList[i].left = sceneList[j]
                    }
                }
            }}
            
            //check right
            if x == 6 {sceneList[i].right = nil}
            else{ if map[y][x+1] != 0 {
                for j in 0..<sceneList.count {
                    if sceneList[j].YX.x == x+1 && sceneList[j].YX.y == y {
                        sceneList[i].right = sceneList[j]
                    }
                }
            }}
            
            
        }
    }
}
