//
//  NavigationController.swift
//  hw2
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit

final class NavigationController: UINavigationController {
    
    // MARK: - Constants
    
    private enum FontSize {
        static let largeTitleText: CGFloat = 34
        static let titleText: CGFloat = 17
        static let searchBarPlaceholder: CGFloat = 17
    }
    
    // MARK: - Overridden Internal Methods
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setupBackButton()
        }
    }
    
    // MARK: - Initializers
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes
            = [.font: UIFont.habibi(size: FontSize.largeTitleText, textStyle: .largeTitle)]
        navigationBar.titleTextAttributes
            = [.font: UIFont.habibi(size: FontSize.titleText, textStyle: .headline)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes
            = [.font: UIFont.habibi(size: FontSize.searchBarPlaceholder, textStyle: .body)]
        setupBackButton()
    }
    
    private func setupBackButton() {
        navigationBar.backIndicatorImage = Asset.Images.backButton.image
        navigationBar.backIndicatorTransitionMaskImage = Asset.Images.backButton.image
    }
}
