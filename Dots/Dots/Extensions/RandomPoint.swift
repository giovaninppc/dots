//
//  RandomPoint.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

// NOTE:
// The x represent the possible return points of the functions
//
//   ----------
//  |          |
//  |          |
//  |     +    |
//  | - (0,0) +|
//  |     -    |
//  |          |
//  |          |
//   ----------

class RandomPoint {
    
    // Screen sizes and orientations
    static var boundsWidth: CGFloat = UIScreen.main.bounds.size.width
    static var boundsHeight: CGFloat = UIScreen.main.bounds.size.height
    
    // Get a random point on top of the screen
    //
    //   xxxxxxxxxx
    //  |          |
    //  |          |
    //  |          |
    //  |  screen  |
    //  |          |
    //  |          |
    //  |          |
    //   ----------
    class func topScreenPoint() -> CGPoint {
        let xPoint: UInt32 = arc4random_uniform(UInt32(boundsWidth))
        let xLimit: Int = Int(boundsWidth/2) - Int(xPoint)
        return CGPoint(x: CGFloat(xLimit), y: (boundsHeight/2))
    }
    
    // Get a random point on the right side, top screen
    //
    //   ----------
    //  |          x
    //  |          x
    //  |          x
    //  |  screen  |
    //  |          |
    //  |          |
    //  |          |
    //   ----------
    class func topRightSidePoint() -> CGPoint {
        let xPoint: CGFloat = boundsWidth/2
        let yPoint: UInt32 = arc4random_uniform(UInt32(boundsHeight/2))
        let yLimit: CGFloat = CGFloat(yPoint) - boundsHeight/2
        return CGPoint(x: xPoint, y: yLimit)
    }
    
    // Get a random point on the left side, top screen
    //
    //   ----------
    //  x          |
    //  x          |
    //  x          |
    //  |  screen  |
    //  |          |
    //  |          |
    //  |          |
    //   ----------
    class func topLeftSidePoint() -> CGPoint {
        var point: CGPoint = topRightSidePoint()
        point.x = -1*point.x
        return point
    }
    
}
