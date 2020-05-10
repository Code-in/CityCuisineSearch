//
//  PJPCuisine.h
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/9/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PJPCuisine : NSObject

@property (nonatomic, copy, readonly) NSNumber * cityID;
@property (nonatomic, copy, readonly) NSString * cityName;
@property (nonatomic, copy, readonly) NSNumber * cuisineID;
@property (nonatomic, copy, readonly) NSString * cuisineName;



-(instancetype)initWithCuisineData:(NSNumber *)cityID cityName:(NSString *) cityName cuisineID:(NSNumber *) cuisineID cuisineName:(NSString *) cuisineName;

@end

@interface PJPCuisine (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)locationData;

@end

NS_ASSUME_NONNULL_END
