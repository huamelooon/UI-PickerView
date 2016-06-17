//
//  FifthViewController.m
//  01-PickerViewDemo
//
//  Created by qingyun on 16/5/24.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "FifthViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface FifthViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;

@property (nonatomic) NSInteger hardLevel;          //游戏难度系数
@property (nonatomic, strong) NSArray *imageNames;

@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation FifthViewController
//懒加载图片名称
-(NSArray *)imageNames{
    if (_imageNames == nil) {
        _imageNames = @[@"apple",@"bar",@"cherry",@"crown",@"lemon",@"seven"];
    }
    return _imageNames;
}

//更改游戏难度系数
- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    _hardLevel = _segmentedControl.selectedSegmentIndex + 2;
}
//开始游戏
- (IBAction)start:(UIButton *)sender {
    _winLabel.text = @"";
    //声明一个胜利状态
    BOOL isWin = NO;
    //声明一个连续相同的row的数量sameRows
    NSInteger sameRows = -1;
    //声明上一列中选中的行
    int lastSelectedRow = -1;
    
    for (int i = 0; i < 5; i++) {
        //创建一个随机数(小于self.imageNames.count)
        int rowNum = arc4random() % self.imageNames.count;
        
        if (i == 0) {
            //为之后的对比做准备
            sameRows = 1;
        }else{
            //对比
            if (lastSelectedRow == rowNum) {
                sameRows++;
            }else{
                sameRows = 1;
            }
        }
        lastSelectedRow = rowNum;
        [_pickerView selectRow:rowNum inComponent:i animated:YES];
        //连续相同的个数不小于难度系数的时候,胜利
        //NSLog(@"sameRow:%ld----hardLevel:%ld",sameRows,_hardLevel);
        if (sameRows >= _hardLevel) {
            isWin = YES;
        }
    }
    
    //播放滚轮的声音
    NSString *crunchPath = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
    [self playSound:crunchPath];
    if (isWin) {
        //更改winLabel
        _winLabel.text = @"win!!!";
        //播放胜利音乐
        NSString *winPath = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];
        [self playSound:winPath];
    }
    
}


-(void)playSound:(NSString *)path{
    NSError *error = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:&error];
    //分配播放声音所需要的资源
    [_player prepareToPlay];
    [_player play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _winLabel.text = @"";
    //游戏默认难度系数
    _hardLevel = _segmentedControl.selectedSegmentIndex + 2;
    
    //设置pickerView的数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    // Do any additional setup after loading the view.
}

#pragma mark -UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.imageNames.count;
}

#pragma mark -UIPickerViewDelegate

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageNames[row]]];
    return imageView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 80;
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
