//
//  PJPCityRestaurantsFetch.h
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/9/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJPRestaurant.h"
#import "PJPCuisine.h"

NS_ASSUME_NONNULL_BEGIN

@interface PJPCityRestaurantsFetch : NSObject

+ (void) fetchCityRestaurants:(PJPCuisine *) cuisine completion:(void(^) (NSArray<PJPRestaurant *> *restaurants, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
