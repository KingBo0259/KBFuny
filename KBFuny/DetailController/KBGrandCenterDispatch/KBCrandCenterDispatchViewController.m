//
//  KBCrandCenterDispatchViewController.m
//  KBFuny
//
//  Created by jinlb on 16/2/29.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBCrandCenterDispatchViewController.h"

#import "Tiger.h"


static  int  const showtime=15;
static  BOOL   runAlways=YES;// Introduced to cheat Static Analyzer


static dispatch_source_t source_t;

@interface KBCrandCenterDispatchViewController ()

@property(weak,nonatomic)UIButton *countDownButton;
@property(weak,nonatomic)UILabel *countLabel;
@property(weak,nonatomic)NSThread *thread;
@property(assign,nonatomic)CFRunLoopRef runLoopRef;
@property(assign,nonatomic)CFRunLoopSourceRef source;
@property(assign,nonatomic)NSInteger productNumber;

@property(strong,nonatomic)NSCondition *condition;
@property(strong,nonatomic)NSMutableArray<NSString*> *sources;//资源列表
@property(weak,nonatomic) UILabel *productLabel;
@property(weak,nonatomic) UILabel *customerLabel;


@end

@implementation KBCrandCenterDispatchViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.condition=[[NSCondition alloc]init];
    self.sources=[[NSMutableArray alloc]init];
    [self createDataSource];
    [self createCustomer];
    [self UIInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)UIInit{
    self.title=@"Grand Central";
    CGFloat top=100,left=10,width=100,height=40;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(left, top, width, height);
    [btn addTarget:self action:@selector(GCD_barrirerClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"GCD_barrier" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton *runLoopBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [runLoopBtn setTitle:@"NSRunLoop" forState:UIControlStateNormal];
    [runLoopBtn addTarget:self action:@selector(runLoopDemo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:runLoopBtn];
    
    [runLoopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).offset(10);
    }];
    
    UIButton *timer=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [timer setTitle:@"NSTimer" forState:UIControlStateNormal];
    [timer addTarget:self action:@selector(timeDemo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timer];
    
    [timer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(runLoopBtn);
        make.top.equalTo(runLoopBtn.mas_bottom).offset(10);
    }];
    
    UIButton *countDownButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [countDownButton setTitle:@"开始倒计时" forState:UIControlStateNormal];
    [countDownButton addTarget:self action:@selector(startCountDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countDownButton];
    self.countDownButton=countDownButton;
    
    [countDownButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(runLoopBtn);
        make.top.equalTo(timer.mas_bottom).offset(10);
    }];
    
    UILabel  *label=[UILabel new];
    label.textColor=[UIColor blackColor];
    _countLabel=label;
     _countLabel.text=@"我时倒计时Lablel";
    [self.view addSubview:label];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countDownButton);
        make.left.equalTo(countDownButton.right).offset(10);
        
    }];
    
    
    
    UIButton *creatLoopButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [creatLoopButton setTitle:@"创建新的runLoop" forState:UIControlStateNormal];
    [creatLoopButton addTarget:self action:@selector(startButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatLoopButton];
    
    [creatLoopButton makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.equalTo(runLoopBtn);
        make.width.equalTo(@(width+40));
        make.top.equalTo(countDownButton.mas_bottom).offset(10);
    }];
    
    
    UIButton *triggerLoopButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [triggerLoopButton setTitle:@"Trigger RunLoop Event" forState:UIControlStateNormal];
    [triggerLoopButton addTarget:self action:@selector(triggerEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:triggerLoopButton];

    [triggerLoopButton makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(runLoopBtn);
        make.width.equalTo(@(width+80));
        make.top.equalTo(creatLoopButton);
        make.left.equalTo(creatLoopButton.mas_right).offset(10);
    }];

    
    
    UIButton *productButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [productButton setTitle:@"生产者模式" forState:UIControlStateNormal];
    [productButton addTarget:self action:@selector(productButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:productButton];
    
    UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _productLabel  = productLabel;
    productLabel.text = @"Product:0";
    productLabel.textColor = [UIColor flatGreenColor];
    [self.view addSubview:productLabel];
    
    UILabel *customerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _customerLabel  = customerLabel;
    customerLabel.text = @"Number:0";
    customerLabel.textColor = [UIColor flatMaroonColor];
    [self.view addSubview:customerLabel];
    
    [productButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(runLoopBtn);
        make.top.equalTo(creatLoopButton.mas_bottom).offset(10);
    }];
    
    [productLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productButton.right).offset(10);
        make.centerY.equalTo(productButton.centerY);
    }];
    
    [customerLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productLabel.right).offset(10);
        make.centerY.equalTo(productButton.centerY);

    }];
    
}

#pragma mark - 生产者 | 消费者


-(void)productButtonClick:(id)sender{
    static NSUInteger index=0;
    NSThread *thread=[[NSThread  alloc]initWithTarget:self selector:@selector(productorHander) object:nil];
    thread.name= [NSString stringWithFormat:@"ProductThread%li",index ];
    [thread start];

}



//生存者创建
-(void)productorHander{
    NSLog(@"*********Produc condition lock***********");
    [self.condition lock];
    NSLog(@" productorHander Begin");
    self.productNumber++;
    [self.sources addObject:[NSString stringWithFormat: @"source%li",self.productNumber]];
    [self updateProductUI];
//    [self.condition signal];//发送信号量
    NSLog(@" productorHander End");
    [self.condition unlock];
    NSLog(@"*********Produc condition unlock *********");
}

//创建消费者列表
-(void)createCustomer{
    NSThread *productThread=[[NSThread alloc]initWithTarget:self selector:@selector(customerHander) object:nil];

    [productThread start];
    
}
//消费则
-(void)customerHander{
    while (1) {
        NSLog(@"customerHander begion");
        [self.condition lock];
        NSLog(@"*********condition lock***********");
//        [self.condition wait];//等待
        NSLog(@"开始处理事件");
        for (NSInteger i=self.sources.count-1; i>=0; --i) {
            NSLog(@"printSource:第%li个; name: %@",i,[self.sources lastObject]);
            [self.sources removeLastObject];
            [self updateCustomerUI:self.sources.count];
            sleep(1);
        }
        [self updateProductUI];
        //处理事件
        NSLog(@"结束事件");
        [self.condition unlock];
        NSLog(@"condition unlock");
        NSLog(@"customerHander End");
    }
}

-(void)updateProductUI {
    void(^block)() = ^{
        _productLabel.text = [NSString stringWithFormat:@"product:%li",self.sources.count];

    };
    if([[NSThread currentThread] isMainThread]){
        block();
    }else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

-(void)updateCustomerUI:(NSInteger)count {
    void(^block)() = ^{
        _customerLabel.text = [NSString stringWithFormat:@"custome:%li",count];
        
    };
    if([[NSThread currentThread] isMainThread]){
        block();
    }else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
#pragma mark - GCD 实现倒计时
///GCD 实现倒计时
-(void)startCountDown:(UIButton*)sender{
    self.countDownButton.enabled=NO;
    __block int timeout=showtime+1;//倒计时＋1
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t queue=dispatch_get_main_queue();

    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1*NSEC_PER_SEC, 1*NSEC_PER_SEC); //每1秒触发timer，误差1秒
    
    __weak typeof(self) weakSelf=self;
    dispatch_source_set_event_handler(timer, ^{
        if (timeout<0) {//倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf sendDataSrouce];
                _countDownButton.enabled=YES;
                [_countDownButton setTitle:@"开始倒计时"
                                  forState:UIControlStateNormal];
                _countLabel.text=@"我时倒计时Lablel";
            });
        }else{ //倒计时 UI 更新
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countDownButton setTitle:[NSString stringWithFormat:@"%i秒",timeout]
                                  forState:UIControlStateNormal];
                
                _countLabel.text=[NSString stringWithFormat:@"%i秒",timeout];

                timeout--;
            });
       
        }
    });
    dispatch_resume(timer);
    
    
    

}

#pragma mark - onThread


-(void)startButton:(UIButton*)sender{
    
    if (_source) {
        [sender setTitle:@"创建RunLoop" forState:UIControlStateNormal];

        [self stopRunloop];
    }else{

        [sender setTitle:@"stop RunLoop" forState:UIControlStateNormal];
        [NSThread detachNewThreadSelector:@selector(onTread:)  toTarget:self withObject:nil];
    }

}
-(void)onTread:(id)sender{

    //这里获取到的已经是某个子线程了哦，不是主线程哦
    self.thread=[NSThread currentThread];
    
    CFRunLoopSourceContext context={0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
    //这里创建了一个基于事件的源
    context.perform = fire;
    
    _source=CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    
    //这里也是这个子线程的RunLoop哦
    _runLoopRef = CFRunLoopGetCurrent();
    
//    CFRunLoopGetMain();
//    [NSThread mainThread];
    //将源添加到当前RunLoop中去
    CFRunLoopAddSource(_runLoopRef, _source, kCFRunLoopDefaultMode);
    NSLog(@"onTread ");

    
//    // 方法一 、循环激活
//     runAlways=YES;//// Introduced to cheat Static Analyzer
//    while(runAlways) {
//        
//        NSLog(@"RunLoop 开始运行");
//        //每次RunLoop只运行10秒，每10秒做一次检测，如果没有需要处理的后台任务了，就让此线程自己终止，不用暴力Kill
//        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, NO);
//        NSLog(@"RunLoop 停止运行");
//
//
//    }
    
    
    //方法二
    NSLog(@"方法二 RunLoop 开始运行");
    //阻塞当前线程，等待事件响应;   一直执行侦听RunLoop 事件，这里 添加的是Source 事件
    CFRunLoopRun();
    NSLog(@"方法二 RunLoop 停止运行");
    
    // Should never be called, but anyway
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), _source, kCFRunLoopDefaultMode);
    CFRelease(_source);
    
    self.thread=nil;
    

}

- (void)stopRunloop{
    if(!_runLoopRef)return;
    
    runAlways = NO;
    CFRunLoopStop(_runLoopRef);
    _runLoopRef=nil;
    
}

- (void)triggerEvent{
    if (!_runLoopRef) {
        return;
    }
    if (CFRunLoopIsWaiting(_runLoopRef)) {
        NSLog(@"RunLoop 正在等待事件输入");
        //添加输入事件
        CFRunLoopSourceSignal(_source);
        //唤醒线程，线程唤醒后发现由事件需要处理，于是立即处理事件
        CFRunLoopWakeUp(_runLoopRef);
    }else {
        NSLog(@"RunLoop 正在处理事件");
        //添加输入事件，当前正在处理一个事件，当前事件处理完成后，立即处理当前新输入的事件
        CFRunLoopSourceSignal(_source);
    }
}


//此输入源需要处理的后台事件
static void fire(void* info __unused){
    NSLog(@"我现在正在处理后台任务");
    sleep(5);
}

#pragma mark - dispatch_source
//发送通知
-(void) sendDataSrouce{

    //一般网络请求之后通知
    dispatch_source_merge_data(source_t, 1010);//通知队列(可以通知进度条数据)

}
//GCD  侦听 DISPATCH_SOURCE_TYPE_DATA_ADD  数据变更
-(void)createDataSource{

    source_t=dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_global_queue(0, 0));
    
    dispatch_source_set_event_handler(source_t, ^{
        NSLog(@"dispatch_source_set_event_handler");
        
        sleep(5);
    });
    
    dispatch_source_set_event_handler(source_t, ^{ //block 不能叠加
        
       NSInteger  data= dispatch_source_get_data(source_t);//获取传递过来的数据
        NSLog(@"dispatch_source_set_event_handler2:%li",data);
    });
    
    
    dispatch_resume(source_t);//启动侦听

}



//测试定器，实际执行时间和设想的有所偏差
-(void)timeDemo{
    Tiger *testObject=[[Tiger alloc]init];
    //这个例子做了两件事：1、创建一个timer    2、将timer添加到 当前的runloop的default mode 中
    [NSTimer scheduledTimerWithTimeInterval:1 target:testObject selector:@selector(metodSwizingToLionTest) userInfo:nil repeats:YES];
//    [self performSelector:@selector(simulateBusy) withObject:nil afterDelay:3];
    
    //创建一个不添加到 runLoop 中的定时器
    NSTimer *timer=[[NSTimer alloc]initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1] interval:1 target:self selector:@selector(simulateBusy) userInfo:nil repeats:YES];
    //添加到 runLoop 中，否则不会自动运行
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    // 打开下面一行输出runloop的内容就可以看出，timer却是已经被添加进去
    NSLog(@"the thread's runloop: %@", [NSRunLoop currentRunLoop]);//    [timer fire];
    
}


-(void)simulateBusy{
    NSLog(@"start simulate busy!");
    NSUInteger caculateCount = 0x0FFFFFFF;
    CGFloat uselessValue = 0;
    for (NSUInteger i = 0; i < caculateCount; ++i) {
        uselessValue = i / 0.3333;
    }
    NSLog(@"finish simulate busy!");
}


-(void)runLoopDemo{

    
    /*
     三、Run Loop什么情况下使用
     
     使用ports 或 input sources 和其他线程通信 // 不了解
     在线程中使用timers // 如果不启动runloop，timer的事件是不会响应的
     
     在Cocoa 应用中使用performSelector…方法 // 应该是performSelector…这种方法会启动一个线程并启动run loop吧
     让线程执行一个周期性的任务
     注：timer的创建和释放必须在同一线程中。
     
     [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; 此方法会retain timer对象的引用计数。     */
    
    NSLog(@"runLoop Before");
    //停止当前runLoop 直到任何事件响应
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    NSLog(@"runLoop  End");

}


-(void)GCD_barrirerClick:(id)sender{
    //第一个先层
   dispatch_queue_t queue= dispatch_queue_create("kingbo_berrie_dispatch", NULL);
    
    queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"syn1");
    });
    
    dispatch_async(queue, ^{
        sleep(1);

        NSLog(@"syn2");
    });
    dispatch_async(queue, ^{
        sleep(1);

        NSLog(@"syn3");
    });
    dispatch_barrier_async(queue, ^{//栅栏块必须单独执行，不能与其他块并行
        NSLog(@"barrier");
    });
    
    dispatch_async(queue, ^{

        NSLog(@"syn4");
    });
    dispatch_async(queue, ^{
        NSLog(@"syn5");
    });
    

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
