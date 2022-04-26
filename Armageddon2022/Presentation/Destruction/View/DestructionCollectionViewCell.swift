//
//  DestructionCollectionViewCell.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 26.04.2022.
//

import UIKit

class DestructionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var asteroidNameLabel: UILabel!
    @IBOutlet weak var asteroidImageView: UIImageView!
    
    func setData(asteroid: Asteroid) {
        configureViewCell()
        asteroidImageView.image = setImage(asteroid: asteroid)
        asteroidNameLabel.text = setName(asteroid: asteroid)
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
    
    private func setName(asteroid: Asteroid) -> String? {
        var result = ""
        if let index = asteroid.name?.range(of: "(")?.lowerBound {
            result = String(asteroid.name?[index...] ?? "")
        }
        if result.first == "(" {
            result.removeFirst()
            result.removeLast()
        }
        return result
    }
    
    private func configureViewCell() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.3
        layer.cornerRadius = 15
    }
}
