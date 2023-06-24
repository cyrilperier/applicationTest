//
//  TableViewCell.swift
//  applicationTest
//
//  Created by cyril perier on 24/06/2023.
//

import UIKit
import Reusable
import AlamofireImage

class TableViewCell: UITableViewCell,NibReusable {

    @IBOutlet private var tableViewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(url:URL) {
        tableViewImageView.af.setImage(withURL: url)
    }
    
}
