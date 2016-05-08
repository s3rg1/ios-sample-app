//
//  ProductEntity.h
//  SampleApp
//
//  Created by Sergi Lalaguna on 9/4/16.
//  Copyright © 2016 Sergi Lalaguna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductEntity : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *picture;

@end
