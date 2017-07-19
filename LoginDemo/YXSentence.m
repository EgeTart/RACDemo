//
//  YXSentence.m
//  LoginDemo
//
//  Created by Passaction on 2017/7/19.
//  Copyright © 2017年 passaction. All rights reserved.
//

#import "YXSentence.h"

@implementation YXSentence

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"content"    :    @"content",
             @"note"       :    @"note",
             @"pictureURL" :    @"picture2",
             @"audioURL"   :    @"tts"
             };
}

+ (NSValueTransformer *)pictureURLJSONTransformer {
    return [MTLValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)audioURLJSONTransformer {
    return [MTLValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
