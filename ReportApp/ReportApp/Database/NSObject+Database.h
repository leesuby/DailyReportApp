//
//  NSObject+Database.h
//  ReportApp
//
//  Created by LAP15335 on 27/09/2022.
//

#import <Foundation/Foundation.h>
#import "ReportApp-Swift.h"

@import FirebaseCore;
@import FirebaseFirestore;
@import FirebaseAuth;
@import FirebaseDatabase;



NS_ASSUME_NONNULL_BEGIN

@interface DatabaseFirebase : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;

- (void) saveReport;

- (void) readAllReport: (NSMutableArray*) reportList collectionView :(UICollectionView*) cv;

- (void) readDetailReport : (NSMutableArray*) reportDetailList collectionView :(UICollectionView*) cv dateofReport: (NSString*) date;
@end

NS_ASSUME_NONNULL_END
