//
//  ViewController.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 22.04.2022.
//

import UIKit

class AsteroidsViewController: UIViewController {
    
    var asteroidsNow: [Asteroid]?
    var allAsteroids: [Asteroid] = DataService.shared.getAllAsteroids()
    var dangerousAsteroids: [Asteroid] = DataService.shared.getAllDangerousAsteroids()
    var distanceInKilometers: Bool?
    var isDangerousAsteroids: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let asteroidsView = view as? AsteroidsView else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if allAsteroids.count == 0 {
                allAsteroids = DataService.shared.getAllAsteroids()
                asteroidsNow = allAsteroids
                asteroidsView.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func filterButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.distanceInKilometers = distanceInKilometers
        vc.isDangerousAsteroids = isDangerousAsteroids
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureView() {
        let lastAsteroidEntity = DataService.shared.getLastAsteroid()
        if lastAsteroidEntity == nil {
            DataService.shared.getData(date: Date())
        } else {
            let dates = lastAsteroidEntity?.date?.split(separator: "-")
            if dates?[2] ?? "" != Calendar.current.component(.day, from: Date()+604800).description {
                DataService.shared.getData(date: Date())
            }
        }
        
        guard let asteroidsView = view as? AsteroidsView else { return }
        asteroidsView.collectionView.delegate = self
        asteroidsView.collectionView.dataSource = self
        distanceInKilometers = true
        isDangerousAsteroids = false
        asteroidsNow = allAsteroids
    }
}

extension AsteroidsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let asteroidsNow = asteroidsNow {
            return asteroidsNow.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AsteroidsCollectionViewCell", for: indexPath) as? AsteroidsCollectionViewCell else { return UICollectionViewCell()}
        if let asteroidsNow = asteroidsNow {
            cell.setData(asteroid: asteroidsNow[indexPath.row], distanceInKilometers: distanceInKilometers ?? true)
        }
        return cell
    }
}


extension AsteroidsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 330)
    }
}

extension AsteroidsViewController: FilterViewControllerDelegate {
    func setFilter(distanceInKilometers: Bool, isDangerousAsteroids: Bool) {
        self.distanceInKilometers = distanceInKilometers
        self.isDangerousAsteroids = isDangerousAsteroids
        
        guard let asteroidsView = view as? AsteroidsView else { return }
        if isDangerousAsteroids {
            asteroidsNow = dangerousAsteroids
        } else {
            asteroidsNow = allAsteroids
        }
        asteroidsView.collectionView.reloadData()
    }
}
