//
//  AlertIcoView.h
//  UniversalApp
//
//  Created by wjy on 2018/5/5.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "MMPopupView.h"
@protocol AlertIconViewDelegate<NSObject>

- (void)iconDidSelect:(NSDictionary*)dic;

@end
@interface AlertIconView : MMPopupView
- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items;
/** 代理 */
@property (nonatomic, weak) id <AlertIconViewDelegate>delegate;
@end
