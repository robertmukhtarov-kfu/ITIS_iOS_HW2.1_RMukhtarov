//
//  AvatarImageView.swift
//  hw2
//
//  Created by RRMukhtarov on 20.10.2021.
//

import UIKit
import SnapKit

final class AvatarView: UIView {
    
    // MARK: - Private Properties
    
    private var image: UIImage?
    private var name = ""
    
    // MARK: - Views
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .habibi(size: 17, textStyle: .body)
        label.textAlignment = .center
        label.backgroundColor = Asset.Colors.chatListGray.color
        label.textColor = Asset.Colors.socialBlue.color
        label.text = ""
        if let firstLetter = name.first {
            label.text?.append(firstLetter)
        }
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Internal Methods
    
    func configure(withImage image: UIImage?, withName name: String) {
        self.image = image
        self.name = name
        image == nil ? setupWithName() : setupWithImage()
    }
    
    // MARK: - Overridden Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
    }
    
    // MARK: - Private Methods
    
    private func setupWithName() {
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupWithImage() {
        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
