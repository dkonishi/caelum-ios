//
//  Contato.h
//  ContatosIP76
//
//  Created by ios4212 on 13/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Contato : NSManagedObject <NSCoding, MKAnnotation>
{
    
}

@property (strong, atomic) NSString *name;
@property (strong, atomic) NSString *phone;
@property (strong, atomic) NSString *email;
@property (strong, atomic) NSString *address;
@property (strong, atomic) NSString *site;
@property (strong, atomic) UIImage  *photo;
@property (strong, atomic) NSNumber *latitude;
@property (strong, atomic) NSNumber *longitude;
@end
