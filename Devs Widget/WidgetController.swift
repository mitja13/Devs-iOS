//
//  Created by Mitja Semolic on 07/08/2017.
//  Copyright © 2017 Mitja Semolic. All rights reserved.
//

import UIKit
import NotificationCenter

class WidgetController: UIViewController, NCWidgetProviding {
    
// MARK: - IBOutlet

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
// MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thumbImage.layer.cornerRadius = 5
        thumbImage.clipsToBounds = true

        shareFromApp()
    }
    
// MARK: - UserDefaults

    func shareFromApp() {
        print("shareFromApp")
        let name = UserDefaults.init(suiteName: "group.co.mitja.devs-ios")?.value(forKey: "name")
        let desc = UserDefaults.init(suiteName: "group.co.mitja.devs-ios")?.value(forKey: "desc")
        let thumbUrl = UserDefaults.init(suiteName: "group.co.mitja.devs-ios")?.value(forKey: "thumbUrl")
        nameLabel.text = name as? String
        descLabel.text = desc as? String
        loadImageAsync(url: thumbUrl as! String, imageView: thumbImage)
    }
    
// MARK: - NCWidgetProviding
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        print("widgetPerformUpdate")
        
        shareFromApp()
        completionHandler(NCUpdateResult.newData)
    }
}

// MARK: - Load Image

public func loadImageAsync(url: String, imageView: UIImageView) {

    URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
        (data, response, error) -> Void in

        if let error = error {
            print("error: fetching github image, \(error))")
            return
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            let image = UIImage(data: data!)
            imageView.image = image
        })

    }).resume()
}
