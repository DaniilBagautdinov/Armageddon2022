//
//  AsteroidsTableViewCell.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//

import UIKit

class AsteroidsTableViewCell: UITableViewCell {

    @IBOutlet weak var asteroidImageView: UIImageView!
    @IBOutlet weak var asteroidNameLabel: UILabel!
    @IBOutlet weak var asteroidDiameterLabel: UILabel!
    @IBOutlet weak var asteroidDateLabel: UILabel!
    @IBOutlet weak var asteroidDistanceLabel: UILabel!
    @IBOutlet weak var asteroidEstimationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func destroyButton(_ sender: Any) {
        
    }
}
