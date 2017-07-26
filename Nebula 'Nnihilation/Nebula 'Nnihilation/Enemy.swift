//
//  Enemy.swift
//  Nebula 'Nnihilation
//
//  Created by Jack Hamilton on 7/26/17.
//  Copyright © 2017 App Camp. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    //Noncomputed properties set in initializers. 
    //Run super.init() before changing default values.
    var health: Int
    //Polar coordinates, speed measured in px/s
    var velocity: Velocity
    var spawnFrame: Int
    var spawnLocation: CGPoint
    
    var nodeName: String
    var collisionMask: Int
    var contactMask: Int
    var categoryMask: Int
    
    //Override in subclasses
    var imageFilename: String {
        return "Enemy1"
    }
    var scale: CGFloat {
        return 0.3
    }
    
    //spawnFrame is the frame in which it should spawn RELATIVE TO THE WAVE.
    //This means just the number of frames after the wave is created.
    init(spawnLocation: CGPoint, spawnFrame: Int) {
        health = 0
        velocity = Velocity(magnitude: 4, angle: 270)
        nodeName = "Enemy"
        collisionMask = 0
        contactMask = 1
        categoryMask = 1
        self.spawnLocation = spawnLocation
        self.spawnFrame = spawnFrame
        super.init(texture: SKTexture(), color: UIColor.clear, size: CGSize.zero)
        texture = SKTexture(imageNamed: imageFilename)
        size = CGSize(width: texture!.size().width * scale, height: texture!.size().height * scale)
        position = spawnLocation
        name = nodeName
        initPhysics()
    }
    convenience init(spawnX: Int, spawnY: Int, spawnFrame: Int) {
        self.init(spawnLocation: CGPoint(x: spawnX, y: spawnY), spawnFrame: spawnFrame)
    }
    convenience init(spawnX: Int, spawnY: Int, spawnSeconds: Double) {
        self.init(spawnLocation: CGPoint(x: spawnX, y: spawnY), spawnFrame: Int(spawnSeconds * 60))
    }
    //Maybe add a parameter that accepts a function to be used for updating position with a preset argument of the velocity?
    //This would allow for one enemy type to have multiple paths. Another way to do this is with an enum and then conditionals
    //in the class's update method that checks for which version of that enemy type it is.

    //All will be set to default values. Don't call this without changing them afterwards.
    required init?(coder aDecoder: NSCoder) {
        print("Warning: Default enemy initializer called.")
        health = 0
        velocity = Velocity(magnitude: 0, angle: 0)
        spawnFrame = 0
        spawnLocation = CGPoint.zero
        nodeName = "Enemy"
        collisionMask = 0
        contactMask = 0
        categoryMask = 0
        super.init(coder: aDecoder)
        texture = SKTexture(imageNamed: imageFilename)
    }
    
    func initPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.collisionBitMask = UInt32(collisionMask)
        physicsBody?.contactTestBitMask = UInt32(contactMask)
        physicsBody?.categoryBitMask = UInt32(categoryMask)
    }
    
    func update(frameCount: Int) {
        position.x = position.x + velocity.vector.dx
        position.y = position.y + velocity.vector.dy
    }
    
    func collision(withBody body: SKNode) {
        
    }
}
