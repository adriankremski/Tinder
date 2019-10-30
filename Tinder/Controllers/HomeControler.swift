//
//  ViewController.swift
//  Tinder
//
//  Created by Adrian Kremski on 29/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottomStackView = HomeBottomControllsStackView()
    
    let cardViewModels: [CardViewModel] = {
        let producers = [User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["jane1", "jane2", "jane3",]),
                   Advertiser(title: "Slide Out Menu", brandName: "Lets Build That App", posterPhotoName: "slide_out_menu_poster"),
                   User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["kelly1", "kelly2", "kelly3"])] as [ProducesCardViewModel]
        
        let viewModels = producers.map { (producer) -> CardViewModel in
            producer.toCardViewModel()
        }
        
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }
    
    //MARK: - Fileprivate
    fileprivate func setupLayout() {        
        let mainStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView])
        mainStackView.axis = .vertical
        view.addSubview(mainStackView)
        mainStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = .init(top: 0, left:12, bottom:0, right: 12)
        
        mainStackView.bringSubviewToFront(cardsDeckView)
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (viewModel) in
            let cardView = CardView()
            cardView.viewModel = viewModel
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
}

