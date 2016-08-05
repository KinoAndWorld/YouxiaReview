//
//  ReviewSummaryCell.m
//  YouxiaReview
//
//  Created by kino on 16/8/4.
//  Copyright © 2016年 kino. All rights reserved.
//

#import "ReviewSummaryCell.h"

#import "GameReview.h"

#import "AppElementConfig.h"

#import <Masonry.h>
#import <UIFont+BFKit.h>

@implementation ReviewSummaryCell{
	CAGradientLayer *_gradientLayer;
}

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		[self createElements];
		[self setupLayout];
	}
	return self;
}

- (void)createElements{
	_thumbImageView = [[KOProgressiveView alloc] initWithFrame:CGRectZero];
	[self.contentView addSubview:_thumbImageView];
	
	_titleLabel = [self configLabelWithFontSize:13 textColor:[UIColor blackColor]];
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.numberOfLines = 3;
	[self.contentView addSubview:_titleLabel];
	
	
	CGFloat linePos = ([UIScreen mainScreen].bounds.size.width - 40) / 10;
	_spliteLine = [[SplitLine alloc] initWithFrame:CGRectZero leftPosition:linePos rightPosition:linePos];
	[self .contentView addSubview:_spliteLine];
	
	
	_summaryLabel = [self configLabelWithFontSize:12 textColor:[UIColor grayColor]];
	_summaryLabel.numberOfLines = 0.f;
	[self.contentView addSubview:_summaryLabel];
	
	
	// 渐变图层
	_gradientLayer = [CAGradientLayer layer];
	_gradientLayer.frame = self.contentView.bounds;
	
	// 设置颜色
	_gradientLayer.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,
							  (id)[[UIColor whiteColor] colorWithAlphaComponent:1.0].CGColor];
	_gradientLayer.locations = @[[NSNumber numberWithFloat:0.55f],
								 [NSNumber numberWithFloat:1.0f]];
	
	// 添加渐变图层
	[self.contentView.layer addSublayer:_gradientLayer];
	
	
	_scoreView = [[MarkScoreView alloc] init];
	[self.contentView addSubview:_scoreView];
}


- (void)setupLayout{
	[_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.bottom.mas_equalTo(0);
		make.left.mas_equalTo(0);
		make.width.equalTo(_thumbImageView.mas_height).multipliedBy(3.f / 4.f);
	}];
	
	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(10);
		make.left.mas_equalTo(_thumbImageView.mas_right).offset(10);
		make.right.mas_equalTo(-10);
	}];
	
	[_spliteLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_titleLabel.mas_bottom).offset(10);
		make.left.equalTo(_thumbImageView.mas_right);
		make.right.mas_equalTo(0);
		make.height.mas_equalTo(1);
	}];
	
	[_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_spliteLine.mas_bottom).offset(10);
		make.left.mas_equalTo(_titleLabel);
		make.right.mas_equalTo(-10);
//		make.bottom.mas_equalTo(-20);
	}];
	
	[_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(-20);
		make.bottom.mas_equalTo(-10);
		make.width.mas_equalTo(60);
		make.height.mas_equalTo(40);
	}];
	
	self.contentView.backgroundColor = [UIColor whiteColor];
	
}

- (void)layoutSubviews{
	[super layoutSubviews];
	
	[self.contentView applyShadowWithCornerStyle:2];
	
	[self.thumbImageView applyCornerStyle:2 corner:UIRectCornerTopLeft | UIRectCornerTopRight];
}

- (void)configWithIndexPath:(NSIndexPath *)indexPath model:(GameReview *)review{
	
	[_thumbImageView setImageURL:[NSURL URLWithString:review.cover_image]];
	
	_titleLabel.text = review.title;
	
	_summaryLabel.text = review.summary;
	
	_scoreView.score = review.score;
}

@end


@implementation MarkScoreView{
	UIImageView *_backImageView;
	
	UILabel *_scoreLabel;
}


- (instancetype)init{
	if (self = [super init]) {
		[self commonInit];
	}
	
	return self;
}

- (void)commonInit{
	_backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mark"]];
	
	[self addSubview:_backImageView];
	
	_scoreLabel = [self configLabelWithFontSize:20 textColor:[UIColor orangeColor]];
	_scoreLabel.font = [UIFont fontForFontName:FontNameBaskervilleBold size:20];
	
	[self addSubview:_scoreLabel];
	
	
	[_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
	
	[_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self);
	}];
}

- (void)setScore:(NSString *)score{
	_scoreLabel.text = score;
}


@end