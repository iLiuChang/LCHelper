//
//  LCModel.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/8/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//  

#import <Foundation/Foundation.h>


@interface LCModel : NSObject

/**
 *  初始化model
 *
 *  @param dic 数据源字典
 *
 *  @return model
 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

/**
 *  初始化model
 *
 *  @param dic 数据源字典
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dic;

/**
 *  model转字典
 *
 *  @return 可变字典
 */
- (NSDictionary *)modelToDictionary;

/**
 *  model转json字符串
 *
 *  @return 字符串
 */
- (NSString *)modelToJSONString;


// -----------------以下子类重写专用-----------------

/**
 *  添加数据
 *  @warning: 如果有model中包含model需要重写次方法
 *  @example: 
 *   - (void)setValuesWithDictionary:(NSDictionary *)dic {
 *       [super setValuesWithDictionary:dic];
 *       self.student = [Student modelWithDictionary:dic[@"student"]];
 *   }
 *  @param dic 原数据
 */
- (void)setValuesWithDictionary:(NSDictionary *)dic;

/**
 *  交换属性值
 *  @warning: 警告如果子类中需要交换属性值需要重写此方法
 *  @example:
 *  - (NSDictionary *)exchangeValuesForKeys {
 *       return @{@"id" : @"ID"};
 *  }
 *  @return key: 原数据名; value: 自定义的名字
 */
- (NSDictionary *)exchangeValuesForKeys ;
@end
