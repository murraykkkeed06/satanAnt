//
//  Map.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation


// 1 : room
// 2 : born room


class Map {
    
    //5 * 7
    
    var map1 = [[[Int]]]()
    var map2 = [[[Int]]]()
    var map3 = [[[Int]]]()
    var map4 = [[[Int]]]()
    var map5 = [[[Int]]]()
    var sceneRow = 5
    var sceneCol = 7
    
    init(){
         map1 = [
                [[2,1,0,0,0,0,0],
                 [0,1,0,9,0,0,0],
                 [0,1,7,8,0,11,0],
                 [0,10,0,1,3,1,5],
                 [0,0,0,0,0,0,0]]
                ,
                 [[0,10,0,0,0,0,0],
                  [2,1,0,11,0,0,0],
                  [0,1,7,1,0,8,5],
                  [0,10,0,1,3,9,0],
                  [0,0,0,0,0,0,0]]
                ,
                 [[0,0,11,0,0,0,0],
                  [5,3,1,8,9,1,0],
                  [0,1,0,1,0,0,0],
                  [0,1,7,1,2,10,0],
                  [0,10,0,0,0,0,0]]
                ,
                 [[11,0,1,9,1,3,0],
                  [1,1,1,0,0,1,2],
                  [0,8,0,1,0,0,0],
                  [0,1,7,1,1,0,0],
                  [0,10,0,0,5,0,0]]
            
                ]
        
        map2 = [
               [[6,5,0,0,0,0,0],
                [0,1,0,1,0,0,0],
                [0,1,1,1,0,0,0],
                [0,0,0,1,3,1,1],
                [0,0,0,0,1,0,0]]
               ,
                [[0,1,0,0,0,0,0],
                 [6,5,0,1,0,0,0],
                 [0,1,1,1,0,1,1],
                 [0,0,0,1,3,1,0],
                 [0,0,0,0,1,0,0]]
               ,
                [[0,0,1,0,0,0,0],
                 [1,3,1,1,1,1,1],
                 [0,1,0,1,0,0,0],
                 [0,1,1,1,5,0,0],
                 [0,0,0,0,6,0,0]]
               ,
                [[1,3,1,1,1,1,0],
                 [0,1,0,0,0,5,6],
                 [0,1,0,1,0,0,0],
                 [0,1,1,1,1,0,0],
                 [0,0,0,0,1,0,0]]
           
               ]
        
        map3 = [
               [[6,5,0,0,0,0,0],
                [0,1,0,1,0,0,0],
                [0,1,1,1,0,0,0],
                [0,0,0,1,3,1,1],
                [0,0,0,0,1,0,0]]
               ,
                [[0,1,0,0,0,0,0],
                 [6,5,0,1,0,0,0],
                 [0,1,1,1,0,1,1],
                 [0,0,0,1,3,1,0],
                 [0,0,0,0,1,0,0]]
               ,
                [[0,0,1,0,0,0,0],
                 [1,3,1,1,1,1,1],
                 [0,1,0,1,0,0,0],
                 [0,1,1,1,5,0,0],
                 [0,0,0,0,6,0,0]]
               ,
                [[1,3,1,1,1,1,0],
                 [0,1,0,0,0,5,6],
                 [0,1,0,1,0,0,0],
                 [0,1,1,1,1,0,0],
                 [0,0,0,0,1,0,0]]
           
               ]
        map4 = [
               [[6,5,0,0,0,0,0],
                [0,1,0,1,0,0,0],
                [0,1,1,1,0,0,0],
                [0,0,0,1,3,1,1],
                [0,0,0,0,1,0,0]]
               ,
                [[0,1,0,0,0,0,0],
                 [6,5,0,1,0,0,0],
                 [0,1,1,1,0,1,1],
                 [0,0,0,1,3,1,0],
                 [0,0,0,0,1,0,0]]
               ,
                [[0,0,1,0,0,0,0],
                 [1,3,1,1,1,1,1],
                 [0,1,0,1,0,0,0],
                 [0,1,1,1,5,0,0],
                 [0,0,0,0,6,0,0]]
               ,
                [[1,3,1,1,1,1,0],
                 [0,1,0,0,0,5,6],
                 [0,1,0,1,0,0,0],
                 [0,1,1,1,1,0,0],
                 [0,0,0,0,1,0,0]]
           
               ]
        map5 = [
               [[6,5,0,0,0,0,0],
                [0,1,0,1,0,0,0],
                [0,1,1,1,0,0,0],
                [0,0,0,1,3,1,1],
                [0,0,0,0,1,0,0]]
               ,
                [[0,1,0,0,0,0,0],
                 [6,5,0,1,0,0,0],
                 [0,1,1,1,0,1,1],
                 [0,0,0,1,3,1,0],
                 [0,0,0,0,1,0,0]]
               ,
                [[0,0,1,0,0,0,0],
                 [1,3,1,1,1,1,1],
                 [0,1,0,1,0,0,0],
                 [0,1,1,1,5,0,0],
                 [0,0,0,0,6,0,0]]
               ,
                [[1,3,1,1,1,1,0],
                 [0,1,0,0,0,5,6],
                 [0,1,0,1,0,0,0],
                 [0,1,1,1,1,0,0],
                 [0,0,0,0,1,0,0]]
           
               ]
        
    }
    
    
}
