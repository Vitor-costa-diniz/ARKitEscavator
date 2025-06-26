//
//  ARViewContainer.swift
//  ARKitEscavator
//
//  Created by Kelly Letícia Nascimento de Morais on 22/06/25.
//

import SwiftUI
import RealityKit
import ARKit
import CoreLocation

struct ARViewContainer: UIViewRepresentable {
    let site: EscavationPoint

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)

        arView.addGestureRecognizer(UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(_:))))
        arView.addGestureRecognizer(UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch(_:))))
        return arView
    }

    func updateUIView(_ arView: ARView, context: Context) {
        guard arView.scene.anchors.isEmpty else { return }

        let light = DirectionalLight()
        light.light.intensity = 1000
        light.look(at: [0, 0, 0], from: [0, 5, 5], relativeTo: nil)

        let lightAnchor = AnchorEntity(world: [0, 2, 0])
        lightAnchor.addChild(light)
        arView.scene.addAnchor(lightAnchor)

//        let offsets: [SIMD3<Float>] = [
//            [0, 0, -1.5],
//            [1.0, 0, -1.0],
//            [-1.0, 0, -1.0]
//        ]
        
        let anchor = AnchorEntity(world: [0, 0, -1.5])

//        for offset in offsets {
//            let anchor = AnchorEntity(world: offset)

            do {
                let modelEntity = try Entity.loadModel(named: "relogio")
                modelEntity.scale = [0.1, 0.1, 0.1]
                modelEntity.name = "interactiveModel"
                modelEntity.generateCollisionShapes(recursive: true)
                anchor.addChild(modelEntity)
                arView.installGestures([.rotation], for: modelEntity as Entity & HasCollision)
                arView.scene.addAnchor(anchor)
            } catch {
                print("Erro ao carregar modelo: \(error.localizedDescription)")
            }
       // }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        private var lastScale: Float = 1.0
        private var currentAngleY: Float = 0.0
        private var currentAngleX: Float = 0.0

        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            
            guard let arView = gesture.view as? ARView else { return }

            let translation = gesture.translation(in: gesture.view)
            let deltaX = Float(translation.x)
            let deltaY = Float(translation.y)

            currentAngleY += deltaX * 0.005
            currentAngleX += deltaY * 0.005

            let rotationY = simd_quatf(angle: currentAngleY, axis: [0, 1, 0])
            let rotationX = simd_quatf(angle: currentAngleX, axis: [0, 1, 0])
            let finalRotation = rotationY * rotationX

            for anchor in arView.scene.anchors {
                for entity in anchor.children {
                    entity.transform.rotation = finalRotation
                }
            }

            gesture.setTranslation(.zero, in: gesture.view)
        }

        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let arView = gesture.view as? ARView else { return }

            let scale = Float(gesture.scale)
            for anchor in arView.scene.anchors {
                for entity in anchor.children {
                    entity.scale *= SIMD3<Float>(repeating: scale)
                }
            }

            gesture.scale = 1.0
        }
    }
}
