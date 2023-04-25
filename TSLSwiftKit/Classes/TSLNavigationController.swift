//
//  TSLNavigationController.swift
//  TSLSwiftKit
//
//  Created by TSL on 2023/4/25.
//  隐藏导航栏,但是返回及侧滑事件保留

import UIKit

class TSLNavigationController: UINavigationController {

    var isSwitching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        self.isNavigationBarHidden = false
        
        self.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        if animated {
            if self.isSwitching {
                return
            }
            
            self.isSwitching = true
        }
        
        super.pushViewController(viewController, animated: animated)
        
        self.isSwitching = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TSLNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let isRootViewController = viewController == navigationController.viewControllers.first
        
        self.interactivePopGestureRecognizer?.isEnabled = !isRootViewController

        self.isSwitching = false
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        self.isSwitching = false
        return super.popViewController(animated: animated)
    }
    
}
