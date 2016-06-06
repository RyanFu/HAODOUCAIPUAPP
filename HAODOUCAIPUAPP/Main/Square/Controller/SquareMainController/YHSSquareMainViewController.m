//
//  YHSSquareMainViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSSquareMainViewController.h"
#import "YHSCookBookSearchViewController.h"
#import "YHSScrollAnimationTitleBar.h"
#import "UIView+Frame.h"
#import "YHSTopicGroupViewController.h"
#import "YHSFriendGroupViewController.h"
#import "YHSDynamicGroupViewController.h"



static CGFloat SQUARE_SCROLL_TITLE_BAR_HEIGHT = 35.0;


@interface YHSSquareMainViewController () <UIScrollViewDelegate, YHSScrollAnimationTitleBarDelegate>
@property (nonatomic, strong) YHSScrollAnimationTitleBar *scrollTitleBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIView *> *scrollChildViews;
@end


@implementation YHSSquareMainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navBarHairlineImageView setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navBarHairlineImageView setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加导航按钮视图YHSScrollTitleBar
    [self setupScrollTitleBar];
    
    // 添加滚动视图UIScrollView
    [self setupScrollViewController];
    
    // 默认选中第一个
    [self.scrollTitleBar wanerSelected:0];
}


#pragma mark - 添加导航按钮视图
- (void)setupScrollTitleBar
{
    YHSScrollAnimationTitleBar *scrollTitleBar = [[YHSScrollAnimationTitleBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, SQUARE_SCROLL_TITLE_BAR_HEIGHT)];
    scrollTitleBar.delegate = self;
    scrollTitleBar.titles = @[@"话题", @"豆友", @"动态"];
    scrollTitleBar.duration = 0.3f;
    scrollTitleBar.titlesFont = [UIFont boldSystemFontOfSize:18.0];
    scrollTitleBar.titlesCustomeColor = COLOR_NAVIGATION_BAR_TITLE;
    scrollTitleBar.titlesHeightLightColor = [UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00];
    scrollTitleBar.backgroundHeightLightColor = [UIColor whiteColor];
    scrollTitleBar.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00];
    [self.view addSubview:scrollTitleBar];

    self.scrollTitleBar = scrollTitleBar;
}


#pragma mark - 添加滚动视图
- (void)setupScrollViewController
{
    // 1.话题
    YHSTopicGroupViewController *viewController1 = [[YHSTopicGroupViewController alloc] init];
    [self addChildViewController:viewController1];
    
    // 2.豆友
    YHSFriendGroupViewController *viewController2 = [[YHSFriendGroupViewController alloc] init];
    [self addChildViewController:viewController2];
    
    // 3.动态
    YHSDynamicGroupViewController *viewController3 = [[YHSDynamicGroupViewController alloc]init];
    [self addChildViewController:viewController3];
    
    // 将这几个视图控制器的VIEW添加到数组中
    [self.scrollChildViews addObject:viewController1.view];
    [self.scrollChildViews addObject:viewController2.view];
    [self.scrollChildViews addObject:viewController3.view];
    
    
    // 添加滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    WEAKSELF(weakSelf);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加约束：滚动视图
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_topLayoutGuide).with.offset(SQUARE_SCROLL_TITLE_BAR_HEIGHT);
        make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide).with.offset(0);
        make.left.equalTo(weakSelf.view).with.offset(0);
        make.right.equalTo(weakSelf.view).with.offset(0);
    }];
    
    // 添加约束：scrollview里放个View，起到桥梁作用，用于计算srcollView的contentSize
    UIView *container = [[UIView alloc] init];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
    }];
    
    // 添加约束
    UIView *lastView = nil;
    for (int i = 0; i < self.scrollChildViews.count; i ++) {
        UIView *subView = self.scrollChildViews[i];
        
        [container addSubview:subView];
        
        subView.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                             saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                             brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                  alpha:1];
        
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(container).offset(0);
            make.bottom.equalTo(container).offset(0);
            make.width.mas_equalTo(self.view.width);
            
            if (lastView) {
                make.left.equalTo(lastView.mas_right).offset(0);
            } else {
                make.left.equalTo(container.mas_left).offset(0);
            }
        }];
        
        lastView = subView;
        
    }
    
    // 添加约束：保证约束的完整性
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(0);
    }];
    
}

#pragma mark - UIScrollView滚动视图中装载的控制器的view
- (NSMutableArray *)scrollChildViews
{
    if(!_scrollChildViews) {
        _scrollChildViews = [NSMutableArray array];
    }
    return _scrollChildViews;
}

#pragma mark 添加SJBPicTitleScrollerView的代理方法
- (void)scrollTitleBar:(YHSScrollAnimationTitleBar *)scrollTitleBar scrollToIndex:(NSInteger)tagIndex title:(NSString *)title
{
    [self.scrollView scrollRectToVisible:CGRectMake(self.view.width*tagIndex, 0, self.view.width, self.view.height)
                                animated:YES];
}


#pragma mark - UIScrollView 代理方法，只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x/self.view.width == 0) {
        [self.scrollTitleBar wanerSelected:0];
    } else if (scrollView.contentOffset.x/self.view.width == 1) {
        [self.scrollTitleBar wanerSelected:1];
    } else if (scrollView.contentOffset.x/self.view.width == 2) {
        [self.scrollTitleBar wanerSelected:2];
    }
}


#pragma mark - 自定义配置导航栏
- (void)customNavigationBar
{
    [super customNavigationBar];
    
    // 自定义导航栏
    if (self.navigationController) {
        
        CGFloat margin = 10;
        
        // 1.自定义导航条
        self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
        [self.navBarCustomView setBackgroundColor:COLOR_NAVIGATION_BAR];
        [self.navigationItem setTitleView:self.navBarCustomView];
        
        // 2.到家
        CGFloat iconWidth = 50.0f;
        CGFloat iconHeight = 22.0f;
        UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(margin, ((HEIGHT_NAVIGATION_BAR-iconHeight)/2.0), iconWidth, iconHeight)];
        [leftIcon setImage:[UIImage imageNamed:@"font_header_theme"]];
        [leftIcon.layer setMasksToBounds:YES];
        [self.navBarCustomView addSubview:leftIcon];
        
        // 2.全部
        CGFloat rightOneWidth = 35.0; // 最大值为44
        CGFloat rightOneHeight = 35.0;
        UIButton *rightOneItem = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-margin/2.0-rightOneWidth, ((HEIGHT_NAVIGATION_BAR-rightOneHeight)/2.0), rightOneWidth, rightOneHeight)];
            [button.layer setMasksToBounds:YES];
            [button setAdjustsImageWhenHighlighted:NO];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
            [button setImage:[UIImage imageNamed:@"btn_header_edit"] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(naviRightOneBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            button;
        });
        self.rightOneItem  = rightOneItem;
        
        // 4.导航条搜索按钮区域
        {
            // 4.1搜索区域主容器
            UIView *searchAreaView = ({
                UIView *searchAreaView = [[UIView alloc] initWithFrame:CGRectMake(2*margin+iconWidth, 7, self.navigationController.navigationBar.frame.size.width-iconWidth-rightOneWidth-3.0*margin, self.navigationController.navigationBar.frame.size.height-14)];
                [searchAreaView.layer setBorderWidth:1.0f];
                [searchAreaView.layer setCornerRadius:6.0f];
                [searchAreaView.layer setBorderColor:COLOR_NAVIGATION_BAR_SEARCH.CGColor];
                [searchAreaView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
                [self.navBarCustomView addSubview:searchAreaView];
                
                // 添加点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressSearchArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [searchAreaView addGestureRecognizer:tapGesture];
                
                searchAreaView;
            });
            self.searchAreaView  = searchAreaView;
            
            // 4.2导航条搜索图标
            UIImageView *searchIconImageView = ({
                UIImageView *searchIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 22, 22)];
                [searchIconImageView setImage:[UIImage imageNamed:@"action_search_gray"]];
                [searchAreaView addSubview:searchIconImageView];
                
                searchIconImageView;
            });
            self.searchIconImageView = searchIconImageView;
            
            // 4.3导航条搜索标题
            UILabel *searchTitleLable = ({
                UILabel *searchTitleLable = [[UILabel alloc] init];
                [searchTitleLable setText:@"搜索话题"];
                [searchTitleLable setTextColor:COLOR_NAVIGATION_BAR_SEARCH_TITLE_GRAY];
                [searchTitleLable setFont:[UIFont boldSystemFontOfSize:13.0]];
                [searchAreaView addSubview:searchTitleLable];
                
                [searchTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(searchAreaView.mas_top).offset(5);
                    make.left.equalTo(searchIconImageView.mas_right).offset(5);
                    make.right.equalTo(searchAreaView.mas_right).offset(-5);
                    make.height.equalTo(@22);
                }];
                
                searchTitleLable;
            });
            self.searchTitleLable = searchTitleLable;
        }
        
    }
    
}

#pragma mark - 触发导航栏按钮事件

// 触发搜索按钮事件
- (void)pressSearchArea:(UITapGestureRecognizer *)gesture
{
    YHSCookBookSearchViewController *searchViewController = [YHSCookBookSearchViewController new];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

// 触发最右边按钮事件
- (void)naviRightOneBarButtonItemClicked:(UIButton *)button
{
    
}



@end
