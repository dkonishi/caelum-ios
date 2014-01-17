//
//  EDENViewController.m
//  WebServices
//
//  Created by ios4212 on 17/01/14.
//  Copyright (c) 2014 Baby. All rights reserved.
//

#import "EDENViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface EDENViewController ()

@end

@implementation EDENViewController

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
	
    // Do any additional setup after loading the view.
    [self carregaDados];
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.emprestimos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pool = @"contatos";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pool];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: pool];
    }
    
    NSDictionary *emprestimo = self.emprestimos[indexPath.row];
    
    [self configuraCelula:cell comEmprestimo:emprestimo];
    return cell;
}

-(void)configuraCelula:(UITableViewCell *)cell comEmprestimo:(NSDictionary *)emprestimo
{
    NSString *nome         = emprestimo[@"name"];
    NSDictionary *location = emprestimo[@"location"];
    NSString *pais         = location[@"country"];
    NSNumber *valor        = emprestimo[@"loan_amount"];
    NSString *proposito = emprestimo[@"use"];
    
    cell.textLabel.text       = [NSString stringWithFormat:@"%@ - %@", nome, pais];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"USD %@ - %@", valor, proposito];
}

- (void)carregaDados
{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"  parameters:nil];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [operation
        setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *response = (NSDictionary *)responseObject;

            self.emprestimos = response[@"loans"];
            
            [self.tableView reloadData];
            
            NSLog(@"%@", self.emprestimos);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ERROR!: %@", error);
        }];
    
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
