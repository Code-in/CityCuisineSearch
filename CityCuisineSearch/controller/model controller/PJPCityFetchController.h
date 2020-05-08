//
//  PJPCityFetchController.h
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/7/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PJPLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface PJPCityFetchController : NSObject

+ (void) fetchSupportedCitiesInState: (NSString *) city completion:(void(^) (NSArray<PJPLocation *> *locations, NSError *error))completion;
+ (void) fetchCountryImage: (NSString *) location completion:(void(^) (UIImage * image, NSError *error))completion;


@end

NS_ASSUME_NONNULL_END
