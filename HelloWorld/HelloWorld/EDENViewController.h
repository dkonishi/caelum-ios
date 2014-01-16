//
//  EDENViewController.h
//  HelloWorld
//
//  Created by ios4212 on 13/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDENViewController : UIViewController


@property (weak)IBOutlet UILabel *label;
@property (weak)IBOutlet UITextField *textField;

- (IBAction)displayMessage:(id)sender;

@end
