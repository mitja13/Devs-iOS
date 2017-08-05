//
//  Created by Mitja Semolic on 04/08/2017.
//  Copyright © 2017 Mitja Semolic. All rights reserved.
//

import UIKit

// MARK: - Format

func formatNumber(from: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.decimal
    return formatter.string(from: NSNumber(value: from))!
}

func formatDate(from: String, format: String) -> String? {
    guard let date = ISO8601DateFormatter().date(from: from) else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

func formatPoints(from: Int) -> String {
    let number = Double(from)
    let thousand = number / 1000
    let million = number / 1000000
    
    if million >= 1.0 { return "\(round(million*10)/10)M" }
    else if thousand >= 1.0 { return "\(round(thousand*10)/10)k" }
    else { return "\(Int(number))"}
}

// MARK: - Load

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
