//
//  PullRequest_TVC.swift
//  FinnersTest
//
//  Created by Lucas Castro on 02/01/2018.
//  Copyright © 2018 Atlantic Solutions. All rights reserved.
//

import UIKit

class PullRequest_TVC: UITableViewCell {
    
    @IBOutlet weak var lblPRTitle:UILabel!
    @IBOutlet weak var lblPRBody:UILabel!
    @IBOutlet weak var lblOwnerName:UILabel!
    @IBOutlet weak var imvOwnerAvatar:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupaLayout() {
        
        lblPRBody.backgroundColor = nil
        lblOwnerName.backgroundColor = nil
        lblPRTitle.backgroundColor = nil
        //
        lblOwnerName.textColor = App.Style.colorText_Blue
        lblPRTitle.textColor = App.Style.colorText_Blue
        lblPRBody.textColor = App.Style.colorText_Black
        //
        lblPRTitle.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_REGULAR, size: App.Constants.FONT_SIZE_LABEL_NORMAL)
        lblOwnerName.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_REGULAR, size: App.Constants.FONT_SIZE_LABEL_SMALL)
        lblPRBody.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_REGULAR, size: App.Constants.FONT_SIZE_LABEL_SMALL)
        //
        imvOwnerAvatar.layer.cornerRadius = imvOwnerAvatar.frame.size.width / 2
        imvOwnerAvatar.clipsToBounds = true
    }

}
