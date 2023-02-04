//
//  ViewController.m
//  CalculatorIOS
//
//  Created by Phạm Thanh Hải on 02/02/2023.
//

#import "ViewController.h"
#define SPACING 0

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray *arrFeature;
@property (strong, nonatomic) NSString *strTemp;
@property (nonatomic) BOOL isHaveMath;
@property (nonatomic) BOOL canDelete;
@property (nonatomic) BOOL canShowPercent;
@property (nonatomic) BOOL canUseDot;
@end

@implementation ViewController

-(NSMutableArray *)arrFeature {
    if (!_arrFeature) {
        _arrFeature = [[NSMutableArray alloc] init];
    }
    return _arrFeature;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCollectionView];
    self.arrFeature = [NSMutableArray arrayWithObjects:@"C",@"7",@"4",@"1",@"Rotate",@"%",@"8",@"5",@"2",@"0",@"Del",@"9",@"6",@"3",@".",@"+",@"-",@"x",@":",@"=", nil];
    self.lbResult.text = @"";
    self.strTemp = @"";
}

-(void)setupCollectionView {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ButtonCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ButtonCollectionViewCell class])];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - DATASOURCE
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ButtonCollectionViewCell class]) forIndexPath:indexPath];
    [cell configCellWith:self.arrFeature[indexPath.row]];
    return cell;
}


#pragma mark - DELEGATE
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0){
        self.lbResult.text = @"";
    }
    else if (indexPath.item == 4) {
        NSLog(@"Tap Button Rotate");
    }
    else if (indexPath.item == 5) {
        if (self.canShowPercent) {
            self.lbResult.text = [NSString stringWithFormat:@"%f", ([self.lbResult.text longLongValue] / 100.0f)];
        }
    }
    else if (indexPath.item == 10) {
        if ([self.lbResult.text length] > 0 && self.canDelete) {
            [self checkTheLastCharOfString];
            self.lbResult.text = [self.lbResult.text substringToIndex:[self.lbResult.text length] - 1];
        } else {
            //no characters to delete... attempting to do so will result in a crash
        }
    }
    else if (indexPath.item == 14) {
        if (self.canUseDot) {
            [self buttonClick:@"."];
        }
        self.canUseDot = NO;
    }
    else if (indexPath.item == 15) {
        if (!self.isHaveMath) {
            [self buttonClick:@"+"];
            self.canUseDot = YES;
        }
        self.isHaveMath = YES;
    }
    else if (indexPath.item == 16) {
        if (!self.isHaveMath) {
            [self buttonClick:@"-"];
            self.canUseDot = YES;
        }
        self.isHaveMath = YES;
    }
    else if (indexPath.item == 17) {
        if (!self.isHaveMath) {
            [self buttonClick:@"*"];
            self.canUseDot = YES;
        }
        self.isHaveMath = YES;
    }
    else if (indexPath.item == 18) {
        if (!self.isHaveMath) {
            [self buttonClick:@"/"];
            self.canUseDot = YES;
        }
        self.isHaveMath = YES;
    }
    else if (indexPath.item == 19) {
        if ([self validInput]) {
            if ([self.lbResult.text containsString:@"+"] || [self.lbResult.text containsString:@"-"] || [self.lbResult.text containsString:@"*"] || [self.lbResult.text containsString:@"/"])
            {
                NSString *checkedWorkingsForPercent = [self.lbResult.text stringByReplacingOccurrencesOfString:@"%" withString:@"/100"];
                checkedWorkingsForPercent = [NSString stringWithFormat:@"%@.0", checkedWorkingsForPercent];
                
                NSExpression *expression = [NSExpression expressionWithFormat:checkedWorkingsForPercent];
                
                NSNumber *result = (NSNumber *)[expression expressionValueWithObject:nil context:nil] ;
                
                self.lbResult.text = [NSString stringWithFormat:@"%@", result];
            }
            else {
                self.lbResult.text = self.lbResult.text;
            }
            
        }
        else {
            NSLog(@"Invalid input");
        }
        self.canDelete = NO;
        self.canShowPercent = YES;
    }
    else {
        [self buttonClick:self.arrFeature[indexPath.row]];
        self.isHaveMath = NO;
    }
}

#pragma mark - FLOWLAYOUT

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat widthItem = [UIScreen mainScreen].bounds.size.width / 4;
    CGFloat heightItem = collectionView.bounds.size.height / 5;
    return CGSizeMake(widthItem, heightItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return SPACING;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return SPACING;
}

#pragma mark - ACTION

- (BOOL)validInput {
    float count = 0;
    
    NSMutableArray *funcCharIndexes = [NSMutableArray array];
    
    NSString *workings = self.lbResult.text;
    
    for (int i = 0; i < workings.length; i++) {
        NSString *character = [workings substringWithRange:NSMakeRange(i, 1)];
        
        if ([self specialCharacter:character]) {
            [funcCharIndexes addObject:[NSNumber numberWithInt:count]];
        }
        
        count += 1;
    }
    
    float previous = -1;
    
    for (NSNumber *index in funcCharIndexes) {
        if (index.floatValue == 0) {
            return NO;
        }
        
        if (index.floatValue == workings.length - 1) {
            return NO;
        }
        
        if (previous != -1) {
            if (index.floatValue - previous == 1) {
                return NO;
            }
        }
        
        previous = index.floatValue;
    }
    
    return YES;
}

- (BOOL)specialCharacter:(NSString *)character {
    if ([character isEqualToString:@"*"] || [character isEqualToString:@"/"] || [character isEqualToString:@"+"] || [character isEqualToString:@"-"]) {
        return YES;
    }
    return NO;
}

-(void)buttonClick:(NSString *)nameButton {
    self.canDelete = YES;
    self.canUseDot = YES;
    self.lbResult.text = [NSString stringWithFormat:@"%@%@", self.lbResult.text, nameButton];
}

-(void)checkTheLastCharOfString {
    NSString *theLastChar = [self.lbResult.text substringFromIndex: [self.lbResult.text length] - 1];
    if ([theLastChar isEqualToString:@"+"] || [theLastChar isEqualToString:@"-"] || [theLastChar isEqualToString:@"*"] || [theLastChar isEqualToString:@"/"]) {
        self.isHaveMath = NO;
        self.canUseDot = NO;
    }
    else {
        self.isHaveMath = YES;
    }
}


@end
