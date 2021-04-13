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
