//
//  ButtonCollectionViewCell.h
//  CalculatorIOS
//
//  Created by Phạm Thanh Hải on 02/02/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ButtonCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbFeature;
-(void)configCellWith:(NSMutableArray *)arrFeature ;
@end

NS_ASSUME_NONNULL_END
