//
//  ContatosNoMapaViewController.m
//  ContatosIP76
//
//  Created by ios4212 on 15/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import "Contato.h"
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    static NSString *pool = @"pinos";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pool];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pool];
    }
    else {
        pin.annotation = annotation;
    }
    
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.canShowCallout = YES;
    
    Contato *contato = (Contato *)annotation;
    
    if (contato.photo) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 32.0,32.0)];
        imageView.image = contato.photo;
        pin.leftCalloutAccessoryView = imageView;
    }
    
    return pin;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.map addAnnotations:self.contatos];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.map removeAnnotations:self.contatos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
