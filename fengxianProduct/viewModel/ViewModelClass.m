



#import "ViewModelClass.h"

@implementation ViewModelClass


- (void) setBlockWithReturnBlock:(ReturnValueBlock)returnBlock WithFaileBlock:(FaileBlock)faileBlock
{
    _returnBlock = returnBlock;
    _faileBlock = faileBlock;
}

@end
