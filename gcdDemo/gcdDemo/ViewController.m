//
//  ViewController.m
//  gcdDemo
//
//  Created by mac on 14-3-16.
//  Copyright (c) 2014年 Robin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)serialQueue
{
    //gcd create a seria dispatch queue,有句话是这么说的 ，你不能生成太多的serailQueues
    dispatch_queue_t serailQueue1 = dispatch_queue_create("com.robin.createSerialQueue1", NULL);
    dispatch_queue_t serailQueue2 = dispatch_queue_create("com.robin.createSerialQueue2", NULL);
    dispatch_queue_t serailQueue3 = dispatch_queue_create("com.robin.createSerialQueue3", NULL);
    
    
    //user seria dispatch queue
    dispatch_async(serailQueue1, ^{
        for (int count = 0; count < 100; count++) {
            NSLog(@"thi is serialQueue1");
        }
        
    });
    
    dispatch_async(serailQueue2, ^{
        for (int count = 0; count < 100; count++) {
            NSLog(@"thi is serialQueue2");
        }
        
    });
    
    dispatch_async(serailQueue3, ^{
        for (int count = 0; count < 100; count++) {
            NSLog(@"thi is serialQueue3");
        }
        
    });
    
    //ARC下依然被禁止
    //dispatch_release(serailQueue);
    
}

- (void)conCurrentQueue
{
    //
    dispatch_queue_t conCurrentQueue = dispatch_queue_create("com.robin.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(conCurrentQueue, ^{
        for (int count = 0; count < 100; count++) {
            NSLog(@"thi is block1");
        }
        
    });
    
    dispatch_async(conCurrentQueue, ^{
        for (int count = 0; count < 100; count++) {
            NSLog(@"thi is block2");
        }
        
    });
    
    dispatch_async(conCurrentQueue, ^{
        for (int count = 0; count < 100; count++) {
            NSLog(@"thi is block3");
        }
        
    });
}

-(void)globalDispatchQueue
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(globalQueue, ^{
        dispatch_async(mainQueue, ^{
            //跳啊
        });
    });
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
   // [self serialQueue];

    [self conCurrentQueue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
