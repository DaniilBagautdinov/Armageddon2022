//
//  DetailTableViewCell.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 28.04.2022.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    ///Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var relativeVelocityLabel: UILabel!
    @IBOutlet weak var orbitingBodyLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Set data function
    
    func setData(closeApproachDatum: CloseApproachData, distanceInKilometers: Bool) {
        let strDate = (closeApproachDatum.closeApprouchDate ?? "") + " " + (closeApproachDatum.closeApprouchDateFull?.split(separator: " ")[1] ?? "")
        dateLabel.text = "Пролетал(пролетит) мимо Земли: \(strDate)"
        if distanceInKilometers {
            distanceLabel.text = "Расстояние до Земли:  \(Int(closeApproachDatum.missDistanceKilometers).description) км"
        } else {
            distanceLabel.text = "Расстояние до Земли: \(Int(closeApproachDatum.missDistanceLunar).description) л. орб."
        }
        relativeVelocityLabel.text = "Скорость относительно Земли: \(Int(closeApproachDatum.kilometersPerSecond)) км/с"
        orbitingBodyLabel.text = "Летит по орбите вокруг: \(getPlanetTitle(planet: closeApproachDatum.orbitingBody ?? ""))"
        
        dateLabel.setFont()
        distanceLabel.setFont()
        relativeVelocityLabel.setFont()
        orbitingBodyLabel.setFont()
    }
    
    // MARK: - Private function
    
    private func getPlanetTitle(planet: String) -> String {
        switch planet {
        case "Merc": return "Меркурия"
        case "Venus": return "Венеры"
        case "Earth": return "Земли"
        case "Mars": return "Марса"
        case "Jupiter": return "Юпитера"
        case "Uranus": return "Урана"
        case "Neptune": return "Нептуна"
        case "Pluto": return "Плутона"
        default: return "Земли"
        }
    }
}
