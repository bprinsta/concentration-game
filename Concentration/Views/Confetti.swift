//
//  Confetti.swift
//  Concentration
//
//  Created by Benjamin Musoke-Lubega on 12/27/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

struct Confetti {
	static let box = UIImage(named: "Box")!
    static let triangle = UIImage(named: "Triangle")!
    static let circle = UIImage(named: "Circle")!
    static let spiral = UIImage(named: "Spiral")!
	
	static let red = UIColor(red: 1.0, green: 0.0, blue: 77.0/255.0, alpha: 1.0)
    static let green = UIColor(red: 35.0/255.0 , green: 233/255, blue: 173/255.0, alpha: 1.0)
	static let blue = UIColor.blue
    static let yellow = UIColor(red: 1, green: 209/255, blue: 77.0/255.0, alpha: 1.0)
	
	static let velocities:[Int] = [100, 90, 150, 200]
	static let images:[UIImage] = [box, triangle, circle, spiral]
	static let colors: [UIColor] = [red, green, blue, yellow]
}

func createParticles(view: UIView) {
	let particleEmitter = CAEmitterLayer()
	
	particleEmitter.name = "confetti"
	particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
	particleEmitter.emitterShape = CAEmitterLayerEmitterShape.line
	particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
	
	particleEmitter.emitterCells = generateEmitterCells()
	
	view.layer.addSublayer(particleEmitter)
}

func generateEmitterCells() -> [CAEmitterCell] {
	var cells:[CAEmitterCell] = [CAEmitterCell]()
	
	for i in 0...15
	{
		let cell = CAEmitterCell()
		
		cell.birthRate = 4.0
		cell.lifetime = 14.0
		cell.lifetimeRange = 0
		cell.color = Confetti.colors[i / 4].cgColor
		cell.velocity = CGFloat(Confetti.velocities.randomElement() ?? 100)
		cell.velocityRange = 0
		cell.emissionLongitude = CGFloat(Double.pi)
		cell.emissionRange = 0.5
		cell.spin = 3.5
		cell.spinRange = 0
		cell.scaleRange = 0.25
		cell.scale = 0.1
		
		cell.contents = Confetti.images[i % 4].cgImage
		
		cells.append(cell)
	}
	
	return cells
}

extension UIView {
    func removeLayer(layerName: String) {
            for item in self.layer.sublayers ?? [] where item.name == layerName {
                    item.removeFromSuperlayer()
            }
        }
}

