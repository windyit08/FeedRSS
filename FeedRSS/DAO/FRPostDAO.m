//
//  FRPostDAO.m
//  FeedRSS
//
//  Created by  TuanNKA on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRPostDAO.h"
#import "FRPost.h"

@implementation FRPostDAO: NSObject

+ (instancetype)sharedInstance {
    static FRPostDAO *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FRPostDAO alloc] init];
    });
    return _instance;
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (BOOL) addFavoritePost:(NSDictionary *)post {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *postRss = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [postRss setValuesForKeysWithDictionary:post];
    [postRss setValue:[NSDate date] forKey:@"date"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Insert! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}

- (BOOL) addFavoritePost:(NSString *)guid withTile:(NSString *)title withText:(NSString *)text withThumb:(NSString *)thumb {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *post = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post setValue:guid forKey:@"guid"];
    [post setValue:title forKey:@"title"];
    [post setValue:text forKey:@"text"];
    [post setValue:[NSDate date] forKey:@"date"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Insert! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}

- (BOOL) removeFavorite:(FRPost *)post {
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:post];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}

- (NSMutableArray*) listAllFavorite {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FRPost" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    return [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
}
- (void) populateWithDummies {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *post1 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post1 setValue:@"http://sohoa.vnexpress.net/tin-tuc/doi-song-so/apple-bi-chi-trich-vi-ban-iphone-6s-16-gb-3281230.html" forKey:@"guid"];
    [post1 setValue:@"Apple bị chỉ trích vì bán iPhone 6s 16 GB" forKey:@"title"];
    [post1 setValue:@"Một trong những điểm người dùng không hài lòng nhất trên iPhone mới là bộ nhớ thấp nhất 16 GB thay vì 32 GB." forKey:@"text"];
    [post1 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/18/iPhone-2-2281-1442546692_180x108.jpg" forKey:@"thumb"];
    [post1 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post2 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post2 setValue:@"http://sohoa.vnexpress.net/tin-tuc/san-pham/khac/nguoi-dung-it-hao-hung-voi-ios-9-hon-so-voi-ios-7-3281159.html" forKey:@"guid"];
    [post2 setValue:@"Người dùng ít hào hứng với iOS 9 hơn so với iOS 7" forKey:@"title"];
    [post2 setValue:@"iOS 9 được tải và cài đặt trên khoảng 15% thiết bị chạy iOS của Apple sau hơn một ngày trong khi cùng thời điểm này năm 2013, iOS 7 đã chiếm tới gần 30%." forKey:@"text"];
    [post2 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/18/ios09-1442540299_180x108.jpg" forKey:@"thumb"];
    [post2 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post3 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post3 setValue:@"http://sohoa.vnexpress.net/tin-tuc/san-pham/dien-thoai/iphone-6s-chi-hoat-dong-tot-voi-mieng-dan-man-hinh-sieu-mong-3281101.html" forKey:@"guid"];
    [post3 setValue:@"iPhone 6s chỉ hoạt động tốt với miếng dán màn hình siêu mỏng" forKey:@"title"];
    [post3 setValue:@"Tấm bảo vệ đạt chuẩn, mỏng dưới 0,3 mm mới không gây ảnh hưởng đến tính năng 3D Touch trên của bộ đôi iPhone mới." forKey:@"text"];
    [post3 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/18/appleevent-2015-46-14423824620-3265-8264-1442534928_180x108.jpg" forKey:@"thumb"];
    [post3 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post4 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post4 setValue:@"http://sohoa.vnexpress.net/tin-tuc/san-pham/dien-thoai/lg-sap-smartphone-android-vo-kim-loai-gia-tam-trung-3281202.html" forKey:@"guid"];
    [post4 setValue:@"LG sắp smartphone Android vỏ kim loại, giá tầm trung" forKey:@"title"];
    [post4 setValue:@"Mẫu smartphone mới có tên LG Class nằm trong tầm giá 6 đến 8 triệu đồng và dự kiến sẽ trình làng ngày 21/9." forKey:@"text"];
    [post4 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/18/LG-Class-jpg-6151-1442543131_180x108.png" forKey:@"thumb"];
    [post4 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post5 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post5 setValue:@"http://sohoa.vnexpress.net/tin-tuc/doi-song-so/nhan-qua-toi-4-trieu-dong-khi-mua-smartphone-lg-3281005.html" forKey:@"guid"];
    [post5 setValue:@"Nhận quà tới 4 triệu đồng khi mua smartphone LG" forKey:@"title"];
    [post5 setValue:@"Từ 15/9 đến 20/10, khi mua một số dòng sản phẩm smartphone của LG, người dùng sẽ được tặng những phần quà có giá trị đến 4 triệu đồng." forKey:@"text"];
    [post5 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/18/17-9-201552-902235979-3882-1442544125_180x108.jpeg" forKey:@"thumb"];
    [post5 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post6 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post6 setValue:@"http://sohoa.vnexpress.net/tin-tuc/doi-song-so/dich-vu-ma-iphone-6-thanh-6s-hong-vang-cua-viet-nam-len-bao-my-3281347.html" forKey:@"guid"];
    [post6 setValue:@"Dịch vụ mạ iPhone 6 thành 6s hồng vàng của Việt Nam lên báo Mỹ" forKey:@"title"];
    [post6 setValue:@"Phải đến 25/9, iPhone 6s mới được bán ra thị trường nhưng ở Việt Nam đã xuất hiện dịch vụ \"hô biến\" iPhone 6 sang iPhone 6s Rose Gold." forKey:@"text"];
    [post6 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/18/iPhone-3-9292-1442550681_180x108.jpg" forKey:@"thumb"];
    [post6 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post7 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post7 setValue:@"http://sohoa.vnexpress.net/photo/thi-truong/trien-lam-hanh-trinh-26-nam-cua-asus-3281394.html" forKey:@"guid"];
    [post7 setValue:@"Triển lãm hành trình 26 năm của Asus" forKey:@"title"];
    [post7 setValue:@"Hãng điện tử Đài Loan đang tổ chức Asus Expo, triển lãm các thiết bị công nghệ của mình từ smartphone, thiết bị di động, PC từ lúc thành lập đến thế hệ mới nhất... tại TP HCM." forKey:@"text"];
    [post7 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/18/MG-5513-1442553891_180x108.jpg" forKey:@"thumb"];
    [post7 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post8 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post8 setValue:@"http://sohoa.vnexpress.net/tin-tuc/cong-dong/hoi-dap/unlock-galaxy-note-5-tu-my-3281355.html" forKey:@"guid"];
    [post8 setValue:@"Unlock Galaxy Note 5 từ Mỹ" forKey:@"title"];
    [post8 setValue:@"Điện thoại này dùng mạng T-Mobile của Mỹ về Việt Nam thì có unlock được không?" forKey:@"text"];
    [post8 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/18/Samsung-Galaxy-Note-5-2794-1442551223_180x108.png" forKey:@"thumb"];
    [post8 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post9 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post9 setValue:@"http://sohoa.vnexpress.net/tin-tuc/san-pham/acer-aspire-e5-573-cho-hoc-sinh-sinh-vien-3280578.html" forKey:@"guid"];
    [post9 setValue:@"Acer Aspire E5-573 cho học sinh, sinh viên" forKey:@"title"];
    [post9 setValue:@"Sản phẩm hướng tới người dùng là học sinh, sinh viên với nhiều tính năng cải tiến và thiết kế độc đáo, thể hiện cá tính, phong cách của người dùng." forKey:@"text"];
    [post9 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/17/16-9-201522-5517-1442477252_180x108.jpeg" forKey:@"thumb"];
    [post9 setValue:[NSDate date] forKey:@"date"];
    
    NSManagedObject *post10 = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post10 setValue:@"http://sohoa.vnexpress.net/photo/dien-thoai/smartphone-kiem-sac-du-phong-3281058.html" forKey:@"guid"];
    [post10 setValue:@"Smartphone kiêm sạc dự phòng" forKey:@"title"];
    [post10 setValue:@"Lai Yollo, smartphone phổ thông mới nhất của Mobiistar, có cấu hình khá cùng tính năng như một viên pin dự phòng với giá bán 2,79 triệu đồng." forKey:@"text"];
    [post10 setValue:@"http://c1.f5.img.vnecdn.net/2015/09/17/MG-5416-1442496805_180x108.jpg" forKey:@"thumb"];
    [post10 setValue:[NSDate date] forKey:@"date"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}
@end
