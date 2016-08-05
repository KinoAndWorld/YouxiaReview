//
//  ReviewListView.m
//  YouxiaReview
//
//  Created by kino on 16/8/4.
//  Copyright © 2016年 kino. All rights reserved.
//

#import "ReviewListView.h"

#import <BFApp.h>

@implementation ReviewListView

- (instancetype)init{
	ReviewListViewLayout *layout = [[ReviewListViewLayout alloc] init];
	if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
											   [UIScreen mainScreen].bounds.size.height)
			   collectionViewLayout:layout]) {
		self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
	}
	return self;
}

@end


@implementation ReviewListViewLayout

- (instancetype)init{
	if (self = [super init]) {
		CGFloat imageWidth = [UIScreen mainScreen].bounds.size.width - 20;
		
		self.itemSize = CGSizeMake(imageWidth, imageWidth * (3.f / 7.f));
		self.minimumInteritemSpacing = 10;
		self.minimumLineSpacing = 10;
		self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
	}
	return self;
}

@end