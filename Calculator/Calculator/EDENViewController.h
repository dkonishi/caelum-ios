//
//  EDENViewController.h
//  Calculator
//
//  Created by ios4212 on 13/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDENViewController : UIViewController

@property (weak) IBOutlet UITextField *textA;
@property (weak) IBOutlet UITextField *textB;
@property (weak) IBOutlet UILabel *result;

- (IBAction)soma:(id)sender;
- (IBAction)sliderChanged:(UISlider *)slider;

@end
