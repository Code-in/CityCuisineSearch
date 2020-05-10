//
//  PJPRestaurant.m
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/9/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import "PJPRestaurant.h"

@implementation PJPRestaurant

-(instancetype)initWithRestaurantData:(NSString *)name cuisines:(NSString *) cuisines priceRange:(NSNumber *) priceRange phoneNumbers:(NSString *) phoneNumbers {
    
    if (self = [super init]) {
        _name = name;
        _cuisines = cuisines;
        _priceRange = priceRange;
        _phoneNumbers = phoneNumbers;
    }
    return self;
}
@end


@implementation PJPRestaurant (JSONConvertable)
-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)restaurantData {
    NSString *name = restaurantData[@"name"];
    NSNumber *priceRange = restaurantData[@"price_range"];
    NSString *cuisines = restaurantData[@"cuisines"];
    NSString *phoneNumbers = restaurantData[@"phone_number"];
    return [self initWithRestaurantData:name cuisines:cuisines priceRange: priceRange phoneNumbers: phoneNumbers];
}
@end
