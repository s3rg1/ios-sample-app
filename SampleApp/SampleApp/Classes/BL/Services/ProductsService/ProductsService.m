//
//  ProductsService.m
//  SampleApp
//
//  Created by Sergi Lalaguna on 9/4/16.
//  Copyright © 2016 Sergi Lalaguna. All rights reserved.
//

#import "ProductsService.h"
#import "ProductListVC.h"
#import "ProductEntity.h"

@interface ProductsService() <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, assign) id delegateService;
@end

@implementation ProductsService

+ (ProductsService *) instance{
    static ProductsService *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[ProductsService alloc] init];
        instance.sharedArrayProducts = [[NSMutableArray alloc] init];
    });
    
    return instance;
}

-(void) loadDataFromApi:(id)delegate{
    NSLog(@"loadDataFromApi");
    
    self.delegateService = delegate;
    
    
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/fvessaz/SimpleCatalogBackend/master/catalog.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          // do something with the data
                                          if(error){
                                              NSLog(@"Error retrieving the product list: %@", error);
                                              
                                              ProductEntity *product = [[ProductEntity alloc] init];
                                              product.name = @"test1";
                                              product.title = @"title";
                                              product.desc = @"Description";
                                              [self.sharedArrayProducts addObject:product];
                                              //Delegate response
                                              [self.delegateService receiveDataFromApi];
                                          }
                                          else{
                                              //Parser data
                                              NSMutableArray *arrayJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              [self parseArrayProducts:arrayJson];
                                          
                                              NSLog(@"Data got!! %@", self.sharedArrayProducts);
                                          
                                              //Delegate response
                                              [self.delegateService receiveDataFromApi];
                                          }
                                      }];
    [dataTask resume];
}

- (void) parseArrayProducts: (NSMutableArray *) array{
    for (NSDictionary *dic in array){
        NSArray *arrayProducts = [dic objectForKey:@"capsules"];
        for(NSDictionary *dicProduct in arrayProducts){
            ProductEntity *product = [[ProductEntity alloc] init];
            product.name = [dicProduct objectForKey:@"name"];
            product.price = [dicProduct objectForKey:@"price"];
            product.title = [dicProduct objectForKey:@"taste"];
            product.desc = [dicProduct objectForKey:@"description"];
            product.picture = [dicProduct objectForKey:@"img"];
            [self.sharedArrayProducts addObject:product];
        }
    }
}

@end
