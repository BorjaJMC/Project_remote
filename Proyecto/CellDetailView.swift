//
//  CellDetailView.swift
//  Proyecto
//
//  Created by Borja Martín on 15/3/22.
//

import UIKit

class CellDetailView: UITableViewCell {
    
    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
