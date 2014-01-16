//
//  ListContactViewController.m
//  ContatosIP76
//
//  Created by ios4212 on 14/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import "ListContactViewController.h"
#import "FormularioContatoViewController.h"
#import "Contato.h"

@implementation ListContactViewController

- (id)init
{
    self = [super init];

    if (self){
        
        UIImage *img = [UIImage imageNamed:@"lista-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Contatos" image:img tag:0];
        
        self.tabBarItem = tabItem;
        
        self.navigationItem.title = @"Contatos";
        
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd            target:self action: @selector(showForm)];
        
        self.navigationItem.rightBarButtonItem = btn;
        self.navigationItem.leftBarButtonItem  = self.editButtonItem;

        self.linhaSelecionada = -1;
    }
    
    return self;
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.contatos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Contato *contato = self.contatos[sourceIndexPath.row];
    [self.contatos removeObjectAtIndex:sourceIndexPath.row];
    [self.contatos insertObject:contato atIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contato *contato = self.contatos[indexPath.row];
    
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] initWithContato: contato];
    
    form.delegate = self;
    
    [self.navigationController pushViewController:form animated:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.linhaSelecionada != -1){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.linhaSelecionada inSection:0];

        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        self.linhaSelecionada = -1;
    }
}

- (void) viewDidLoad
{
    UILongPressGestureRecognizer *lpr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:lpr];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contatos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pool = @"contatos";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pool];

    if(!cell){
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: pool];
    }
    
    Contato *contato = self.contatos[indexPath.item];
    
    cell.textLabel.text       = contato.name;
    cell.detailTextLabel.text = contato.email;
    [cell.imageView setImage:contato.photo];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)showForm
{
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] init];
    
    form.delegate = self;
    
    [self.navigationController pushViewController:form animated:YES];
}

- (void) contatoAdicionado:(id)contato
{
    [self.contatos addObject:contato];
    
    self.linhaSelecionada = [self.contatos indexOfObject:contato];
    
    NSLog(@"Contatos %@", self.contatos);
}

- (void) contatoAlterado:(Contato *)contato
{
    self.linhaSelecionada = [self.contatos indexOfObject:contato];
    
    NSLog(@"Contato alterado %@", contato);
}

- (void)exibeMaisAcoes:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan){
        CGPoint ponto          = [gesture locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:ponto];
    
        contatoSelecionado = self.contatos[indexPath.row];

        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:contatoSelecionado.name delegate:self cancelButtonTitle:@"cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar email", @"Visualizar site", @"Mostrar mapa", nil];

        [as showFromTabBar:self.tabBarController.tabBar];
        
        NSLog(@"Contato %@", contatoSelecionado);
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: //Phone
            [self ligar];
            break;
        case 1: //Email
            [self enviarEmail];
            break;
        case 2: //Site
            [self abreSite];
            break;
        case 3: //Mapa
            [self abreMapa];
            break;
        default:
            break;
    }
}

- (void)ligar
{
    UIDevice *device = [UIDevice currentDevice];
    
    if([device.model isEqualToString:@"iPhone"]){
        NSString *url = [NSString stringWithFormat:@"tel:%@", contatoSelecionado.phone];
        [self abrirAplicativoComUrl:url];
    }
    else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Pobre!" message:@"Compre um iPhone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
    }
}

-(void)enviarEmail
{
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        
        [mail setToRecipients:@[contatoSelecionado.email]];
        [mail setSubject:@"Contatos IP-67"];
        mail.mailComposeDelegate = self;
        [self presentViewController:mail animated:YES completion:nil];
    }
    else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Hei!" message:@"Configure seu email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
    }
}

- (void)abreSite
{
    [self abrirAplicativoComUrl:contatoSelecionado.site];
}

- (void)abreMapa
{
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self abrirAplicativoComUrl:url];
}

- (void)abrirAplicativoComUrl:(NSString *)url
{
    NSLog(@"Abrindo: %@", url);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
