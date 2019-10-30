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
            let imageName = viewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = viewModel.attributedString
            informationLabel.textAlignment = viewModel.textAlignment
            
            if (viewModel.imageNames.count > 1) {
                viewModel.imageNames.forEach { (value) in
                    let barView = UIView()
                    barView.backgroundColor = barDeselectedColor
                    tabBarsStackView.addArrangedSubview(barView)
                }
                
                tabBarsStackView.arrangedSubviews.first?.backgroundColor = barSelectedColor
            }
            
            setupImageObserver()
        }
    }
    
    fileprivate let gradientLayer = CAGradientLayer()

    fileprivate let imageView = UIImageView()
    
    fileprivate let informationLabel = UILabel()
    
    fileprivate let threshold: CGFloat = 200
    
    fileprivate var currentPhotoNumber = 0
    fileprivate let barSelectedColor = UIColor.white
    fileprivate let barDeselectedColor = UIColor(white:0, alpha: 0.1)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupLayout()
        let panGestureRecognier = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGestureRecognier)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc fileprivate func handleTap(_ gesture: UITapGestureRecognizer) {
        if (viewModel.imageNames.count <= 1) {
            return
        }
        
        let tapLocation = gesture.location(in: nil)
        let shouldAdvance = tapLocation.x > frame.width / 2 ? true : false
        
        if shouldAdvance {
            viewModel.adavanceToNextPhoto()
        } else {
            viewModel.goToPreviousPhoto()
        }
    }
    
    fileprivate func setupImageObserver() {
        viewModel.imageIndexObserver = { [weak self] (imageIndex, image) in
            guard let safeImage = image else {
                return
            }
            
            self?.tabBarsStackView.arrangedSubviews.forEach { (view) in
                view.backgroundColor = self?.barDeselectedColor
            }
            
            self?.tabBarsStackView.arrangedSubviews[imageIndex].backgroundColor = self?.barSelectedColor
            
            self?.imageView.image = safeImage
        }
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .began:
                superview?.subviews.forEach({ (view) in
                    view.layer.removeAllAnimations()
                })
            case .changed:
                handleChangedPanGesture(gesture)
            case .ended:
                handledEndedPanGesture(gesture)
            default:
                ()
        }
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
         
        setupTabBars()
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
        informationLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 24, right: 16))
    }
    
    fileprivate let tabBarsStackView = UIStackView()
    
    fileprivate func setupTabBars() {
        addSubview(tabBarsStackView)
        tabBarsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor , padding: .init(top:8, left:8, bottom:0, right: 0), size: .init(width: 0, height: 4))
        
        tabBarsStackView.spacing = 4
        tabBarsStackView.distribution = .fillEqually
    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
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
}
