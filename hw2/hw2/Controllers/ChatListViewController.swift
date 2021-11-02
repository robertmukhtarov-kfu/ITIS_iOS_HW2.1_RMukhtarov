//
//  ChatListViewController.swift
//  hw2
//
//  Created by RRMukhtarov on 10.10.2021.
//

import UIKit

final class ChatListViewController: UIViewController {
    
    // MARK: - Collection View Sections
    
    private enum Section: Int, CaseIterable {
        case pinnedChats
        case chatList
    }
    
    // MARK: - Constants
    
    private enum LayoutConstants {
        enum PinnedChats {
            static let itemHeight: CGFloat = 72.0
            static let itemWidth: CGFloat = 48.0
            static let spacing: CGFloat = 32.0
            static let horizontalInset: CGFloat = 24.0
            static let headerHeight: CGFloat = 4.0
        }
        
        enum ChatList {
            static let itemHeight: CGFloat = 92.0
            static let headerHeight: CGFloat = 20.0
        }
    }
    
    // MARK: - Reuse Identifiers
    
    private let pinnedChatsHeaderReuseIdentifier = "pinnedChatsHeaderReuseIdentifier"
    private let pinnedChatCellReuseIdentifier = "pinnedChatCellReuseIdentifier"
    private let chatListCellReuseIdentifier = "chatListCellReuseIdentifier"
    private let chatListHeaderReuseIdentifier = "chatListHeaderReuseIdentifier"
    
    // MARK: - Private Properties
    
    private lazy var dataSource = makeDataSource()
    
    // MARK: - Views
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeCompositionalLayout()
    )
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: - Private Methods: View Setup
    
    private func setupView() {
        view.backgroundColor = Asset.Colors.background.color
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Who do you want to chat with?"
        
        title = "MESSAGES"
        navigationItem.backButtonTitle = ""
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        setupCollectionView()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Private Methods: Collection View Setup
    
    private func setupCollectionView() {
        collectionView.dataSource = dataSource
        
        collectionView.register(
            PinnedChatCell.self,
            forCellWithReuseIdentifier: pinnedChatCellReuseIdentifier
        )
        collectionView.register(
            ChatListCell.self,
            forCellWithReuseIdentifier: chatListCellReuseIdentifier
        )
        collectionView.register(
            PinnedChatsHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: pinnedChatsHeaderReuseIdentifier
        )
        collectionView.register(
            ChatListHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: chatListHeaderReuseIdentifier
        )
        
        collectionView.backgroundColor = Asset.Colors.background.color
        
        dataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath -> UICollectionReusableView? in
            
            switch indexPath.section {
            case 0:
                return collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: self.pinnedChatsHeaderReuseIdentifier,
                    for: indexPath
                ) as? PinnedChatsHeader
            case 1:
                return collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: self.chatListHeaderReuseIdentifier,
                    for: indexPath
                ) as? ChatListHeader
            default:
                fatalError("Invalid section")
            }
        }
        
        let pinnedChats = PinnedChat.exampleValues
        let chatPreviews = ChatListItem.exampleValues
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(pinnedChats, toSection: .pinnedChats)
        snapshot.appendItems(chatPreviews, toSection: .chatList)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, _ -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return self.makePinnedChatsLayoutSection()
            case 1:
                return self.makeChatListLayoutSection()
            default:
                fatalError("Invalid section")
            }
        }
    }
    
    private func makePinnedChatsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(LayoutConstants.PinnedChats.itemWidth),
            heightDimension: .estimated(LayoutConstants.PinnedChats.itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: itemSize.widthDimension,
            heightDimension: itemSize.heightDimension
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = LayoutConstants.PinnedChats.spacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0.0,
            leading: LayoutConstants.PinnedChats.horizontalInset,
            bottom: 0.0,
            trailing: LayoutConstants.PinnedChats.horizontalInset
        )
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(LayoutConstants.PinnedChats.headerHeight)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func makeChatListLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(LayoutConstants.ChatList.itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: itemSize.heightDimension
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(LayoutConstants.ChatList.headerHeight)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, AnyHashable> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item -> UICollectionViewCell? in
            
            let cell: UICollectionViewCell
            switch indexPath.section {
            case 0:
                guard let pinnedChatCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: self.pinnedChatCellReuseIdentifier,
                    for: indexPath
                ) as? PinnedChatCell,
                     let pinnedChat = item as? PinnedChat
                else { fatalError("Failed to dequeue pinnedChatCell") }
                
                pinnedChatCell.configure(with: pinnedChat)
                cell = pinnedChatCell
            case 1:
                guard let chatListCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: self.chatListCellReuseIdentifier,
                    for: indexPath
                ) as? ChatListCell,
                    let chatListItem = item as? ChatListItem
                else { fatalError("Failed to dequeue chatListCell") }
                
                chatListCell.configure(with: chatListItem)
                cell = chatListCell
            default:
                fatalError("Invalid section")
            }
            
            cell.layoutIfNeeded()
            return cell
        }
    }
}
