//
//  SearchViewController.h
//  Glassy
//
//  Created by Niek Willems on 21/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"

@interface SearchViewController : UIViewController
    @property(nonatomic, strong) RESTClient* restGetNeighborhood;
    @property(nonatomic, strong) UITextField* searchTextField;
    @property(nonatomic, strong) UIView* searchView;
    @property(nonatomic, strong) UIView* resultView;
    @property(nonatomic) int labelHeight;
    @property(nonatomic) int leftMargin;

    -(void)clicked:(UIButton*) sender;
    -(void)clearResult;
    -(void)noResult;
    -(void)getNeighborhoodData:(NSString*)searchText;
    -(void)setNeighborhoodData;
    -(void)searchHandle;
    - (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client;
@end
