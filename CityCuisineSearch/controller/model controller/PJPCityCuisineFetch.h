//
//  PJPCityCuisineFetch.h
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/8/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJPCuisine.h"
#import "PJPLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface PJPCityCuisineFetch : NSObject

+ (void) fetchCityCuisine: (PJPLocation *) location completion:(void(^) (NSArray<PJPCuisine *> *cuisines, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
