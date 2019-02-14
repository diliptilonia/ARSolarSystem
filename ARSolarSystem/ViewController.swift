//
//  ViewController.swift
//  ARSolarSystem
//
//  Created by Dilip Gurjar on 14/02/19.
//  Copyright © 2019 Dilip Gurjar. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
       // let scene = SCNScene(named: "art.scnassets/solarSystem.scn")!
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        createPlanet()
    }
    
    func createPlanet() {
        // ParentNode
        let parentNode = SCNNode()
        parentNode.position.z = -1.5
        
        // planets
        let mercury = planet(name: "murcury", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), sunDistance: 1.3, radius: 0.14, rotation: 32.degreeToRadius)
        let vinus = planet(name: "vinus", color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), sunDistance: 2, radius: 0.35, rotation: 10.degreeToRadius)
        let earth = planet(name: "earth", color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), sunDistance: 7, radius: 0.5, rotation: 18.degreeToRadius)
        let sature = planet(name: "sature", color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), sunDistance: 12, radius: 1, rotation: 12.degreeToRadius)
        
        let planets = [mercury, vinus, earth, sature]
        
        for planet in planets {
            parentNode.addChildNode(createNode(from : planet))
        }
        
        
        // Light
        let light = SCNLight()
            light.type = .omni
            parentNode.light = light
        
        // Stars
        let start = SCNParticleSystem(named: "stars.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(start)
        
        // Sun
        let sun = SCNParticleSystem(named: "sun.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(sun)
        
        sceneView.scene.rootNode.addChildNode(parentNode)
    }
    
    func createNode(from planet : planet) -> SCNNode {
        let parentNode = SCNNode()
        let rotation = SCNAction.rotateBy(x: 0, y: planet.rotation, z: 0, duration: 1)
        parentNode.runAction(.repeatForever(rotation))
        
        let spheregeometry = SCNSphere(radius: planet.radius)
        spheregeometry.firstMaterial?.diffuse.contents = planet.color
        let planetNode = SCNNode(geometry: spheregeometry)
        planetNode.position.z = -planet.sunDistance
        planetNode.name = planet.name
        parentNode.addChildNode(planetNode)
        
        if planet.name == "sature" {
            let ringGeomatery = SCNTube(innerRadius: 1.2, outerRadius: 1.8, height: 0.05)
            ringGeomatery.firstMaterial?.diffuse.contents = UIColor.darkGray
            let ringNode = SCNNode(geometry: ringGeomatery)
            ringNode.eulerAngles.x = Float(-10.degreeToRadius)
            planetNode.addChildNode(ringNode)
            
        }
        
        
        return parentNode
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}


extension Int {
    var degreeToRadius: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
