//
//  OnboardingViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/10/18.
//

import UIKit
import paper_onboarding

/// Implements the Onboarding
class OnboardingViewController: UIViewController {
    @IBOutlet weak var onboarding: PaperOnboarding!
    @IBOutlet weak var getStarted: UIButton!
    
    /// Function that sets the delegate and source for onboarding.
    override func viewDidLoad() {
        super.viewDidLoad()
        onboarding.dataSource = self
        onboarding.delegate = self
        // Do any additional setup after loading the view.
    }
}

/// Onboarding set up here.Configures the whole onboaring here.
extension OnboardingViewController:PaperOnboardingDataSource, PaperOnboardingDelegate {
    /// sets the number of screens
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    /// Configures the onboarding screens
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        let items = [
            OnboardingItemInfo(informationImage: UIImage.init(imageLiteralResourceName: "barchart2"),
                               title: "No crazy analysis!",
                               description: "We measure a company by 5 factors, on a 1-5 scale.",
                               pageIcon: UIImage.init(),
                               color: UIColor.init(netHex: 0x4ABC96),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            OnboardingItemInfo(informationImage: UIImage.init(imageLiteralResourceName: "compare1"),
                               title: "Details when it matters",
                               description: "Powerful charts and a comparison tool to go deep when you need it.",
                               pageIcon: UIImage.init(),
                               color: UIColor.init(netHex: 0x357180),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
            
            
            OnboardingItemInfo(informationImage: UIImage.init(imageLiteralResourceName: "launch"),
                               title: "Let's Go!",
                               description: "Sign up now and make your own portfolio in minutes!",
                               pageIcon: UIImage.init(),
                               color: UIColor.init(netHex: 0xF2AB5A),
                               titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
            ]
        
        return items[index]
    }
    
    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
    
    /// sets the alpha of button to 0 if the final screen is not reached yet.
    func onboardingWillTransitonToIndex(_ index: Int) {
        if (index == 1)
        {
            if (self.getStarted.alpha == 1) {
                UIView.animate(withDuration: 0.2) {
                    self.getStarted.alpha = 0
                }
            }
        }
    }
    
    /// sets the alpha of the get started button back to 1 when the user reaches final screen.
    func onboardingDidTransitonToIndex(_ index: Int) {
        if (index == 2)
        {
            UIView.animate(withDuration: 0.4) {
                self.getStarted.alpha = 1
            }
        }
    }
}
