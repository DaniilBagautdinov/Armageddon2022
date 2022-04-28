//
//  FilterViewController.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 26.04.2022.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func setFilter(distanceInKilometers: Bool, isDangerousAsteroids: Bool)
}

class FilterViewController: UIViewController {
    ///Properties
    var distanceInKilometers: Bool?
    var isDangerousAsteroids: Bool?
    weak var delegate: FilterViewControllerDelegate?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private function and action
    
    @IBAction func saveButton(_ sender: Any) {
        guard let filterView = view as? FilterView else { return }
        guard var distanceInKilometers = distanceInKilometers else { return }
        guard var isDangerousAsteroids = isDangerousAsteroids else { return }
        
        if filterView.distanceSegmentedControl.selectedSegmentIndex == 0 {
            self.distanceInKilometers = true
            distanceInKilometers = true
        } else {
            self.distanceInKilometers = false
            distanceInKilometers = false
        }
        
        if filterView.dangerousSwitch.isOn {
            self.isDangerousAsteroids = true
            isDangerousAsteroids = true
        } else {
            self.isDangerousAsteroids = false
            isDangerousAsteroids = false
        }
        
        delegate?.setFilter(distanceInKilometers: distanceInKilometers, isDangerousAsteroids: isDangerousAsteroids)
    }
    
    private func configureView() {
        navigationController?.navigationBar.topItem?.backButtonTitle = "Назад"
        guard let filterView = view as? FilterView else { return }
        guard let distanceInKilometers = distanceInKilometers else { return }
        guard let isDangerousAsteroids = isDangerousAsteroids else { return }

        if distanceInKilometers {
            filterView.distanceSegmentedControl.selectedSegmentIndex = 0
        } else {
            filterView.distanceSegmentedControl.selectedSegmentIndex = 1
        }
        
        if !isDangerousAsteroids {
            filterView.dangerousSwitch.setOn(false, animated: true)
        } else {
            filterView.dangerousSwitch.setOn(true, animated: true)
        }
    }
}
