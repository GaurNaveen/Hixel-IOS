//
//  OnboardingViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
import paper_onboarding
class OnboardingViewController: UIViewController {
    @IBOutlet weak var onboarding: onboardingClass!
    @IBOutlet weak var getStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding.dataSource = self
        onboarding.delegate = self
        // Do any additional setup after loading the view.
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

extension OnboardingViewController:PaperOnboardingDataSource,PaperOnboardingDelegate {
    func onboardingItemsCount() -> Int {
       return  3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundThree = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
         let items = [
            OnboardingItemInfo(informationImage: UIImage.init(imageLiteralResourceName: "barchart2"),
                               title: "No Crazy Analayis!",
                               description: "We use easy to understand charts,and assign company a score out of 100.",
                               pageIcon:UIImage.init(),
                               color:UIColor.init(netHex: 0x4ABC96),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            OnboardingItemInfo(informationImage: UIImage.init(imageLiteralResourceName: "compare1"),
                               title: "Companies you care about",
                               description: "Add and remove companies as you like,and compare them to see whose best.",
                               pageIcon:UIImage.init(),
                               color:UIColor.init(netHex: 0x357180),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            
            OnboardingItemInfo(informationImage: UIImage.init(imageLiteralResourceName: "launch"),
                               title: "Let's Go!",
                               description: "Sign Up now and make your own portfolio in mintues!",
                               pageIcon:UIImage.init(),
                               color:UIColor.init(netHex: 0xF2AB5A),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            
            
            
            ]
        
        return items[index]
        
    }
    
    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1
        {
            if self.getStarted.alpha == 1 {
                UIView.animate(withDuration: 0.2) {
                    self.getStarted.alpha = 0
                }
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index==2{
            UIView.animate(withDuration: 0.4) {
                self.getStarted.alpha = 1
            }
        }
    }
    
}
