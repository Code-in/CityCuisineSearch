//
//  PJPCityFetchController.m
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/7/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import "PJPCityFetchController.h"


static NSString *const baseURLString = @"https://developers.zomato.com/api/";
static NSString *const versionComponent = @"v2.1";
static NSString *const citiesComponent = @"cities";
static NSString *const queryItemKey = @"q";

// Header key:
static NSString *const apiHeaderKey = @"user-key";
static NSString *const apiHeaderValue = @"4afd26ba31ea96394a3b59c74a09550c";
static NSString *const acceptHeaderKey = @"accept";
static NSString *const acceptHeaderValue = @"application/json";


@implementation PJPCityFetchController

+ (void) fetchSupportedCitiesInState: (NSString *) city completion:(void(^) (NSArray<PJPLocation *> *locations, NSError *error))completion {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent: versionComponent];
    baseURL = [baseURL URLByAppendingPathComponent: citiesComponent];
    NSURLQueryItem *queryItem1 = [[NSURLQueryItem alloc] initWithName:queryItemKey value:city.lowercaseString];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    components.queryItems = [NSArray arrayWithObjects: queryItem1, nil];
    NSURL *workingURL = [components URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:workingURL];
    [request setHTTPMethod:@"POST"];
    [request addValue:apiHeaderValue forHTTPHeaderField:apiHeaderKey];
    [request addValue:acceptHeaderValue forHTTPHeaderField:acceptHeaderKey];
    
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // error handling
        if(error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        if(!data){
            NSLog(@"Error no data returned from task");
            completion(nil, error);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if(!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSONDictionary is not dictionary class");
            completion(nil, error);
            return;
        }
        
        NSArray *locationsArray = jsonDictionary[@"location_suggestions"];
        // Place holder array for return the data
        NSMutableArray *outLocationArray = [NSMutableArray array];
        
        for(NSDictionary *location in locationsArray){
            PJPLocation *city_location = [[PJPLocation alloc] initWithDictionary: location];
            [outLocationArray addObject:city_location];
        }
        completion(outLocationArray, nil);
    }] resume];
    
}


+ (void) fetchCountryImage: (NSString *) location completion:(void(^) (UIImage * image, NSError *error))completion {
    
    NSURL *baseURL = [NSURL URLWithString: location];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    [request setHTTPMethod:@"POST"];
    [request addValue:apiHeaderValue forHTTPHeaderField:apiHeaderKey];
    [request addValue:acceptHeaderValue forHTTPHeaderField:acceptHeaderKey];
    
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // error handling
        if(error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        
        if(!data){
            NSLog(@"Error no data returned from task");
            completion(nil, error);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image, nil);
    }] resume];
    
}



@end
