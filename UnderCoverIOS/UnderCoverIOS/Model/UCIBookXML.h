//
//  UCIBookXML.h
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-3-17.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCIBookXML : NSObject
@property (nonatomic,readwrite) NSInteger bookID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *summary;
@end
