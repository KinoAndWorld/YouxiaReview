//
//  ReviewListViewController.m
//  YouxiaReview
//
//  Created by kino on 16/8/4.
//  Copyright © 2016年 kino. All rights reserved.
//

#import "ReviewListViewController.h"

#import "ReviewListView.h"
#import "ReviewSummaryCell.h"

#import "GameReview.h"
#import "ReviewApiEngine.h"

#import <Masonry.h>
#import <BFKit.h>

#define useWeakSelf __weak typeof(self) weakSelf = self;

@interface ReviewListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) ReviewListView *reviewListView;

@property (strong, nonatomic) NSArray *reviewList;

@end

@implementation ReviewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"游侠评测";
	
	[self commonInit];
	[self setupLayouts];
	
	[self fetchData];
}

- (void)commonInit{
	
	ReviewListView *colview = [[ReviewListView alloc] init];
	colview.delegate = self;
	colview.dataSource = self;
	[colview registerClass:[ReviewSummaryCell class] forCellWithReuseIdentifier:@"ReviewSummaryCell"];
	
	_reviewListView = colview;
	[self.view addSubview:_reviewListView];
}

- (void)setupLayouts{
	
	[_reviewListView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}

- (void)fetchData{
	useWeakSelf
	[ReviewApiEngine fetchReviewListWithSuccessHandler:^(id responseResult) {
		
		self.reviewList = responseResult;
		
		[weakSelf.reviewListView reloadData];
		
	} errorHandler:^(NSError *error) {
		
	} translater:[GameReview class]];
}

#pragma mark - CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.reviewList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	ReviewSummaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReviewSummaryCell" forIndexPath:indexPath];
	
	[cell configWithIndexPath:indexPath model:[self.reviewList safeObjectAtIndex:indexPath.row]];
	
	return cell;
}

- (NSArray *)reviewList{
	if (!_reviewList) {
		_reviewList = [NSArray array];
	}
	
	return _reviewList;
}


@end
