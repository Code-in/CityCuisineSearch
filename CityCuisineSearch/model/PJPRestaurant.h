//
//  PJPRestaurant.h
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/9/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PJPRestaurant : NSObject

@property (nonatomic, copy, readonly) NSString * name;
@property (nonatomic, copy, readonly) NSString * cuisines;
@property (nonatomic, copy, readonly) NSNumber * priceRange;
@property (nonatomic, copy, readonly) NSString * phoneNumbers;

-(instancetype)initWithRestaurantData:(NSString *)name cuisines:(NSString *) cuisines priceRange:(NSNumber *) priceRange phoneNumbers:(NSString *) phoneNumbers;

@end

@interface PJPRestaurant (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)restaurantData;

@end

NS_ASSUME_NONNULL_END
