//
//  EDENViewController.m
//  HelloWorld
//
//  Created by ios4212 on 13/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import "EDENViewController.h"

@interface EDENViewController ()

@end

@implementation EDENViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayMessage:(id)sender
{
    //[[self label] setText:[[self textField] text]];

    NSString *textoDigitado = self.textField.text;
    self.label.text = textoDigitado;

    self.textField.text = @"";
}

@end
