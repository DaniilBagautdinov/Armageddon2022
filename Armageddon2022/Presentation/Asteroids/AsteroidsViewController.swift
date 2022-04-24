//
//  ViewController.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 22.04.2022.
//

import UIKit

class AsteroidsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var asteroids: [Asteroid] = DataService.shared.getAllAsteroids()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        
    }
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AsteroidsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AsteroidsTableViewCell", for: indexPath) as? AsteroidsTableViewCell else { return UITableViewCell()}
        cell.setData(asteroid: asteroids[indexPath.row])
        return cell
    }
}
