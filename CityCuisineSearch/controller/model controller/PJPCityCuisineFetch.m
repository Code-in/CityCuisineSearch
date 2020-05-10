//
//  PJPCityCuisineFetch.m
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/8/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import "PJPCityCuisineFetch.h"

//https://developers.zomato.com/api/v2.1/cuisines?city_id=286
static NSString *const baseURLString = @"https://developers.zomato.com/api/";
static NSString *const versionComponent = @"v2.1";
static NSString *const cuisineComponent = @"cuisines";
static NSString *const queryItemKey = @"city_id";
// Header key:
static NSString *const apiHeaderKey = @"user-key";
static NSString *const apiHeaderValue = @"4afd26ba31ea96394a3b59c74a09550c";
static NSString *const acceptHeaderKey = @"accept";
static NSString *const acceptJsonHeaderValue = @"application/json";

static NSString * const kLocationSerializerID = @"location_suggestions";
static NSString * const kRequestGetOperation = @"GET";

@implementation PJPCityCuisineFetch

/* -----------------------------------------------------------------------------*/
// MARK: fetchCityCuisine
/* -----------------------------------------------------------------------------*/
+ (void) fetchCityCuisine: (PJPLocation *) location completion:(void(^) (NSArray<PJPCuisine *> *cuisines, NSError *error))completion {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent: versionComponent]; //v.2.1
    baseURL = [baseURL URLByAppendingPathComponent: cuisineComponent]; //cuisines
    NSURLQueryItem *queryItem1 = [[NSURLQueryItem alloc] initWithName:queryItemKey value: [location.cityID stringValue]];  //city_id=286  aka Portland
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    components.queryItems = [NSArray arrayWithObjects: queryItem1, nil];
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
        
        NSArray *cuisinesArray = jsonDictionary[cuisineComponent];
        // Place holder array for return the data
        NSMutableArray *outLocationArray = [NSMutableArray array];
        
        for(NSMutableDictionary *cuisineDict in cuisinesArray){
            // append cityID and cityName

            PJPCuisine *cityCuisine = [[PJPCuisine alloc] initWithCuisineData:location.cityID cityName:location.cityName cuisineID:cuisineDict[@"cuisine"][@"cuisine_id"] cuisineName:cuisineDict[@"cuisine"][@"cuisine_name"]];
            [outLocationArray addObject:cityCuisine];
        }
        completion(outLocationArray, nil);
    }] resume];
    
}


@end
