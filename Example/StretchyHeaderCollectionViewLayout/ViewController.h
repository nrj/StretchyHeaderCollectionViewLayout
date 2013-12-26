//
//  ViewController.h
//  StretchyHeaderCollectionViewLayout
//
//  Created by Nick Jensen on 12/26/13.
//  Copyright (c) 2013 Nick Jensen. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kCellIdent;
extern NSString * const kHeaderIdent;

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    BOOL isScrolled;
}

@property (nonatomic, readonly) UICollectionView *collectionView;
@property (nonatomic, readonly) UICollectionReusableView *header;

@end
