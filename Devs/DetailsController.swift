//
//  Created by Mitja Semolic on 02/08/2017.
//  Copyright © 2017 Mitja Semolic. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {

// MARK: - IBOutlet

    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var registeredLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
// MARK: - Properties

    var developer: DeveloperDetails?
    
// MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendEmailButton.layer.cornerRadius = 8
        sendEmailButton.layer.borderWidth = 1
        sendEmailButton.layer.borderColor = sendEmailButton.tintColor.cgColor
        avatarImage.layer.cornerRadius = 15
        avatarImage.clipsToBounds = true
        
        updateDeveloper()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - Update

    func updateDeveloper() {
        nameLabel?.text = developer?.name
        loginLabel?.text = developer?.login
        bioLabel?.text = developer?.bio
        let registeredDate = formatDate(from: developer!.createdAt, format: "MMM YYYY")!
        registeredLabel?.text = "Registered since \(registeredDate)"
        locationLabel?.text = developer?.location
        emailLabel?.text = developer?.email
        loadImageAsync(url: developer!.avatarUrl, imageView: avatarImage)
    }
}

