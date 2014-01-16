//
//  ContatosNoMapaViewController.m
//  ContatosIP76
//
//  Created by ios4212 on 15/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import <MapKit/MapKit.h>

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

- (id)init
{
    self = [super init];
    
    if (self)
    {
        UIImage *img = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:img tag:0];
        
        self.tabBarItem = tabItem;
   
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MKUserTrackingBarButtonItem *btn = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.map];
    
    self.navigationItem.leftBarButtonItem = btn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
