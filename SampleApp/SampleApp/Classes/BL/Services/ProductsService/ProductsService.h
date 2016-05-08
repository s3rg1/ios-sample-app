//
//  ProductsService.h
//  SampleApp
//
//  Created by Sergi Lalaguna on 9/4/16.
//  Copyright © 2016 Sergi Lalaguna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductsService : NSObject

+ (ProductsService *) instance;

@property (nonatomic, strong) NSMutableArray *sharedArrayProducts;

-(void) loadDataFromApi:(id)delegate;

@end
