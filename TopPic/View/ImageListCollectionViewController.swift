//
//  ViewController.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import Bond

class ImageListCollectionViewController: UICollectionViewController, StatusBindable, ImageListViewModelBindable {    
    private let viewModel: ImageListViewModelProtocol = ImageListViewModel()
    private let cellID = "ImageCell"
    private lazy var currentIndex = IndexPath(item: 0, section: 0)
    let itemsPerRow: CGFloat = 2.0
    let minItemSpacing: CGFloat = 5.0
    let minLineSpacing: CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: cellID)
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.images.bind(to: self) { me, _ in
            me.collectionView.reloadData()
        }
        viewModel.status.bind(to: self) { me, status in
            me.bindStatus(status)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsToDisplay
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        viewModel.loadDataIfNeeded(indexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                                            for: indexPath) as? ImageCollectionViewCell else {
                                                                fatalError("Cannot cast to ImageCollectionViewCell")
        }
        cell.configureCell(viewModel.getCellViewModel(indexPath.item))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.images.value[safe: indexPath.row] != nil {
        performSegue(withIdentifier: "goToDetails", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard var nextVC = segue.destination as? ImageDetailsViewModelBindable else {
            fatalError("Cannot find implementation of ImageDetailsViewModelBindable")
        }
        guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
        // User can select only one cell
        nextVC.viewModel = viewModel.requestImageDetails(indexPath[0].item)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //We want to see the same item in the middle of the screen when rotating device
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)        //The middle point can lie between the lines so we need 2 points
        let points = [
            CGPoint(x: 0, y: visibleRect.midY),
            CGPoint(x: 0, y: visibleRect.midY - minLineSpacing)
        ]
        currentIndex = getMiddleItem(points)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let currentItemFrame = collectionView.layoutAttributesForItem(at: currentIndex)?.frame
        return CGPoint(x: 0, y: ((currentItemFrame?.midY ?? 0.0) - collectionView.frame.midY))
    }
    
    private func getMiddleItem(_ points: [CGPoint]) -> IndexPath {
        var index = IndexPath(item: 0, section: 0)
        for point in points {
            if let currentIndex = collectionView.indexPathForItem(at: point) {
                index = currentIndex
                break
            }
        }
        return index
    }
    
}
