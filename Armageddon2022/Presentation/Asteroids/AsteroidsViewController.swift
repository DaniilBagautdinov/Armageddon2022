//
//  ViewController.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 22.04.2022.
//

import UIKit

class AsteroidsViewController: UIViewController {
    ///Properties
    var asteroidsNow: [Asteroid]?
    var allAsteroids: [Asteroid] = DataService.shared.getAllAsteroids()
    var dangerousAsteroids: [Asteroid] = DataService.shared.getAllDangerousAsteroids()
    var distanceInKilometers: Bool?
    var isDangerousAsteroids: Bool?
    var scrollOn: Bool = true
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let asteroidsView = view as? AsteroidsView else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            if allAsteroids.count == 0 {
                allAsteroids = DataService.shared.getAllAsteroids()
                dangerousAsteroids = DataService.shared.getAllDangerousAsteroids()
                asteroidsNow = allAsteroids
                asteroidsView.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Private function and action
    
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
        }
        
        guard let asteroidsView = view as? AsteroidsView else { return }
        asteroidsView.collectionView.delegate = self
        asteroidsView.collectionView.dataSource = self
        distanceInKilometers = true
        isDangerousAsteroids = false
        asteroidsNow = allAsteroids
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension AsteroidsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let asteroidsNow = asteroidsNow {
            return asteroidsNow.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AsteroidsCollectionViewCell", for: indexPath) as? AsteroidsCollectionViewCell else { return UICollectionViewCell()}
        guard let distanceInKilometers = distanceInKilometers else { return UICollectionViewCell()}
        if let asteroidsNow = asteroidsNow {
            cell.setData(asteroid: asteroidsNow[indexPath.row], distanceInKilometers: distanceInKilometers)
            cell.delegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if let asteroidsNow = asteroidsNow {
            vc.closeApproachData = DataService.shared.getCloseApproachData(id: asteroidsNow[indexPath.row].id ?? "")
            vc.asteroid = asteroidsNow[indexPath.row]
            vc.distanceInKilometers = distanceInKilometers
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height > 0 && scrollOn {
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            var distanceFromBottom: CGFloat
            guard let isDangerousAsteroids = isDangerousAsteroids else { return }
            if isDangerousAsteroids {
                distanceFromBottom = scrollView.contentSize.height - contentYoffset - 5000
            } else {
                distanceFromBottom = scrollView.contentSize.height - contentYoffset - 20000
            }
            
            if distanceFromBottom < height && scrollOn{
                scrollOn = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                    scrollOn = true
                }
                let strDate = DataService.shared.getLastAsteroid()?.date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
                let date = dateFormatter.date(from: strDate ?? "")
                if let date = date {
                    guard let asteroidsView = view as? AsteroidsView else { return }
                    DataService.shared.getData(date: date + 86400)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                        allAsteroids = DataService.shared.getAllAsteroids()
                        dangerousAsteroids = DataService.shared.getAllDangerousAsteroids()
                        if isDangerousAsteroids {
                            asteroidsNow = dangerousAsteroids
                        } else {
                            asteroidsNow = allAsteroids
                        }
                        asteroidsView.collectionView.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AsteroidsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 330)
    }
}

// MARK: - FilterViewControllerDelegate

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

// MARK: - AsteroidsCollectionViewCellDelegate

extension AsteroidsViewController: AsteroidsCollectionViewCellDelegate {
    func updateInfo() {
        allAsteroids = DataService.shared.getAllAsteroids()
        dangerousAsteroids = DataService.shared.getAllDangerousAsteroids()
        guard let asteroidsView = view as? AsteroidsView else { return }
        guard let isDangerousAsteroids = isDangerousAsteroids else { return }
        if isDangerousAsteroids {
            asteroidsNow = dangerousAsteroids
        } else {
            asteroidsNow = allAsteroids
        }
        asteroidsView.collectionView.reloadData()
    }
}
