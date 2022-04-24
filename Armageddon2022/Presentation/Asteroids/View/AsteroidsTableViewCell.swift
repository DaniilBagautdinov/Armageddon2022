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
    
    func setData(asteroid: Asteroid) {
        asteroidImageView.image = setImage(asteroid: asteroid)
        asteroidNameLabel.text = "\(asteroid.name ?? "")"
        asteroidDiameterLabel.text = "Диаметр: \(Int((asteroid.diameterMax + asteroid.diameterMin)/2)) м"
        asteroidDateLabel.text = setDate(asteroid: asteroid)
        asteroidDistanceLabel.text = "на расстояние \(Int(asteroid.missDistance).description) км"
        if asteroid.isPotentiallyHazardousAsteroid {
            asteroidEstimationLabel.text = "Оценка: опасен"
        } else {
            asteroidEstimationLabel.text = "Оценка: не опасен"
        }
    }
    
    private func setImage(asteroid: Asteroid) -> UIImage? {
        let diameter = Int((asteroid.diameterMax + asteroid.diameterMin)/2)
        if diameter < 150 {
            if asteroid.isPotentiallyHazardousAsteroid {
                return UIImage(named: "asteroid 4")
            } else {
                return UIImage(named: "asteroid 1")
            }
        } else if diameter < 600 && diameter > 150 {
            if asteroid.isPotentiallyHazardousAsteroid {
                return UIImage(named: "asteroid 5")
            } else {
                return UIImage(named: "asteroid 2")
            }
        } else if diameter > 600 {
            if asteroid.isPotentiallyHazardousAsteroid {
                return UIImage(named: "asteroid 6")
            } else {
                return UIImage(named: "asteroid 3")
            }
        }
        return UIImage()
    }
    
    private func setDate(asteroid: Asteroid) -> String{
        var dates = asteroid.date?.split(separator: "-")
        var mounth = ""
        if ((dates?[2].contains("0")) != nil) {
            dates?[2].removeFirst()
        }
        switch(dates?[1]) {
        case "01": mounth = "января"
        case "02": mounth = "февраля"
        case "03": mounth = "марта"
        case "04": mounth = "апреля"
        case "05": mounth = "мая"
        case "06": mounth = "июня"
        case "07": mounth = "июля"
        case "08": mounth = "августа"
        case "09": mounth = "сентября"
        case "10": mounth = "октября"
        case "11": mounth = "ноября"
        case "12": mounth = "декабря"
            
        case .none: break
        case .some(_): break
        }
        return "Подлетает \(dates?[2] ?? "") \(mounth) \(dates?[0] ?? "")"
    }
}
