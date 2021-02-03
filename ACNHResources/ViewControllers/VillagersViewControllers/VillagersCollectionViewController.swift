//
//  VillagersCollectionViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 25/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class VillagersCollectionViewController: UICollectionViewController {
    
    private let headerReuseIdentifier = "Header"
    
    var villagers = [Villager]()
    var filteredVillagers = [Villager]()
    var isFiltering = false
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        update()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        collectionView.register(VillagerCell.self, forCellWithReuseIdentifier: VillagerCell.reuseIdentifier)
    }
    
    private func update() {
        villagers = Current.persistenceManager.retrieve(objectsOfType: Villager.self)
            .filter { $0.isOwned }
            .sorted { $0.name < $1.name }
        
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? filteredVillagers.count : villagers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VillagerCell.reuseIdentifier, for: indexPath) as! VillagerCell
        let activeVillagersArray = isFiltering ? filteredVillagers : villagers
        cell.configure(with: activeVillagersArray[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeVillagersArray = isFiltering ? filteredVillagers : villagers
        
        let villagerDetailsViewController = VillagerDetailsViewController(with: activeVillagersArray[indexPath.row])
        presentViewController(villagerDetailsViewController)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        header.backgroundColor = .systemIndigo
        
        let headerTitle = UILabel().adjustedForAutoLayout()
        headerTitle.configureHeaderLabel(text: "My Villagers", textAlignment: .left)
        header.addSubview(headerTitle)

        let horizontalPadding: CGFloat = 20
        let verticalPadding: CGFloat = 16

        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: header.topAnchor, constant: verticalPadding),
            headerTitle.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -verticalPadding),
            headerTitle.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            headerTitle.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding)
        ])
        
        return header
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(131))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            
            return layoutSection
        }
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        config.boundarySupplementaryItems = [header]
        layout.configuration = config
        
        return layout
    }
}

extension VillagersCollectionViewController: VillagersTableViewControllerDelegate {
    
    func didTapCheckmarkButton() {
        update()
    }
}
