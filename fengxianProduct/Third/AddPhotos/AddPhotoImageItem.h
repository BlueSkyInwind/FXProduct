
#import <UIKit/UIKit.h>
typedef enum{
    BJGridItemNormalMode = 0,
    BJGridItemEditingMode = 1,
}BJMode;
@protocol AddPhotoImageItemDelegate;
@interface AddPhotoImageItem : UIView{
    UIImage *normalImage;
    UIImage *editingImage;
    NSString *titleText;
    BOOL isEditing;
    BOOL isRemovable;
    UIButton *deleteButton;
    UIButton *button;
    NSInteger index;
    CGPoint point;//long press point
}
@property(nonatomic) BOOL isEditing;
@property(nonatomic) BOOL isRemovable;
@property(nonatomic) NSInteger index;
@property(weak,nonatomic)id<AddPhotoImageItemDelegate> delegate;
- (id) initWithButton:(NSString *)buttonImageName withImageName:(NSString *)imageName atIndex:(NSInteger)aIndex editable:(BOOL)removable isShowButtonImage:(BOOL)isShow;
- (void) enableEditing;
- (void) disableEditing;
@end
@protocol AddPhotoImageItemDelegate <NSObject>

- (void) gridItemDidClicked:(AddPhotoImageItem *) gridItem;
- (void) gridItemDidEnterEditingMode:(AddPhotoImageItem *) gridItem;
- (void) gridItemDidDeleted:(AddPhotoImageItem *) gridItem atIndex:(NSInteger)index;
- (void) gridItemDidMoved:(AddPhotoImageItem *) gridItem withLocation:(CGPoint)point moveGestureRecognizer:(UILongPressGestureRecognizer*)recognizer;
- (void) gridItemDidEndMoved:(AddPhotoImageItem *) gridItem withLocation:(CGPoint)point moveGestureRecognizer:(UILongPressGestureRecognizer*) recognizer;
@end