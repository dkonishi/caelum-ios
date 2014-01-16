//
//  FormularioContatoViewControllerDelegate.h
//  ContatosIP76
//
//  Created by ios4212 on 15/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol FormularioContatoViewControllerDelegate <NSObject>

- (void) contatoAdicionado:(Contato *)contato;

@optional
- (void) contatoAlterado:(Contato *)contato;

@end
