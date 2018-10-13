//
//  ViewController.swift
//  InputTest
//
//  Created by LuzanovRoman on 05/10/2018.
//  Copyright © 2018 LuzanovRoman. All rights reserved.
//

import UIKit
import Input

class ViewController: UIViewController, InputDelegate {
    
    @IBOutlet weak var blackView: UIView!
    
    private var isBlackViewSelected = false
    private var displayLink: CADisplayLink!
    private var lastTime = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lastTime = CACurrentMediaTime()
        self.displayLink = CADisplayLink(target: self, selector: #selector(updateFrame))
        self.displayLink.add(to: .main, forMode: .common)
        Input.enable()
        Input.addDelegate(self)
    }
    
    @objc func updateFrame() {
        let currentTime = CACurrentMediaTime()
        let deltaTime = currentTime - self.lastTime
        self.lastTime = currentTime
        
        if Input.isKeyPressed("a") { self.blackView.transform.tx -= CGFloat(500 * deltaTime)}
        if Input.isKeyPressed("d") { self.blackView.transform.tx += CGFloat(500 * deltaTime)}
        if Input.isKeyPressed("w") { self.blackView.transform.ty -= CGFloat(500 * deltaTime)}
        if Input.isKeyPressed("s") { self.blackView.transform.ty += CGFloat(500 * deltaTime)}
    }
    
    // MARK: - InputDelegate
    func didPressMouseButton(_ button: MouseButton) {
        guard button == .mbLeft else { return }
        self.isBlackViewSelected = self.blackView.frame.contains(Input.mousePosition)
    }
    
    func didReleaseMouseButton(_ button: MouseButton) {
        guard button == .mbLeft else { return }
        self.isBlackViewSelected = false
    }
    
    func didMoveMouse(withOffset offset: CGPoint) {
        guard self.isBlackViewSelected else { return }
        self.blackView.frame = self.blackView.frame.offsetBy(dx: offset.x, dy: offset.y)
    }
}
