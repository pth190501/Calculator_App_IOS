//
//  ViewController.h
//  CalculatorIOS
//
//  Created by Phạm Thanh Hải on 02/02/2023.
//

#import <UIKit/UIKit.h>
#import "ButtonCollectionViewCell.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbRAD;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *lbResult;

@end

