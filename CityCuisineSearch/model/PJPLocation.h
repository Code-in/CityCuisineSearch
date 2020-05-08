//
//  PJPLocation.h
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/7/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PJPLocation : NSObject

@property (nonatomic, readonly) NSInteger cityID;
@property (nonatomic, copy, readonly) NSString * cityName;
@property (nonatomic, copy, readonly) NSString * countryFlagUrl;
@property (nonatomic, copy, readonly) NSString * countryName;
@property (nonatomic, copy, readonly) NSString * stateName;

-(instancetype)initWithLocationData:(NSInteger)cityID cityName:(NSString *) cityName countryFlagUrl:(NSString *) countryFlagUrl countryName:(NSString *) countryName stateName:(NSString *) stateName;

@end

@interface PJPLocation (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)locationData;

@end
NS_ASSUME_NONNULL_END
