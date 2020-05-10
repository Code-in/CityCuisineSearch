//
//  PJPCityRestaurantsFetch.m
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/9/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import "PJPCityRestaurantsFetch.h"




//https://developers.zomato.com/api/v2.1/cuisines?city_id=286
//https://developers.zomato.com/api/v2.1/search?entity_id=286&entity_type=city&cuisines=149
static NSString *const baseURLString = @"https://developers.zomato.com/api/";
static NSString *const versionComponent = @"v2.1";
static NSString *const searchComponent = @"search";

// Query
static NSString *const query1ItemKey = @"entity_id";
static NSString *const query2ItemKey = @"entity_type";
static NSString *const query2temValue = @"city";
static NSString *const query3ItemKey = @"cuisines";
// Header key:
static NSString *const apiHeaderKey = @"user-key";
static NSString *const apiHeaderValue = @"4afd26ba31ea96394a3b59c74a09550c";
static NSString *const acceptHeaderKey = @"accept";
static NSString *const acceptJsonHeaderValue = @"application/json";
static NSString * const kLocationSerializerID = @"location_suggestions";
static NSString * const kRequestGetOperation = @"GET";


@implementation PJPCityRestaurantsFetch


/* -----------------------------------------------------------------------------*/
// MARK: fetchCityCuisine
/* -----------------------------------------------------------------------------*/
+ (void) fetchCityRestaurants:(PJPCuisine *) cuisine completion:(void(^) (NSArray<PJPRestaurant *> *restaurants, NSError *error))completion {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent: versionComponent]; //v.2.1
    baseURL = [baseURL URLByAppendingPathComponent: searchComponent]; //cuisines
    NSURLQueryItem *queryItem1 = [[NSURLQueryItem alloc] initWithName:query1ItemKey value: [cuisine.cityID stringValue]];
    NSURLQueryItem *queryItem2 = [[NSURLQueryItem alloc] initWithName:query2ItemKey value: query2temValue];
    NSURLQueryItem *queryItem3 = [[NSURLQueryItem alloc] initWithName:query3ItemKey value: [cuisine.cuisineID stringValue]];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    components.queryItems = [NSArray arrayWithObjects: queryItem1, queryItem2, queryItem3, nil];
    NSURL *workingURL = [components URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:workingURL];
    [request setHTTPMethod:kRequestGetOperation];
    [request addValue:apiHeaderValue forHTTPHeaderField:apiHeaderKey];
    [request addValue:acceptJsonHeaderValue forHTTPHeaderField:acceptHeaderKey];
    
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // error handling
        if(error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        
        if(!data){
            NSLog(@"Error no data returned from task!!!");
            completion(nil, error);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if(!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSONDictionary is not dictionary class!!!");
            completion(nil, error);
            return;
        }
        
        
        NSArray *restaurantsArray = jsonDictionary[@"restaurants"];
        // Place holder array for return the data
        NSMutableArray *outLocationArray = [NSMutableArray array];
        
        
        
        
        for(NSMutableDictionary *restaurant in restaurantsArray){
            // append cityID and cityName
            NSLog(@"%@",restaurant[@"restaurant"]);
            NSLog(@"%@",restaurant[@"restaurant"][@"name"]);
            PJPRestaurant *rest = [[PJPRestaurant alloc] initWithRestaurantData:restaurant[@"restaurant"][@"name"] cuisines:restaurant[@"restaurant"][@"cuisines"] priceRange:restaurant[@"restaurant"][@"price_range"] phoneNumbers:restaurant[@"restaurant"][@"phone_numbers"]];
            [outLocationArray addObject:rest];
        }
        completion(outLocationArray, nil);
        
    }] resume];
    
}

@end
