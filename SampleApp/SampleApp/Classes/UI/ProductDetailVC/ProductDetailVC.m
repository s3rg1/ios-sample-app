//
//  ProductDetailVC.m
//  SampleApp
//
//  Created by Sergi Lalaguna on 9/4/16.
//  Copyright © 2016 Sergi Lalaguna. All rights reserved.
//

#import "ProductDetailVC.h"
#import "ProductEntity.h"

@interface ProductDetailVC ()
@property (nonatomic, strong) ProductEntity *myProduct;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@end

@implementation ProductDetailVC

- (id) initWithProduct: (ProductEntity *) product{
    self = [super init];
    if(self){
        self.myProduct = product;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.myProduct.name;
    self.labelTitle.text = self.myProduct.title;
    self.myTextView.text = self.myProduct.desc;
    
    if(self.myProduct.picture){
        NSLog(@"Displaying image at url: %@", self.myProduct.picture);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.myProduct.picture]];
            
            //set your image on main thread.
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myImageView setImage:[UIImage imageWithData:data]];
            });    
        });
    }
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

@end
