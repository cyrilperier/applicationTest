//
//  MyCollectionViewCell.swift
//  applicationTest
//
//  Created by cyril perier on 23/06/2023.
//

import Foundation
import Reusable
import AlamofireImage

public enum Constant {
    public static let maxAlpha: Double = 1.0
    public static let minAlpha: Double = 0.5
}

class MyCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(url:URL,isSelected:Bool) {
        imageView.af.setImage(withURL: url)
        imageView.alpha = isSelected ? Constant.minAlpha : Constant.maxAlpha
    }
}
