//
//  Created by Mitja Semolic on 02/08/2017.
//  Copyright © 2017 Mitja Semolic. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

// MARK: - IBOutlet

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
// MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbImage.layer.cornerRadius = 5
        thumbImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
