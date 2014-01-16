//
//  ContatosNoMapaViewController.h
//  ContatosIP76
//
//  Created by ios4212 on 15/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ContatosNoMapaViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, atomic) NSMutableArray *contatos;

@end
