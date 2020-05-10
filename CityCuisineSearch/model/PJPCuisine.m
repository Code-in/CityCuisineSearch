//
//  PJPCuisine.m
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/9/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import "PJPCuisine.h"

@implementation PJPCuisine

-(instancetype) initWithCuisineData:(NSNumber *)cityID cityName:(NSString *)cityName cuisineID:(NSNumber *)cuisineID cuisineName:(NSString *)cuisineName {
    
    if (self = [super init]) {
        _cityID = cityID;
        _cityName = cityName;
        _cuisineID = cuisineID;
        _cuisineName = cuisineName;
    }
    return self;
}
@end

@implementation PJPCuisine (JSONConvertable)
-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)cuisineData {
    NSNumber *cityID = cuisineData[@"cityID"];
    NSString *cityName = cuisineData[@"cityName"];
    NSNumber *cuisineID = cuisineData[@"cuisineID"];
    NSString *cuisineName = cuisineData[@"cuisineName"];
    return [self initWithCuisineData:cityID cityName:cityName cuisineID:cuisineID cuisineName:cuisineName];
}
@end
