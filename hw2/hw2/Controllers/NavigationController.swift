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
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setup()
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
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes
            = [.font: UIFont.habibi(size: FontSize.largeTitleText, textStyle: .largeTitle)]
        navBarAppearance.titleTextAttributes
            = [.font: UIFont.habibi(size: FontSize.titleText, textStyle: .headline)]
        navBarAppearance.backgroundColor = Asset.Colors.navigationBar.color
        let backButtonImage = Asset.Images.backButton.image
        navBarAppearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.prefersLargeTitles = true
        navigationBar.isOpaque = true

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes
            = [.font: UIFont.habibi(size: FontSize.searchBarPlaceholder, textStyle: .body)]
    }
}
