//
//  FormularioContatoViewController.h
//  ContatosIP76
//
//  Created by ios4212 on 13/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "FormularioContatoViewControllerDelegate.h"

@interface FormularioContatoViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtSite;
@property (weak, nonatomic) IBOutlet UIButton *foto;
@property (weak, nonatomic) IBOutlet UITextField *txtLat;
@property (weak, nonatomic) IBOutlet UITextField *txtLong;

@property (weak, nonatomic) NSMutableArray *contatos;
@property (strong,  atomic) Contato *contato;

@property (weak, atomic) id<FormularioContatoViewControllerDelegate> delegate;

- (IBAction)selecionaFoto:(id)sender;

- (id)initWithContato:(Contato *)contato;

@end
