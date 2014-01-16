//
//  EDENViewController.m
//  Calculator
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

- (IBAction)soma:(id)sender
{
    CGFloat valueA = [self.textA.text floatValue];
    CGFloat valueB = [self.textB.text floatValue];
    self.result.text = [NSString stringWithFormat:@"%.2f",  valueA + valueB];
}

- (IBAction)sliderChanged:(UISlider *)slider
{
    NSString *valor = [ NSString stringWithFormat:@"%f", slider.value];

    if (slider.tag == 1){
        self.textA.text = valor;
    }
    else{
        self.textB.text = valor;
    }
}

@end
