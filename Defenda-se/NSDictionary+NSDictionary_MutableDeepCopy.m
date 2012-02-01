//
//  NSDictionary+NSDictionary_MutableDeepCopy.m
//  Defenda-se
//
//  Created by Argemiro Neto on 22/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+NSDictionary_MutableDeepCopy.h"

@implementation NSDictionary (NSDictionary_MutableDeepCopy)

- (NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    
    NSArray *keys = [self allKeys];
    
    for (id key in keys) {
        
        id oneValue = [self valueForKey:key]; 
        id oneCopy = nil;
        
        if ([oneValue respondsToSelector:@selector(mutableDeepCopy)]) 
            oneCopy = [oneValue mutableDeepCopy];
        else if ([oneValue respondsToSelector:@selector(mutableCopy)]) 
            oneCopy = [oneValue mutableCopy];
        
        if (oneCopy == nil)
            oneCopy = [oneValue copy];
        
        [returnDict setValue:oneCopy forKey:key];
    }
    
    return returnDict;
}

@end
