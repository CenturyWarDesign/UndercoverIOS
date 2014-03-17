//
//  UCIBookXML.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-3-17.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBookXML.h"

@implementation UCIBookXML


//Step1:准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

//Step2:准备解析结点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}


//Step3：获取首尾结点间内容

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
}


//Step4:解析完当前结点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

//Step5:解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

//Step6:获取CData块数据
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    
}

@end


