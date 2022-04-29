//
//  CeldaPaisTableViewCell.swift
//  ListaPaisesCovid
//
//  Created by mac16 on 29/04/22.
//

import UIKit

class CeldaPaisTableViewCell: UITableViewCell {

    @IBOutlet weak var activosLabel: UILabel!
    @IBOutlet weak var nombrePaisLabel: UILabel!
    @IBOutlet weak var recuperadosLabel: UILabel!
    @IBOutlet weak var banderaPais: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Redondear imagen
        banderaPais.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
