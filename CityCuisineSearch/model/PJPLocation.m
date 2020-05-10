//
//  PJPLocation.m
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/7/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import "PJPLocation.h"

@implementation PJPLocation

-(instancetype)initWithLocationData:(NSNumber *) cityID cityName:(NSString *) cityName countryFlagUrl:(NSString *) countryFlagUrl countryName:(NSString *) countryName stateName:(NSString *) stateName {
    if (self = [super init]) {
        _cityID = cityID;
        _cityName = cityName;
        _countryFlagUrl = countryFlagUrl;
        _countryName = countryName;
        _stateName = stateName;
    }
    return self;
}
@end

@implementation PJPLocation (JSONConvertable)
-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)locationData {
    NSNumber *cityID = locationData[@"id"];
    NSString *cityName = locationData[@"name"];
    NSString *countryFlagUrl = locationData[@"country_flag_url"];
    NSString *countryName = locationData[@"country_name"];
    NSString *stateName = locationData[@"state_name"];
    return [self initWithLocationData:cityID cityName:cityName countryFlagUrl:countryFlagUrl countryName:countryName stateName:stateName];
}
@end




