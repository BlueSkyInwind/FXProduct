


#import <Foundation/Foundation.h>

@interface ViewModelClass : NSObject

@property (nonatomic,strong) ReturnValueBlock returnBlock;
@property (nonatomic,strong) FaileBlock faileBlock;

- (void) setBlockWithReturnBlock:(ReturnValueBlock) returnBlock
                                WithFaileBlock: (FaileBlock) faileBlock;

@end
