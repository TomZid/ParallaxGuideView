//
//  ViewController.m
//  ParallaxGuideView
//
//  Created by wave on 15/9/24.
//  Copyright (c) 2015年 wave. All rights reserved.
//

#import "ViewController.h"
#import "ParallaxView.h"
#import "WaveScrollView.h"
#import "MCPagerView.h"

@interface ViewController ()<UIScrollViewDelegate, MCPagerViewDelegate>
@property (nonatomic, strong) ParallaxView   *parallaxView;
@property (nonatomic, strong) WaveScrollView *scrollView;
@property (nonatomic, strong) MCPagerView    *pagerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    [self uiconfig];
    NSMutableArray *array = [@[] mutableCopy];
    NSString *str = [@"" mutableCopy];
    //第一页
    str = @"a1-01";
    [array addObject:str];
    str = @"a2-01";
    [array addObject:str];
    str = @"a3-01";
    [array addObject:str];
    str = @"a3-02";
    [array addObject:str];
    
    //第二页
    str = @"b1-01"; //4
    [array addObject:str];
    str = @"b2-01";
    [array addObject:str];
    str = @"b3-02";
    [array addObject:str];
    str = @"b3-03";
    [array addObject:str];
    str = @"b4-01";
    [array addObject:str];
    
    //第三页
    str = @"c1-01"; //9
    [array addObject:str];
    str = @"c2-01";
    [array addObject:str];
    str = @"c3-01";
    [array addObject:str];
    str = @"c4-01";
    [array addObject:str];
    str = @"c5-01";
    [array addObject:str];
    
    //第四页
    str = @"d1-01"; //14
    [array addObject:str];
    str = @"d2-01";
    [array addObject:str];
    str = @"d3-01";
    [array addObject:str];
    str = @"d4-01";
    [array addObject:str];
    _parallaxView = [[ParallaxView alloc] initWithFrame:CGRectZero andImageArray:array];
    
    [_scrollView addSubview:_parallaxView];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 4, _scrollView.frame.size.height);
    
    _scrollView.delegate = self;
    
    // Pager
    [_pagerView setImage:[UIImage imageNamed:@"white"]
        highlightedImage:[UIImage imageNamed:@"black"]
                  forKey:@"a"];
    [_pagerView setImage:[UIImage imageNamed:@"white"]
        highlightedImage:[UIImage imageNamed:@"black"]
                  forKey:@"b"];
    [_pagerView setImage:[UIImage imageNamed:@"white"]
        highlightedImage:[UIImage imageNamed:@"black"]
                  forKey:@"c"];
    [_pagerView setImage:[UIImage imageNamed:@"white"]
        highlightedImage:[UIImage imageNamed:@"black"]
                  forKey:@"d"];
    
    [_pagerView setPattern:@"abcd"];
    
    _pagerView.delegate = self;
    
    
    __weak __typeof(self) ws = self;
    _pagerView.SkipBlock = ^(){
        [UIView animateWithDuration:1 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            ws.scrollView.alpha = 0;
            ws.pagerView.alpha = 0;
        } completion:^(BOOL finished) {
            ws.scrollView = nil;
            ws.pagerView = nil;
        }];
    };
}

- (void)uiconfig {
    _scrollView = [[WaveScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _pagerView = [[MCPagerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 24, SCREEN_WIDTH, 24)];
    [self.view addSubview:_pagerView];
}

- (void)updatePager {
    _pagerView.page = floorf(_scrollView.contentOffset.x / _scrollView.frame.size.width);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updatePager];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self updatePager];
    }
}

#pragma mark - MCPagerViewDelegate
- (void)pageView:(MCPagerView *)pageView didUpdateToPage:(NSInteger)newPage {
    CGPoint offset = CGPointMake(_scrollView.frame.size.width * _pagerView.page, 0);
    [_scrollView setContentOffset:offset animated:YES];
}

- (void)viewDidUnload {
    _pagerView  = nil;
    _scrollView = nil;
    [super viewDidUnload];
}

@end
