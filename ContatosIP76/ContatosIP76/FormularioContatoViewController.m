//
//  FormularioContatoViewController.m
//  ContatosIP76
//
//  Created by ios4212 on 13/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "FormularioContatoViewController.h"
#import "Contato.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (id)init
{
    self = [super init];
    
    if (self){
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        
        self.navigationItem.rightBarButtonItem = btn;
    }
    
    return self;
}

- (id)initWithContato:(Contato *)contato
{
    self = [super init];
    
    if(self){
        self.contato = contato;
        self.navigationItem.title = @"Alterando..";
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Alterar" style:UIBarButtonItemStylePlain target:self action:@selector(alterarContato)];
        
        self.navigationItem.rightBarButtonItem = btn;
        
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
    
    if(self.contato){
        self.txtName.text    = self.contato.name;
        self.txtEmail.text   = self.contato.email;
        self.txtPhone.text   = self.contato.phone;
        self.txtAddress.text = self.contato.address;
        self.txtSite.text    = self.contato.site;
        self.txtLat.text     = [self.contato.latitude stringValue];
        self.txtLong.text    = [self.contato.longitude stringValue];
        [self.foto setImage:self.contato.photo forState:UIControlStateNormal];
    }
}


- (IBAction)selecionaFoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //TODO:
    }
    else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (IBAction)buscaCoordenada:(id)sender
{
    [self.rodinha startAnimating];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:self.txtAddress.text completionHandler:^(NSArray *resultados, NSError *error){
        [self.rodinha stopAnimating];
        
        if(!error && [resultados count] > 0){
            CLPlacemark *resultado = resultados[0];
            CLLocationCoordinate2D coordinate = resultado.location.coordinate;

            NSLog(@"%f %f", coordinate.latitude, coordinate.longitude);

            self.txtLat.text  = [NSString stringWithFormat:@"%f", coordinate.latitude];
            self.txtLong.text = [NSString stringWithFormat:@"%f", coordinate.longitude];
        }
    }];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.foto setImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)criaContato
{
    Contato *contato = [self pegaDadosDoFormulario];

    [self.delegate contatoAdicionado:contato];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alterarContato
{
    [self preencheContato:self.contato];
    
    if([self.delegate respondsToSelector:@selector(contatoAlterado:)]){
        [self.delegate contatoAlterado:self.contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (Contato *)pegaDadosDoFormulario
{
    Contato *contato = [[Contato alloc] init];
    
    [self preencheContato:contato];
    
    return contato;
}

- (void)preencheContato:(Contato *)contato
{
    contato.name      = self.txtName.text;
    contato.email     = self.txtEmail.text;
    contato.phone     = self.txtPhone.text;
    contato.address   = self.txtAddress.text;
    contato.site      = self.txtSite.text;
    contato.photo     = self.foto.imageView.image;
    contato.latitude  = [NSNumber numberWithDouble:[self.txtLat.text doubleValue]];
    contato.longitude = [NSNumber numberWithDouble:[self.txtLong.text doubleValue]];
}

@end
