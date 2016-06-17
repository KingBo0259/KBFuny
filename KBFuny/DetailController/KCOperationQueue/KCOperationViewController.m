//
//  KCOpeViewController.m
//  KBFuny
//
//  Created by jinlb on 16/3/10.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KCOperationViewController.h"

@interface KCOperationViewController ()
{

    NSOperationQueue *queue;
    NSInteger index;
    
    NSInvocationOperation *eightOperation;//第八个
    NSCache *pictureCache;//具有缓存功能，并且线程安全（若涉及到网络 图片缓存时，优先考虑改方法）

}


@end

@implementation KCOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   queue=[[NSOperationQueue alloc]init];
    
    pictureCache=[NSCache new];
    pictureCache.totalCostLimit=5;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma makr - NSCache
-(IBAction)cacheClick:(id)sender{
    for (int i=1; i<100; ++i) {
        NSString *value=[NSString stringWithFormat:@"%i",i];
        [pictureCache setObject:value forKey:value];

    }

    for (int i=1; i<100; ++i) {
        NSString *value=[NSString stringWithFormat:@"%i",i];

       id obje= [pictureCache objectForKey:value];
        NSLog(@"%@",obje);
    }
    

    
    
}

#pragma mark - NSOperationQueue
- (IBAction)buttonClick:(id)sender {
    

    for (int i=0; i<10; ++i) {
        NSInvocationOperation *invocationOperation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testQueue:) object:[NSString stringWithFormat:@"%i",i]];
        [queue addOperation:invocationOperation];
        
        if(i==8) eightOperation=invocationOperation;
    }
    
    
    [queue addOperationWithBlock:^{
        
        NSLog(@"我是Block 添加");
    }];
//    NSLog(@"开始等待");
//
//    [queue waitUntilAllOperationsAreFinished];
//    NSLog(@"结束等待");
}

-(IBAction)cancel:(id)sender{
//    [queue cancelAllOperations];//全部停止 无效 
    
    [eightOperation cancel];
}

-(void)testQueue:(NSString*)url{
    @synchronized(self) {//同步锁，不然数据并非是我们想要的数据
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Before:%li ======%@",index,url);
        index++;
        NSLog(@"After:%li",index);
    }
    
}


#pragma mark - NSArray 遍历
//遍历不介意用 for  进行遍历
-(IBAction)arrayBianliClick:(id)sender{


    NSArray *testArray=@[@"1",@"2",@"3",@"4",@"5"];
    
    NSLog(@"======block 遍历======");
    [testArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"%@",obj);
        
    }];
    
    
    
   NSLog(@"========NSEnumerator 遍历=======");
   NSEnumerator *enumerator= [testArray objectEnumerator];
    
    id objec=nil;
    while ((objec=[enumerator nextObject])!=nil) {
        NSLog(@"%@",objec);
    }
    
    NSLog(@"========for in 遍历=======");
    for (NSString *item in testArray) {
        NSLog(@"%@",item);
    }
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
