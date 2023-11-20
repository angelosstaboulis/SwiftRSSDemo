//
//  RSSCell.swift
//  SwiftRSS
//
//  Created by Angelos Staboulis on 20/11/23.
//

import UIKit

class RSSCell: UITableViewCell {

    @IBOutlet weak var CmdLink: UIButton!
    @IBOutlet weak var lblPubDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
