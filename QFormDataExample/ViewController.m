//
//  ViewController.m
//  QFormDataExample
//
//  Created by JHQ0228 on 16/7/10.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "ViewController.h"

#import "QFormData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self uploadDemo1];
    
//    [self uploadDemo2];
    
    [self uploadDemo3];
}

/// 单文件上传简单封装

- (void)uploadDemo1 {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置上传的文件数据
    
        #define boundary @"uploadBoundary"
        
        NSMutableData *formDataM = [NSMutableData data];
        
        [formDataM q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];                                                  // 设置请求头
        
        [formDataM q_appendPartWithFileURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]] fileBoundary:boundary name:@"userfile" fileName:@"test1.png" mimeType:@"image/png"];                                                          // 添加文件
        
        [formDataM q_appendPartWithText:@"qian" textName:@"username" fileBoundary:boundary];                                        // 添加文本
        
        [formDataM q_appendPartEndingWithFileBoundary:boundary];                                                                    // 添加结束分隔符
    
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:formDataM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [self uploadResultWithData:data error:error];
        
    }] resume];
}

/// 单文件上传封装

- (void)uploadDemo2 {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置上传的文件数据
    
        NSData *filedata = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    
        NSData *formData = [NSData q_formDataWithRequest:request text:@"qian" textName:@"username" fileData:filedata name:@"userfile" fileName:@"test2.png" mimeType:@"image/png"];
    
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [self uploadResultWithData:data error:error];
        
    }] resume];
}

/// 多文件上传封装

- (void)uploadDemo3 {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload-m.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置上传的文件数据
    
        NSURL *fileURL1 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
        NSURL *fileURL2 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
        
        NSData *formData = [NSData q_formDataWithRequest:request texts:@[@"qian"] textNames:@[@"username"] fileURLs:@[fileURL1, fileURL2] name:@"userfile[]" fileNames:@[@"demoFile1.png", @"demoFile2.jpg"] mimeTypes:@[@"image/png", @"image/jpeg"]];
        
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        for (int i = 0; i < 2; i ++) {
            
            if ([result[0][@"userfile"][@"error"][i] intValue] == 0) {
                NSLog(@"文件 %d 上传成功", i+1);
            } else {
                NSLog(@"文件 %d 上传失败", i+1);
            }
        }
        
    }] resume];
}

- (void)uploadResultWithData:(NSData *)data error:(NSError *)error {
    
    if (error != nil || data == nil) {
        NSLog(@"网络连接错误！");
        return;
    }
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    if ([result[0][@"userfile"][@"error"] intValue] == 0) {
        NSLog(@"文件上传成功：\n%@", result);
    } else {
        NSLog(@"文件上传失败");
    }
}

@end
