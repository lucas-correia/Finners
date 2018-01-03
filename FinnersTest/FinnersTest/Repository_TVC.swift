//
//  Repository_TVC.swift
//  FinnersTest
//
//  Created by Lucas Castro on 02/01/2018.
//  Copyright © 2018 Atlantic Solutions. All rights reserved.
//

import UIKit

class Repository_TVC: UITableViewCell {

    @IBOutlet weak var viewRepoInfo:UIView!
    @IBOutlet weak var viewOwnerInfo:UIView!
    //
    @IBOutlet weak var lblRepoName:UILabel!
    @IBOutlet weak var lblRepoDescription:UILabel!
    @IBOutlet weak var lblRepoStars:UILabel!
    @IBOutlet weak var lblRepoForks:UILabel!
    @IBOutlet weak var imvRepoFork:UIImageView!
    @IBOutlet weak var imvRepoStar:UIImageView!
    //
    @IBOutlet weak var imvOwnerAvatar:UIImageView!
    @IBOutlet weak var lblOwnerName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLayout() {
        
        viewRepoInfo.backgroundColor = nil
        viewOwnerInfo.backgroundColor = nil
        lblRepoDescription.backgroundColor = nil
        lblRepoName.backgroundColor = nil
        lblRepoForks.backgroundColor = nil
        lblRepoStars.backgroundColor = nil
        imvRepoFork.backgroundColor = nil
        imvRepoStar.backgroundColor = nil
        imvOwnerAvatar.backgroundColor = nil
        lblOwnerName.backgroundColor = nil
        //
        lblRepoName.textColor = App.Style.colorText_Blue
        lblOwnerName.textColor = App.Style.colorText_Blue
        imvRepoFork.image = App.Utils.graphicHelper_TintImage(tintColor: App.Style.colorView_Yellow, templateImage: UIImage.init(named: "fork"))
        lblRepoForks.textColor = App.Style.colorText_Yellow
        imvRepoStar.image = App.Utils.graphicHelper_TintImage(tintColor: App.Style.colorView_Yellow, templateImage: UIImage.init(named: "star"))
        lblRepoStars.textColor = App.Style.colorText_Yellow
        lblRepoDescription.textColor = App.Style.colorText_Black
        //
        lblRepoName.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_REGULAR, size: App.Constants.FONT_SIZE_LABEL_NORMAL)
        lblRepoDescription.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_REGULAR, size: App.Constants.FONT_SIZE_LABEL_SMALL)
        lblOwnerName.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_REGULAR, size: App.Constants.FONT_SIZE_LABEL_SMALL)
        lblRepoForks.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_REGULAR, size: App.Constants.FONT_SIZE_LABEL_NORMAL)
        lblRepoStars.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_REGULAR, size: App.Constants.FONT_SIZE_LABEL_NORMAL)
        //
        imvOwnerAvatar.layer.cornerRadius = imvOwnerAvatar.frame.size.width / 2
        imvOwnerAvatar.clipsToBounds = true
    }

}
