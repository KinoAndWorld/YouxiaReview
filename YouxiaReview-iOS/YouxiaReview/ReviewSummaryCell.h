//
//  ReviewSummaryCell.h
//  YouxiaReview
//
//  Created by kino on 16/8/4.
//  Copyright © 2016年 kino. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KOProgressiveView.h"

#import "SplitLine.h"

@class GameReview;
@class MarkScoreView;

@interface ReviewSummaryCell : UICollectionViewCell

@property (nonatomic, strong) KOProgressiveView *thumbImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (strong, nonatomic) SplitLine *spliteLine;

@property (nonatomic, strong) UILabel *summaryLabel;

@property (strong, nonatomic) MarkScoreView *scoreView;

- (void)configWithIndexPath:(NSIndexPath *)indexPath model:(GameReview *)review;

@end

@interface MarkScoreView : UIView

@property (copy, nonatomic) NSString *score;

@end