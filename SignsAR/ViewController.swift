//
//  ViewController.swift
//  SignsAR
//
//  Created by Alexey on 27.09.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    private var textToShow: String? = nil
    @IBOutlet var sceneView: ARSCNView!
    private func addGestureRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnSceneView(_:)))
        sceneView.addGestureRecognizer(tapRecognizer)
    }
    @objc func tapOnSceneView(_ gesture: UIPanGestureRecognizer){
        let tapLocation = gesture.location(in: self.sceneView)
            let results = self.sceneView.hitTest(tapLocation, types: .featurePoint)

            guard let result = results.first else {
                return
            }
    
            let translation = result.worldTransform.translation
            var node = addTextAR()
            if let node = node{
                node.position = SCNVector3(translation.x, translation.y, translation.z)
                self.sceneView.scene.rootNode.addChildNode(node)
            }
                
    }
    @IBAction func pressPlusButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "addTextViewController") as! AddTextViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        let scene = SCNScene()
        sceneView.scene = scene
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

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    func addTextAR() -> SCNNode?{
        if textToShow == nil { return nil }
        let textAR = SCNText(string: textToShow!, extrusionDepth: 2)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemPink
        textAR.materials = [material]
        return SCNNode(geometry: textAR)
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
}
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
extension ViewController: SetText{
    func setText(text: String) {
        self.textToShow = text
    }
    
    
}
