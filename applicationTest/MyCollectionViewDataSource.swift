//
//  MyCollectionViewDataSource.swift
//  applicationTest
//
//  Created by cyril perier on 23/06/2023.
//

import Foundation

import UIKit
import Reusable

class MyCollectionViewDataSource: NSObject {
    
    // MARK: - Public Var
    
    var imageArray: [PixabayResponse]
    var selectedIndexes: [IndexPath] = []
    
    // MARK: - Private Var
    
    private weak var homePageViewController: HomePageViewController?
  
    // MARK: - Init
    
    required init?(imageArray:[PixabayResponse],homePageViewController:HomePageViewController) {
        self.imageArray = imageArray
        self.homePageViewController = homePageViewController
    }
}

// MARK: - Extension

extension MyCollectionViewDataSource: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.first?.hits.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as MyCollectionViewCell

        let urlString = imageArray[.zero].hits[indexPath.row].largeImageURL
        cell.setup(url: URL(string: urlString)!,isSelected:selectedIndexes.contains(indexPath))
        
        return cell
    }
}

extension MyCollectionViewDataSource:  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
          return CGSize(width: 100, height: 100)
      }
    
}

extension MyCollectionViewDataSource: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
          if let index = selectedIndexes.firstIndex(of: indexPath) {
              selectedIndexes.remove(at: index)
              homePageViewController?.imageArraySelected.remove(at: index)
          } else {
              selectedIndexes.append(indexPath)
              homePageViewController?.imageArraySelected.append(imageArray[.zero].hits[indexPath.row])
          }
          
          collectionView.reloadItems(at: [indexPath])
        homePageViewController?.showButtonValidate(selectedIndexes: selectedIndexes.count)
    }
}

