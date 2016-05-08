//
//  ProductDetailVC.h
//  SampleApp
//
//  Created by Sergi Lalaguna on 9/4/16.
//  Copyright © 2016 Sergi Lalaguna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductEntity.h"

@interface ProductDetailVC : UIViewController
- (id) initWithProduct: (ProductEntity *) product;
@end
