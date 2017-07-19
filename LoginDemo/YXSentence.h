//
//  YXSentence.h
//  LoginDemo
//
//  Created by Passaction on 2017/7/19.
//  Copyright © 2017年 passaction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface YXSentence : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, strong) NSURL *pictureURL;
@property (nonatomic, strong) NSURL *audioURL;

@end


//{
//sid: "2663",
//tts: "http://news.iciba.com/admin/tts/2017-07-19-day",
//content: "Two of the hardest things to say in life are: hello for the first time and goodbye for the last.",
//note: "最难开口的事就是，初次的问好，和最终的道别。",
//love: "2154",
//translation: "词霸小编：无奈的是，语言这东西，在表达爱意的时候如此无力；在表达伤害的时候，却又如此锋利。",
//picture: "http://cdn.iciba.com/news/word/20170719.jpg",
//picture2: "http://cdn.iciba.com/news/word/big_20170719b.jpg",
//caption: "词霸每日一句",
//dateline: "2017-07-19",
//s_pv: "0",
//sp_pv: "0",
//tags: - [
//         - {
//             id: null,
//         name: null
//         }
//         ],
//fenxiang_img: "http://cdn.iciba.com/web/news/longweibo/imag/2017-07-19.jpg"
//}

