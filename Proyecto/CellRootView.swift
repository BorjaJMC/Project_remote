//
//  CellRootView.swift
//  Proyecto
//
//  Created by Borja Martín on 9/3/22.
//

import UIKit

class CellRootView: UITableViewCell {
    
    @IBOutlet weak var imagenRoot: UIImageView!
    @IBOutlet weak var titleFilm: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
}
