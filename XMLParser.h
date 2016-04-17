//
//  XMLParser.h
//  02 XML文件的解析
//
//  Created by 赵彦飞 on 16/3/24.
//  Copyright © 2016年 WXG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ParserBlock)(NSArray *models);

@interface XMLParser : NSObject<NSXMLParserDelegate>
{

    ParserBlock _parserBlock;
}
@property (nonatomic, strong) id currentModel;



- (id)initWithContentFile:(NSString *)fileName//需要解析的xml文件名
          withElementName:(NSString *)elementName//需要解析的对象
                  toModel:(NSString *)modelName
                withBlock:(ParserBlock)block;


@end
