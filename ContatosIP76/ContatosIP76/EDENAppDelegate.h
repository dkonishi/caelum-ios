//
//  EDENAppDelegate.h
//  ContatosIP76
//
//  Created by ios4212 on 13/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDENAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, atomic) NSMutableArray *contatos;

@property (strong, atomic) NSString *nomeArquivo;


@end
