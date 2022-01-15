//
//  ViewController.swift
//  ImageGalleryTestProject
//
//  Created by Константин Туголуков on 14.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var timer = Timer()
    private var isAnimated: Bool = false
    private var gradientLayer = CAGradientLayer()
    
    private var colorsGradient = [
        UIColor.green.cgColor,
        UIColor.yellow.cgColor,
        UIColor.orange.cgColor]
    
    private var images: [UIImage] = [
        UIImage(named:"img-0")!,
        UIImage(named:"img-1")!,
        UIImage(named:"img-2")!,
        UIImage(named:"img-3")!,
        UIImage(named:"img-4")!]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        isAnimated.toggle()
        animatedImageView(animated: isAnimated)
        animatedGradient(animated: isAnimated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gradientLayer = gradientLayer(colors: colorsGradient, frame: button.bounds)
        button.layer.addSublayer(gradientLayer)
        
    }
    
    private func gradientLayer(colors: [CGColor], frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint  = CGPoint(x: 1.0, y: 1.0)
        
        return gradientLayer
        
    }
    
    private func animationGradient(colors: [CGColor]) -> CABasicAnimation {
        let animated = CABasicAnimation()
        animated.fromValue = colors
        animated.toValue = colors.shuffled() //.reversed().map{$0.self}
        animated.duration = 1.0
        animated.autoreverses = true
        animated.repeatCount = Float.infinity
        
        return animated
        
    }
    
    private func animatedGradient(animated: Bool) {
        if animated {
            self.gradientLayer.add(animationGradient(colors: colorsGradient), forKey: "colors")
        } else {
            self.gradientLayer.removeAllAnimations()
        }
        
    }
    
    private func animatedImageView(animated: Bool) {
        if animated {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
                    self.changeImage()
                }
            }
        } else {
            timer.invalidate()
        }
        
    }
    
    private func changeImage() {
        let transitions: [UIView.AnimationOptions] = [
            UIView.AnimationOptions.transitionCurlUp,
            UIView.AnimationOptions.transitionCurlDown,
            UIView.AnimationOptions.transitionCrossDissolve,
            UIView.AnimationOptions.transitionFlipFromTop,
            UIView.AnimationOptions.transitionFlipFromLeft,
            UIView.AnimationOptions.transitionFlipFromRight,
            UIView.AnimationOptions.transitionFlipFromBottom
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.transition(with: self.imageView,
                              duration: 1.0,
                              options: transitions.randomElement() ?? .transitionCrossDissolve,
                              animations: {
                self.imageView.image = self.images.randomElement()
            }, completion: nil)
        }
    }
    
    
}

