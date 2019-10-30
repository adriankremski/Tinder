//
//  CardView.swift
//  Tinder
//
//  Created by Adrian Kremski on 29/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import UIKit

class CardView: UIView {

    var viewModel: CardViewModel! {
        didSet {
            imageView.image = UIImage(named: viewModel.imageName)
            informationLabel.attributedText = viewModel.attributedString
            informationLabel.textAlignment = viewModel.textAlignment
        }
    }
    
    fileprivate let imageView = UIImageView(image: UIImage(named: "lady5c"))
    
    fileprivate let informationLabel = UILabel()
    
    fileprivate let threshold: CGFloat = 200
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
        informationLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 24, right: 16))
        
        let panGestureRecognier = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGestureRecognier)
    }
    
    fileprivate func setupGradientLayer() {
        
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .changed:
                handleChangedPanGesture(gesture)
            case .ended:
                handledEndedPanGesture(gesture)
            default:
                ()
        }
    }
    
    fileprivate func handleChangedPanGesture(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: nil)

        let degress : CGFloat = translation.x / 20
        let angle = degress * .pi / 180
        
        let rotationTransformation = CGAffineTransform(rotationAngle: angle).translatedBy(x: translation.x, y: translation.y)
        self.transform = rotationTransformation
    }
    
    fileprivate func handledEndedPanGesture(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let translation = gesture.translation(in: self).x
        let shouldDismissCard = abs(translation) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if (shouldDismissCard) {
                self.transform.translatedBy(x: 600 * translationDirection, y: 0)
            } else {
                self.transform = .identity
            }
        }, completion: { (_) in
            self.transform = .identity
            
            if (shouldDismissCard) {
                self.removeFromSuperview()
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
