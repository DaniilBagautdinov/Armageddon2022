//
//  DestructionViewController.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 26.04.2022.
//

import UIKit

class DestructionViewController: UIViewController {
    
    var allDestroyAsteroids: [Asteroid] = DataService.shared.getAllDestroyAsteroids()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let destructionView = view as? DestructionView else { return }
        allDestroyAsteroids = DataService.shared.getAllDestroyAsteroids()
        destructionView.collectionView.reloadData()
    }
    
    
    @IBAction func clearButton(_ sender: Any) {
        if allDestroyAsteroids.count > 0 {
            let alertController = UIAlertController(title: "Уничтожить астероиды", message: "Уничтоженные астероиды нельзя будет восстановить" , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Уничтожить", style: .destructive, handler: { [self] _ in
                DataService.shared.clearDestroyAsteroids()
                guard let destructionView = view as? DestructionView else { return }
                allDestroyAsteroids = DataService.shared.getAllDestroyAsteroids()
                destructionView.collectionView.reloadData()
            }))
            alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: {_ in
                alertController.dismiss(animated: true)
            }))
            present (alertController, animated: true)
        }
    }
    
    private func configureView() {
        guard let destructionView = view as? DestructionView else { return }
        destructionView.collectionView.delegate = self
        destructionView.collectionView.dataSource = self
    }
}

extension DestructionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allDestroyAsteroids.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestructionCollectionViewCell", for: indexPath) as? DestructionCollectionViewCell else { return UICollectionViewCell()}
        cell.setData(asteroid: allDestroyAsteroids[indexPath.row])
        return cell
    }
}


extension DestructionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 167)
    }
}
