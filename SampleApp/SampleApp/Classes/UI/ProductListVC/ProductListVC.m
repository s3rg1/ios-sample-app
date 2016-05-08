//
//  ProductListVC.m
//  SampleApp
//
//  Created by Sergi Lalaguna on 9/4/16.
//  Copyright © 2016 Sergi Lalaguna. All rights reserved.
//

#import "ProductListVC.h"
#import "ProductsService.h"
#import "ProductEntity.h"
#import "ProductDetailVC.h"

@interface ProductListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableViewProducts;
@property (nonatomic, strong) NSMutableArray *arrProducts;
@end

@implementation ProductListVC

- (id) init{
    self = [super init];
    self.title = @"Products";
    self.tabBarItem.image = [UIImage imageNamed:@"list"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"View did load!");

    [self.tableViewProducts setDataSource:self];
    [self.tableViewProducts setDelegate:self];

    [[ProductsService instance] loadDataFromApi:self];
}

-(void) receiveDataFromApi{
    NSLog(@"receiveDataFromApi");
    
    self.arrProducts = [ProductsService instance].sharedArrayProducts;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.tableViewProducts reloadData];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRows %li in section %li", [self.arrProducts count], section);
    return [self.arrProducts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexpath section %li, indexpath row %li", indexPath.section, indexPath.row);
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    ProductEntity *product = [self.arrProducts objectAtIndex:indexPath.row];
    [cell.textLabel setText:product.name];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductEntity *product = [self.arrProducts objectAtIndex:indexPath.row];
    NSLog(@"indexpath section %li, indexpath row %li, product name %@", indexPath.section, indexPath.row, product.name);
    
    ProductDetailVC *productDetail = [[ProductDetailVC alloc] initWithProduct:product];
    [self.navigationController pushViewController:productDetail animated:YES];
}

@end
