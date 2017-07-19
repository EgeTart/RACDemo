//
//  YXHomeViewController.m
//  LoginDemo
//
//  Created by Passaction on 2017/7/19.
//  Copyright © 2017年 passaction. All rights reserved.
//

#import "YXHomeViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "YXSentence.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface YXHomeViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) YXSentence *sentence;

@property (nonatomic, strong) UIImageView *sentenceImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *noteLable;
@property (nonatomic, strong) RACSignal *loadSentenceSignal;

@end

@implementation YXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureInterface];
    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://open.iciba.com/dsapi/"]];
//    NSURLSessionDataTask *task = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"%@ ----- %@ ------ %@", response, responseObject, error);
//        self.sentence = [MTLJSONAdapter modelOfClass:[YXSentence class] fromJSONDictionary:responseObject error:nil];
//        [self updateUIWithSentence:self.sentence];
//    }];
//    [task resume];

    self.loadSentenceSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://open.iciba.com/dsapi/"]];
        NSURLSessionDataTask *task = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            NSLog(@"%@ ----- %@ ------ %@", response, responseObject, error);
            YXSentence *sentence = [MTLJSONAdapter modelOfClass:[YXSentence class] fromJSONDictionary:responseObject error:nil];
            [subscriber sendNext:sentence];
            [subscriber sendCompleted];
        }];
        [task resume];
        return nil;
    }];
    
    [self.loadSentenceSignal subscribeNext:^(id x) {
        [self updateUIWithSentence:x];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationItem.hidesBackButton = YES;
}

- (void)configureInterface {
    [self.view addSubview:self.sentenceImageView];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.noteLable];
    
    [self.sentenceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(28);
        make.trailing.equalTo(self.view).offset(-28);
    }];
    
    [self.noteLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(12);
        make.bottom.equalTo(self.view).offset(-100);
    }];
}

- (void)updateUIWithSentence:(YXSentence *)sentence {
    [self.sentenceImageView sd_setImageWithURL:sentence.pictureURL];
    self.contentLabel.text = sentence.content;
    self.noteLable.text = sentence.note;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
        NSMutableSet *acceptContentType = [NSMutableSet setWithSet:_manager.responseSerializer.acceptableContentTypes];
        [acceptContentType addObject:@"text/html"];
        _manager.responseSerializer.acceptableContentTypes = acceptContentType;
    }
    return _manager;
}

- (UIImageView *)sentenceImageView {
    if (!_sentenceImageView) {
        _sentenceImageView = [[UIImageView alloc] init];
        _sentenceImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _sentenceImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont boldSystemFontOfSize:15];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

- (UILabel *)noteLable {
    if (!_noteLable) {
        _noteLable = [[UILabel alloc] init];
        _noteLable.font = [UIFont systemFontOfSize:15];
        _noteLable.numberOfLines = 0;
        _noteLable.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _noteLable;
}

@end
