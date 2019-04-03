//
//  RootViewController.swift
//  RxThemeTutorial
//
//  Created by Alex Nagy on 03/04/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import UIKit
import RxTheme
import TinyConstraints

class RootViewController: UIViewController {
    
    lazy var barButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: #imageLiteral(resourceName: "NavigationBarButtonItemSettings").withRenderingMode(.alwaysTemplate), style: .done, target: self, action: nil)
        return item
    }()
    
    lazy var themeSwitch: UISwitch = {
        let themeSwitch = UISwitch()
        themeSwitch.tintColor = #colorLiteral(red: 0.9411764706, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        themeSwitch.onTintColor = #colorLiteral(red: 0.9411764706, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        themeSwitch.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        themeSwitch.thumbTintColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
        themeSwitch.layer.cornerRadius = 16
        themeSwitch.layer.masksToBounds = true
        themeSwitch.addTarget(self, action: #selector(didChangeThemeSwitchValue), for: .valueChanged)
        return themeSwitch
    }()
    
    @objc func didChangeThemeSwitchValue() {
        if themeSwitch.isOn {
            themeService.switch(.dark)
        } else {
            themeService.switch(.light)
        }
    }
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 2
        button.layer.masksToBounds = true
        button.setTitle("I'm a Button", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupTheme()
    }

    fileprivate func setupViews() {
        navigationItem.title = "Hello RxTheme"
        navigationItem.setRightBarButton(barButtonItem, animated: false)
        
        view.addSubview(themeSwitch)
        view.addSubview(button)
        
        themeSwitch.topToSuperview(offset: 12, usingSafeArea: true)
        themeSwitch.rightToSuperview(offset: -24, usingSafeArea: true)
        themeSwitch.height(31)
        themeSwitch.width(49)
        
        button.topToBottom(of: themeSwitch, offset: 12)
        button.leftToSuperview(offset: 12, usingSafeArea: true)
        button.rightToSuperview(offset: -12, usingSafeArea: true)
        button.height(50)
    }
    
    fileprivate func setupTheme() {
        view.theme.backgroundColor = themed { $0.backgroundColor }
        
        if let navigationController = navigationController {
            navigationController.navigationBar.theme.barTintColor = themed { $0.navigationBarBarTintColor }
            navigationController.navigationBar.theme.tintColor = themed { $0.navigationBarTintColor }
            navigationController.navigationBar.theme.titleTextAttributes = themed { $0.navigationBarTitleTextAttributes }
        }
        
        button.theme.backgroundColor = themed { $0.backgroundColor }
        button.theme.titleColor(from: themed { $0.buttonTitleColor }, for: .normal)
        button.theme.borderColor = themed { $0.buttonBorderColor }
    }

}

