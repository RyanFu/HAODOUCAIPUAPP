//
//  YHSCookBookMenuTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookMenuTableViewCell.h"
#import "YHSCookBookHotsAlbumMoreModel.h"


@implementation YHSCookBookMenuTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        [self setViewAtuoLayout];
    }
    return self;
}

#pragma make 创建子控件
- (void) createView {
    
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    // 根容器组件
    self.rootContainerView = [[UIView alloc] init];
    [self.contentView addSubview:self.rootContainerView];
    
    // 公共容器组件
    {
        self.publicContainerView =[[UIView alloc] init];
        [self.publicContainerView.layer setMasksToBounds:YES];
        [self.rootContainerView addSubview:self.publicContainerView];
        
        // 点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressPublicContainerArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.publicContainerView addGestureRecognizer:tapGesture];
    }
    
    
    // 图片
    self.coverImageView = [UIImageView new];
    [self.coverImageView.layer setCornerRadius:3.0];
    [self.coverImageView.layer setMasksToBounds:YES];
    [self.coverImageView setUserInteractionEnabled:YES];
    [self.publicContainerView addSubview:self.coverImageView];
    
    // 标题
    self.titleLabel = [UILabel new];
    [self.titleLabel setUserInteractionEnabled:YES];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.titleLabel];
    
    // 播放时长/收藏总数/浏览总数
    self.collectionLabel = [UILabel new];
    [self.collectionLabel setUserInteractionEnabled:YES];
    [self.collectionLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
    [self.collectionLabel setFont:[UIFont systemFontOfSize:15]];
    [self.collectionLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.collectionLabel];
    
    // 内容详情
    self.contentLabel = [UILabel new];
    [self.contentLabel setUserInteractionEnabled:YES];
    [self.contentLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
    [self.contentLabel setFont:[UIFont systemFontOfSize:17]];
    [self.contentLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.contentLabel];
    
    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.publicContainerView addSubview:self.separatorLineView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10;
    
    // 根容器组件
    [self.rootContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(0);
    }];
    
    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
    }];
    
    // 图片
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin/2.0);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.width.equalTo(@100);
        make.height.equalTo(@70);
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageView.mas_top);
        make.left.equalTo(weakSelf.coverImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.equalTo(weakSelf.coverImageView.mas_height).multipliedBy(1.0/3.0);
    }];
    
    // 收藏总数/浏览总数
    [self.collectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
        make.left.equalTo(weakSelf.coverImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.equalTo(weakSelf.coverImageView.mas_height).multipliedBy(1.0/3.0);
    }];
    
    // 内容详情
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.collectionLabel.mas_bottom);
        make.left.equalTo(weakSelf.coverImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.equalTo(weakSelf.coverImageView.mas_height).multipliedBy(1.0/3.0);
    }];
    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageView.mas_bottom).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0.0);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(0.0);
        make.height.equalTo(@(1.0));
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.separatorLineView.mas_bottom).offset(0.0);
    }];
    
}


#pragma mark - 触发操作事件

- (void)pressPublicContainerArea:(UITapGestureRecognizer *)gesture
{
    // 子类必须继承
}

@end
