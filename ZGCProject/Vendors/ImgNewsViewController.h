//
//  ImgNewsViewController.h
//  Project-Movie
//
//  Created by Minr on 14-11-14.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgNewsViewController : UIViewController <UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSString *proId;
@property (nonatomic, retain) NSString *serieasId;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSString *urlString;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
