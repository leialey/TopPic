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
    var viewModel: ImageListViewModelProtocol = ImageListViewModel()
    private let cellID = "ImageCell"
    let itemsPerRow: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        bindViewModel()
    }
    
    func bindViewModel() {
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         viewModel.loadDataIfNeeded(indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ImageCollectionViewCell else { fatalError("Cannot cast to ImageCollectionViewCell")}
        cell.viewModel = viewModel.configureCell(indexPath.row)
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard var nextVC = segue.destination as? ImageDetailsViewModelBindable else {fatalError("Cannot find implementation of ImageDetailsViewModelBindable")}
        guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
        // User can select only one cell
        nextVC.viewModel = viewModel.requestImageDetails(indexPath[0].row)
    }
}


