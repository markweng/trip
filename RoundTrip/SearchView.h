//
//  SearchView.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/31.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol SearchViewDelegate <NSObject>

- (void)hiddenSearchView;
@optional
- (void)searchButtonAction:(NSInteger)buttonTag;

@end

@class HomeDataModel;
@interface SearchView : UIView
@property (nonatomic, weak)id<SearchViewDelegate>delegate;
@property (nonatomic, strong) HomeDataModel *dataModel;
@end
