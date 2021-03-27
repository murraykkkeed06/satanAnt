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
    var sceneList = [GameScene]()
    
    
    var map = [[Int]]()
    var player: Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player()
        player.inMapNumber = Int.random(in: 0..<Map().map.count)
        map = Map().map[player.inMapNumber]

        setupSceneList()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = sceneList[self.bornRoom()]
                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
            //setupButton(scene: scene)
            
            
            player.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
            
            scene.player = player
            
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
    
    
//    func setupButton(scene: GameScene)  {
//        scene.mount = (scene.childNode(withName: "//mount") as! SKSpriteNode)
//        scene.handler = (scene.childNode(withName: "//handler") as! SKSpriteNode)
//        scene.handlerBackground = (scene.childNode(withName: "//handlerBackground") as! SKSpriteNode)
//        scene.fireButton = (scene.childNode(withName: "fireButton") as! MSButtonNode)
//        scene.popoButton = (scene.childNode(withName: "popoButton") as! MSButtonNode)
//
//    }
//
    
    
    func bornRoom() -> Int {
        var room: Int!
        
        for i in 0..<sceneList.count{
            if sceneList[i].isBornRoom{
                room = i
                break
            }
        }
        return room
    }
    
    
    func setupSceneList()  {
        //new scene
        for y in 0..<Map().sceneRow{
            for x in 0..<Map().sceneCol{
                if self.map[y][x] != 0{
                    //print("y: \(y),x: \(x)")
                    
                    if self.map[y][x] == 2 {
                        let gameScene = GameScene.level(2)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isBornRoom = true
                        sceneList.append(gameScene)
                    }else if self.map[y][x] == 3 {
                        let gameScene = GameScene.level(3)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isBonusRoom = true
                        sceneList.append(gameScene)
                    }
                    else {
                        let gameScene = GameScene.level(1)!
                        gameScene.YX = GridYX(y: y, x: x)
                        sceneList.append(gameScene)
                    }
                    
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
