//
//  FBAdCircleView.m
//  fenbeilaunch
//
//  Created by cc on 16/6/23.
//  Copyright © 2016年 toyscloud. All rights reserved.
//

#import <SMPageControl.h>
#import "FBAdCircleView.h"
#import "constant.h"

@interface FBAdCircleView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) SMPageControl *pageControl;

@end

@implementation FBAdCircleView

#pragma mark - set&get&lazy load

- (void)setAdViews:(NSArray<UIView *> *)adViews
{
    _adViews = adViews;
    
    if (_adViews != nil) {
        NSInteger tempCount = _adViews.count;
        
        _scrollView.contentSize = CGSizeMake(tempCount*self.frame.size.width, self.frame.size.height);
        _pageControl.numberOfPages = tempCount;
        
        for (int i = 0; i < tempCount; ++i) {
            _adViews[i].frame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
            [_scrollView addSubview:_adViews[i]];
        }
    }
}

- (void)setPageImages:(NSArray<UIImage *> *)pageImages
{
    _pageImages = pageImages;
    
    for (int i = 0; i < pageImages.count; ++i) {
        [_pageControl setImage:pageImages[i] forPage:i];
    }
    
    _pageControl.currentPage = 0;
}

- (void)setCurrentPageImages:(NSArray<UIImage *> *)currentPageImages
{
    _currentPageImages = currentPageImages;
    
    for (int i = 0; i < currentPageImages.count; ++i) {
        [_pageControl setCurrentImage:currentPageImages[i] forPage:i];
    }
    
    _pageControl.currentPage = 0;
}

- (void)setPageControlCenter:(CGPoint)pageControlCenter
{
    _pageControlCenter = pageControlCenter;
    
    _pageControl.center = pageControlCenter;
}

- (void)setPageControlBounds:(CGRect)pageControlBounds
{
    _pageControlBounds = pageControlBounds;
    
    _pageControl.bounds = pageControlBounds;
}

- (void)setPageControlIndicatorMargin:(CGFloat)pageControlIndicatorMargin
{
    _pageControlIndicatorMargin = pageControlIndicatorMargin;
    
    _pageControl.indicatorMargin = pageControlIndicatorMargin;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_scrollView];
        
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }

    return _scrollView;
}

- (SMPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[SMPageControl alloc] init];
        [self addSubview:_pageControl];
        
        _pageControlCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height-45*RATIO);
        _pageControlBounds = CGRectMake(0, 0, 106*RATIO, 22*RATIO);
        _pageControlIndicatorMargin = 18;
        
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.currentPage = 0;
        
        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _pageControl;
}

#pragma mark - SMPageControl Event
- (void)pageChange:(SMPageControl *)pageControl
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * pageControl.currentPage, 0) animated:YES];
}

#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self scrollView];
        [self pageControl];
    }
    
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNum = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = pageNum;
    
    if ([self.delegate respondsToSelector:@selector(doSomeThingWhileEndDecelerating:)]) {
        [self.delegate doSomeThingWhileEndDecelerating:pageNum];
    }
}



@end
