//
//  PromoCell.swift
//  AppPromo
//
//  Created by anca dev on 22/03/24.
//

import UIKit

class PromoCell: UITableViewCell {

    @IBOutlet weak var imagePromo: UIImageView!
    @IBOutlet weak var labelPromo: UILabel!
    
    var alreadySetup: Bool = false
    
    func initialSetup(namaPromo: String) {
        labelPromo.text = namaPromo
        alreadySetup = true
    }
    
}
