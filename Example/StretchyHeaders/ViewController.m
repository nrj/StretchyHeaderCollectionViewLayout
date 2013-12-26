//
//  ViewController.m
//  StretchyHeaders
//
//  Created by Nick Jensen on 12/26/13.
//  Copyright (c) 2013 Nick Jensen. All rights reserved.
//

#import "ViewController.h"
#import "StretchyHeaderCollectionViewLayout.h"

NSString * const kCellIdent = @"Cell";
NSString * const kHeaderIdent = @"Header";

@implementation ViewController

@synthesize collectionView, header;

- (void)loadView {
    
    [super loadView];
    
    CGRect bounds;
    bounds = [[self view] bounds];
    
    StretchyHeaderCollectionViewLayout *stretchyLayout;
    stretchyLayout = [[StretchyHeaderCollectionViewLayout alloc] init];
    [stretchyLayout setSectionInset:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [stretchyLayout setItemSize:CGSizeMake(300.0, 494.0)];
    [stretchyLayout setHeaderReferenceSize:CGSizeMake(-1.0, 160.0)];
    
    collectionView = [[UICollectionView alloc] initWithFrame:bounds collectionViewLayout:stretchyLayout];
    [collectionView setBackgroundColor:[UIColor clearColor]];
    [collectionView setAlwaysBounceVertical:YES];
    [collectionView setShowsVerticalScrollIndicator:NO];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [[self view] addSubview:collectionView];
    [collectionView release];
    [stretchyLayout release];
    
    [collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:kCellIdent];
    
    [collectionView registerClass:[UICollectionReusableView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:kHeaderIdent];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)cv {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)cv viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (!header) {
        
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:kHeaderIdent
                                                           forIndexPath:indexPath];
        CGRect bounds;
        bounds = [header bounds];
        
        UIImageView *imageView;
        imageView = [[UIImageView alloc] initWithFrame:bounds];
        [imageView setImage:[UIImage imageNamed:@"header-background"]];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [imageView setClipsToBounds:YES];
        [header addSubview:imageView];
        [imageView release];
    }
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdent
                                                     forIndexPath:indexPath];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                (id)[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0f], NSFontAttributeName,
                                (id)[UIColor lightGrayColor], NSForegroundColorAttributeName, nil];
    
    NSAttributedString *attrText;
    attrText = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                                               attributes:attributes];
    UILabel *label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setNumberOfLines:0];
    [label setAttributedText:attrText];
    [cell addSubview:label];
    
    CGRect textRect = CGRectZero;
    textRect.size = [label sizeThatFits:[cell bounds].size];
    [label setFrame:textRect];
    
    [attrText release];
    [label release];
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end