//
//  ViewController.swift
//  Object ARKIT
//
//  Created by Özgün Yildiz on 13.04.21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        // box looks very 2-Dimensional. In order to rectify that, we do the following which adds default lighting
        sceneView.autoenablesDefaultLighting = true
        
        // we are creating a cube with specified size
        let cube = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.0)
        // we are instantiating SCNMaterial because we want to add visual characteristics (otherwise it will be a boring white box)
        let material = SCNMaterial()
        // we are changing the color of the box to blue
        material.diffuse.contents = UIColor.blue
        // in order for the color to be displayed, we have to apply the material (color blue) to the cube we created on line 23
        cube.materials = [material]
        
        let cubeNode = SCNNode()
        
        cubeNode.geometry = cube
        // we place the cube 1m in front of us. Positive Z is behind us, so in order for the box to show in front of us, we'll negate the integer
        cubeNode.position = SCNVector3(0.0, 0.0, -1.0)
        
        // we specify the rotation to be 360 degrees (2 x pi) with a duration of 2 seconds. The same outcome can be achieved by specifying 180 degrees in 1 second (the duration specifies the timeframe in seconds in which the rotation is performed.) The rotation follows along the y axis.
        let rotation = SCNAction.rotateBy(x: 0, y: 1 * .pi, z: 0, duration: 1)
        // we can specify it to rotate indefinetely or not
        let repeatRotation = SCNAction.repeatForever(rotation)
        cubeNode.runAction(repeatRotation)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }

}
