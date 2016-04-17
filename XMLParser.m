//
//  XMLParser.m
//  02 XML文件的解析
//
//  Created by 赵彦飞 on 16/3/24.
//  Copyright © 2016年 WXG. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser
{
    NSMutableArray *_models;// 存数model的数组
    id _model;// model 对象
    

    NSString *_elementName;// 需要保存的节点名称
    NSString *_modelName;// 存储对象数据的model
    
     
    
    NSString *_elementString;//节点对应的属性值
    
}

- (id)initWithContentFile:(NSString *)fileName//需要解析的xml文件名
          withElementName:(NSString *)elementName//需要解析的对象
                  toModel:(NSString *)modelName//存储数据的model
                withBlock:(ParserBlock)block
{
    if (self = [super init]) {
     
        
        _elementName = elementName;
        _modelName = modelName;
        
        _parserBlock = block;
        
        
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSXMLParser *perser = [[NSXMLParser alloc] initWithData:data];
        
        perser.delegate = self;
        [perser parse];
        
    }
    
    return self;
}


// 1. 开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser {

    NSLog(@"1");
    
    // 开始解析  需要初始化一个数组来存储解析的model数据
    _models = [[NSMutableArray alloc] init];
    
}

// 2. 解析到一个头节点
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName// 节点名称
  namespaceURI:(NSString *)namespaceURI// 空格
 qualifiedName:(NSString *)qName// 合格的属性名
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    NSLog(@"2");
    //判断解析的节点内容
    if ([elementName isEqualToString:@"root"]) {
        
    }else if ([elementName isEqualToString:_elementName]){
        //获取需要解析的对象———> 初始化model对象
//        Class class = NSClassFromString(_modelName);
        
        self.currentModel = [[NSClassFromString(_modelName) alloc] init];
        
    }else {
    
        // 获取到具体的属性名，不需要具体操作
    }
    
}

// 3. 解析到节点中间的一个属性值
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string// 属性值
{
    NSLog(@"3");
    NSLog(@"%@",string);
    // 获取到具体的属性值
    _elementString = string;
}

// 4. 解析到一个尾节点
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName// 节点名称
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    NSLog(@"4");

    if ([elementName isEqualToString:@"root"]) {
        
        NSLog(@"文件解析完成");
    }else if ([elementName isEqualToString:_elementName]) {
    
        // 获取需要的节点名称 ——> model数据完成存储 --> model存放到数组
        [_models addObject:self.currentModel];
    
    }else {
    
        [self.currentModel setValue:_elementString forKey:elementName];
        
        NSLog(@"%@",self.currentModel);
    }
    
}



// 5. 结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"5");
    
    _parserBlock(_models);
}





@end
