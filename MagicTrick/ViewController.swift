//
//  ViewController.swift
//  MagicTrick
//
//  Created by Michael Nienaber on 12/27/17.
//  Copyright © 2017 Michael Nienaber. All rights reserved.
// new

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var throwBallButton: UIButton!

    var globalScene: SCNScene?
    var planeNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.debugOptions = [.showPhysicsShapes]
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        guard let scene = SCNScene(named: "tophat.scn", inDirectory: "art.scnassets") else { return }
//        guard let planeNode = scene.rootNode.childNode(withName: "floor", recursively: true) else { return }
//
//        sceneView.scene.rootNode.addChildNode(planeNode)
        // Set the scene to the view
        sceneView.scene = SCNScene()
//        globalScene = sceneView.scene
      print("viewdidload")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    

//     Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
      if (anchor is ARPlaneAnchor) {
//        let sphere = SCNScene(named: "tophat.scn", inDirectory: "art.scnassets")




        let scene = SCNScene(named: "tophat.scn", inDirectory: "art.scnassets")
        print(scene)
        let sceneNode = scene?.rootNode.childNode(withName: "tophat", recursively: true)
        print(sceneNode)

        //sceneView.scene.rootNode.addChildNode(sceneNode!)
        planeNode!.addChildNode(sceneNode!)
////        let contentNode = SCNNode(geometry: sphere)
//        planeNode!.addChildNode(contentNode)
//
        return planeNode
      }
      return nil
  }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
  @IBAction func throwBallAction(_ sender: Any) {

    let camera = sceneView.session.currentFrame?.camera
    let cameraTransform = camera?.transform

    print("throw the goddamn ball!")
    let ball = SCNSphere(radius: 0.5)
    let ballNode = SCNNode(geometry: ball)
    ballNode.simdTransform = cameraTransform!

    // Add physics bodies
    let forceDirection = SCNVector3Make(0, 3, -4)
    let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    physicsBody.applyForce(forceDirection, asImpulse: true)
    physicsBody.allowsResting = true
    physicsBody.isAffectedByGravity = true
    ballNode.physicsBody = physicsBody

    print(physicsBody)

    globalScene?.rootNode.addChildNode(ballNode)
  }

}
