//
//  Contato.m
//  ContatosIP76
//
//  Created by ios4212 on 13/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Contato.h"

@implementation Contato

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self){
        self.name     = [aDecoder decodeObjectForKey:@"name"];
        self.phone    = [aDecoder decodeObjectForKey:@"phone"];
        self.email    = [aDecoder decodeObjectForKey:@"email"];
        self.address  = [aDecoder decodeObjectForKey:@"address"];
        self.site     = [aDecoder decodeObjectForKey:@"site"];
        self.photo    = [aDecoder decodeObjectForKey:@"photo"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name      forKey:@"name"];
    [aCoder encodeObject:self.phone     forKey:@"phone"];
    [aCoder encodeObject:self.email     forKey:@"email"];
    [aCoder encodeObject:self.address   forKey:@"address"];
    [aCoder encodeObject:self.site      forKey:@"site"];
    [aCoder encodeObject:self.photo     forKey:@"photo"];
    [aCoder encodeObject:self.photo     forKey:@"photo"];
    [aCoder encodeObject:self.latitude  forKey:@"latitude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"%@, %@", self.name, self.email];
}

- (CLLocationCoordinate2D) coordinate
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return self.email;
}

@end
