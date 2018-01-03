//
//  LayoutManager.swift
//  Project-Swift
//
//  Created by Erico GT on 04/04/17.
//  Copyright © 2017 Atlantic Solutions. All rights reserved.
//

import UIKit
import Kingfisher

enum AppStyle: Int {
    case Default    = 0
    case Light      = 1
    case Dark       = 2
    case Special    = 3
}

class LayoutStyleManager:AnyObject{
    
    //Properties:
    var style:AppStyle
    
    //Componentes gerais (bordas, fundos, etc)
    var colorView_Yellow:UIColor
    var colorView_SuperDark:UIColor
    
    //Textos
    var colorText_Yellow:UIColor
    var colorText_Blue:UIColor
    var colorText_Black:UIColor
    
    //Initializers:
    init(){
        self.style = .Default
        //
        colorView_Yellow = UIColor.init(red: 217.0/255.0, green: 135.0/255.0, blue: 6.0/255.0, alpha: 1.0)
        colorView_SuperDark = UIColor.init(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        
        //Textos
        colorText_Black = UIColor.black
        colorText_Yellow = UIColor.init(red: 217.0/255.0, green: 135.0/255.0, blue: 6.0/255.0, alpha: 1.0)
        colorText_Blue = UIColor.init(red: 119.0/255.0, green: 163.0/255.0, blue: 196.0/255.0, alpha: 1.0)
    }
    
    func setStyle(_ style:AppStyle){
        
        //MARK: Para criar aplicações com set de estilos, implementar as variações abaixo:
        switch style {
        case .Default, .Light, .Dark, .Special:
            self.style = .Default
            //
            
            
            //        case .Light:
            //            break
            //
            //        case .Dark:
            //            break
            //
            //        case .Special:
            //            break
            
        }
    }

    func createActivityIndicatorImageView(color:UIColor, position:ActivityIndicatorImageView.IndicatorPosition, parentImageView:UIImageView) -> ActivityIndicatorImageView{
        
        let aiiv:ActivityIndicatorImageView = ActivityIndicatorImageView.init(activityIndicatorStyle: .whiteLarge)
        aiiv.color = color
        aiiv.parentIV = parentImageView
        aiiv.positionInImageView = position
        //
        return aiiv
    }
    
    func createAccessoryView(targetView:UIView, selector:Selector) -> UIView{
        
        let view:UIView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        view.backgroundColor = UIColor.init(red: 209.0/255.0, green: 213.0/255.0, blue: 219.0/255.0, alpha: 1.0)
        //
        let btnApply:UIButton = UIButton.init(frame: CGRect.init(x: view.frame.size.width/2, y: 0.0, width: view.frame.size.width/2, height: 44.0))
        btnApply.contentHorizontalAlignment = .right
        btnApply.addTarget(targetView, action: selector, for: .touchUpInside)
        btnApply.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 14)
        btnApply.setTitleColor(self.colorText_Blue, for: .normal)
        btnApply.titleLabel?.font = UIFont.init(name: App.Constants.FONT_SAN_FRANCISCO_MEDIUM, size: App.Constants.FONT_SIZE_BUTTON_TITLE)
        btnApply.setTitle(App.STR("BUTTON_TITLE_ACCESSORY_VIEW_DONE"), for: .normal)
        //
        view.addSubview(btnApply)
        //
        return view
    }
    
}

class ActivityIndicatorImageView:UIActivityIndicatorView, Indicator{
    
    enum IndicatorPosition: Int {
        case TopLeft            = 0
        case TopCenter          = 1
        case TopRight           = 2
        //
        case MidleLeft          = 3
        case MidleCenter        = 4
        case MidleRight         = 5
        //
        case BottomLeft         = 6
        case BottomCenter       = 7
        case BottomRight        = 8
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    override init(activityIndicatorStyle style: UIActivityIndicatorViewStyle) {
        super.init(activityIndicatorStyle: style)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func startAnimatingView(){
        self.startAnimating()
    }
    
    func stopAnimatingView(){
        self.stopAnimating()
    }
    
    var viewCenter: CGPoint {
        get{
            return self.center
        }
        set{
            if (parentIV != nil){
                switch positionInImageView {
                case .TopLeft:
                    self.center = CGPoint.init(x: 37.0, y: 37.0)
                case .TopCenter:
                    self.center = CGPoint.init(x: ((parentIV?.frame.size.width)! / 2.0), y: 37.0)
                case .TopRight:
                    self.center = CGPoint.init(x: (parentIV?.frame.size.width)! - 37.0, y: 37.0)
                //
                case .MidleLeft:
                    self.center = CGPoint.init(x: 37.0, y: ((parentIV?.frame.size.height)! / 2.0))
                case .MidleCenter:
                    self.center = CGPoint.init(x: ((parentIV?.frame.size.width)! / 2.0), y: ((parentIV?.frame.size.height)! / 2.0))
                case .MidleRight:
                    self.center = CGPoint.init(x: (parentIV?.frame.size.width)! - 37.0, y: ((parentIV?.frame.size.height)! / 2.0))
                //
                case .BottomLeft:
                    self.center = CGPoint.init(x: 37.0, y: (parentIV?.frame.size.height)! - 37.0 - 10.0)
                case .BottomCenter:
                    self.center = CGPoint.init(x: ((parentIV?.frame.size.width)! / 2.0), y: (parentIV?.frame.size.height)! - 37.0)
                case .BottomRight:
                    self.center = CGPoint.init(x: (parentIV?.frame.size.width)! - 37.0, y: (parentIV?.frame.size.height)! - 37.0)
                }
            }else{
                self.center = newValue
            }
        }}
    
    var view: IndicatorView {
        get{
            return self
        }
    }
    
    //internal
    var positionInImageView:IndicatorPosition = .MidleCenter
    var parentIV:UIImageView? = nil
    
    private func commonInit(){
        self.color = UIColor.white
        self.hidesWhenStopped = true
    }
}
