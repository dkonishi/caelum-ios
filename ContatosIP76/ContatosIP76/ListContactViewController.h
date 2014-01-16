//
//  ListContactViewController.h
//  ContatosIP76
//
//  Created by ios4212 on 14/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "FormularioContatoViewControllerDelegate.h"

@interface ListContactViewController : UITableViewController <FormularioContatoViewControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

{
    Contato *contatoSelecionado;
}

@property (weak, atomic) NSMutableArray *contatos;
@property (assign, atomic) NSInteger linhaSelecionada;

@end
