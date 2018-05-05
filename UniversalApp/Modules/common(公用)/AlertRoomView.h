//
//  AlertRoomView.h
//  UniversalApp
//
//  Created by wjy on 2018/5/5.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "MMPopupView.h"
@protocol AlertRoomViewDelegate<NSObject>

- (void)roomDidSelect:(NSDictionary*)dic;

@end

@interface AlertRoomView : MMPopupView
/** 代理 */
@property (nonatomic, weak) id <AlertRoomViewDelegate>delegate;
@end
