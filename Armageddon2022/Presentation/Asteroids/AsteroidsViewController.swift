//
//  ViewController.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 22.04.2022.
//

import UIKit

class AsteroidsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var asteroids: [Asteroid] = DataService.shared.getAllAsteroids()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if asteroids.count == 0 {
                asteroids = DataService.shared.getAllAsteroids()
                collectionView.reloadData()
            }
        }
    }
    
    @IBAction func filterButton(_ sender: Any) {
        
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
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}

extension AsteroidsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return asteroids.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AsteroidsCollectionViewCell", for: indexPath) as? AsteroidsCollectionViewCell else { return UICollectionViewCell()}
        cell.setData(asteroid: asteroids[indexPath.row])
        return cell
    }
}


extension AsteroidsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
