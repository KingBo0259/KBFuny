//
//  KBZbarViewController.m
//  KBFuny
//
//  Created by jinlb on 15/5/28.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBZbarViewController.h"

@implementation KBZbarViewController{

    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UITextField *_scanResult1;
    ZBarReaderViewController *reader;
}

-(void)viewDidLoad{

    [super viewDidLoad];

    NSLog(@"viewDidLoad");
}
- (IBAction)scanClick:(id)sender {
    reader= [ZBarReaderViewController new];
    reader.readerDelegate = self;
    [reader.scanner setSymbology: ZBAR_QRCODE
                          config: ZBAR_CFG_ENABLE
                              to: 0];
    reader.readerView.zoom = 1.0;
    
    //扫描区域，这里可以自己调整
//    reader.readerView.scanCrop=scanMaskRect;
//    [self.navigationController pushViewController:reader animated:YES];
    [self presentViewController:reader animated:NO completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    id<NSFastEnumeration> results =[info objectForKey: ZBarReaderControllerResults];
    UIImage *image =[info objectForKey: UIImagePickerControllerOriginalImage];
    imageView.image=image;
    
    ZBarSymbol * symbol;
    for(symbol in results)
        break;
    
    NSLog(@"%@",symbol.data);
    _scanResult1.text=symbol.data;
//    [reader.navigationController popViewControllerAnimated:YES];
    [reader dismissViewControllerAnimated:NO completion:nil];

}

@end
