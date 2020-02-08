//
//  ImageListCollectionViewController-asdf.swift
//  TopPic
//
//  Created by Leialey on 08.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit

//Display 2 items per row in the collection view
extension ImageListCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 5)/itemsPerRow
        return CGSize(width: width, height: width)
    }
}
