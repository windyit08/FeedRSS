//
//  FRPostDAO.m
//  FeedRSS
//
//  Created by  TuanNKA on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRPostDAO.h"
#import "FRPost.h"
#import "FRNewsObject.h"

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

- (BOOL) addFavoritePost:(FRNewsObject *) news {
    NSLog(@"Run %s", __PRETTY_FUNCTION__);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale currentLocale]];
    [dateFormat setDateFormat:@"EEE, d MMM yyyy HH:mm:ss ZZZ"];
//    NSLog(@"%@", [dateFormat stringFromDate:[NSDate date]]);
    NSLog(@"Add new FRNewsObject with:");
    NSLog(@"Title: %@", news.title);
    NSLog(@"Link: %@", news.guid);
    NSLog(@"Text: %@", news.description);
    NSLog(@"Img: %@", news.urlImage);
    NSLog(@"Date: %@", [dateFormat dateFromString:news.pubDate]);
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *post = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post setValue:news.guid forKey:@"guid"];
    [post setValue:news.title forKey:@"title"];
    [post setValue:news.description forKey:@"text"];
    [post setValue:news.urlImage forKey:@"thumb"];
    [post setValue:[dateFormat dateFromString:news.pubDate] forKey:@"date"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Insert! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}

- (BOOL) addFavoritePost:(NSString *)guid withTile:(NSString *)title withText:(NSString *)text withThumb:(NSString *)thumb withDate:(NSString *)date {
    NSLog(@"Run %s", __PRETTY_FUNCTION__);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale currentLocale]];
    [dateFormat setDateFormat:@"EEE, d MMM yyyy HH:mm:ss ZZZ"];
    NSLog(@"Add new FRNewsObject with:");
    NSLog(@"Title: %@", title);
    NSLog(@"Link: %@", guid);
    NSLog(@"Text: %@", text);
    NSLog(@"Img: %@", thumb);
    NSLog(@"Date: %@", date);
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *post = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post setValue:guid forKey:@"guid"];
    [post setValue:title forKey:@"title"];
    [post setValue:text forKey:@"text"];
    [post setValue:thumb forKey:@"thumb"];
    [post setValue:[dateFormat dateFromString:date] forKey:@"date"];
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

- (BOOL) removeFavoriteNews:(FRNewsObject *)news {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FRPost" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", news.guid];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray* results = [context executeFetchRequest:fetchRequest error:&error];
    if(results.count == 1) {
        [context deleteObject:[results objectAtIndex:0]];
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return NO;
        }
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

- (NSMutableArray*) listAllGuiOfFavorite {
    NSMutableArray* list = [self listAllFavorite];
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    
    for(FRPost* item in list){

        [ret addObject:item.guid];
    }
    return ret;
    
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
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}
@end
