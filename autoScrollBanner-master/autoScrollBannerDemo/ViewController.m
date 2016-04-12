//
//  ViewController.m
//  autoScrollBannerDemo
//
//  Created by mac on 14-2-11.
//  Copyright (c) 2014年 DJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    self.bannerView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


    NSMutableArray *dataArray1 = [NSMutableArray arrayWithCapacity:0];
    NSDictionary *bannerDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"http://pic05.babytreeimg.com/foto3/photos/2014/0124/88/2/4170109a13aca59db86761_b.png", @"img_url", nil];
    [dataArray1 addObject:bannerDic1];
    bannerDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"http://pic01.babytreeimg.com/foto3/photos/2014/0124/18/3/4170109a253ca5b0d88192_b.png", @"img_url", nil];
    [dataArray1 addObject:bannerDic1];

    HMBannerView *bannerView = [[HMBannerView alloc] initWithFrame:CGRectMake(0, 200, 320, 70) scrollDirection:ScrollDirectionLandscape images:dataArray1];

    [bannerView setRollingDelayTime:2.0];
    [bannerView setDelegate:self];
    [bannerView setSquare:0];
    [bannerView setPageControlStyle:PageStyle_Left];
    [bannerView showClose:YES];

    [bannerView startDownloadImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark HMBannerViewDelegate

- (void)imageCachedDidFinish:(HMBannerView *)bannerView
{
    if (bannerView == self.bannerView)
    {
        if (self.bannerView.superview == nil)
        {
            [self.view addSubview:self.bannerView];
        }

        [self.bannerView startRolling];
    }
    else
    {
        [self.view addSubview:bannerView];

        [bannerView startRolling];
    }
}

- (void)bannerView:(HMBannerView *)bannerView didSelectImageView:(NSInteger)index withData:(NSDictionary *)bannerData
{
    
}

- (void)bannerViewdidClosed:(HMBannerView *)bannerView;
{
    if (bannerView.superview)
    {
        [bannerView removeFromSuperview];
    }
}

@end
