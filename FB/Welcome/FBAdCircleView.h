//
//  FBAdCircleView.h
//  fenbeilaunch
//
//  Created by cc on 16/6/23.
//  Copyright © 2016年 toyscloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBAdCircleViewDelegate <NSObject>
@optional
- (void)doSomeThingWhileEndDecelerating:(NSInteger)index;

@end


@interface FBAdCircleView : UIView

//@property (strong, nonatomic) NSArray<UIImage *> *adImages;
@property (strong, nonatomic) NSArray<UIView *> *adViews;
@property (strong, nonatomic) NSArray<UIImage *> *pageImages;
@property (strong, nonatomic) NSArray<UIImage *> *currentPageImages;


@property (assign, nonatomic) CGPoint pageControlCenter;
@property (assign, nonatomic) CGRect  pageControlBounds;
@property (assign, nonatomic) CGFloat pageControlIndicatorMargin; /** spacing value(px) */

@property (weak, nonatomic) id<FBAdCircleViewDelegate> delegate;

@end
