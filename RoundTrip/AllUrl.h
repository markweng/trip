//
//  AllUrl.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#ifndef AllUrl_h
#define AllUrl_h
#define HomeUrl @"http://api.breadtrip.com/v2/index/"
#define STORYURL @"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=%ld"
#define STORYDETIALURL @"http://api.breadtrip.com/v2/new_trip/spot/?spot_id=%@"
#define TRAVELNOTEURL @"http://api.breadtrip.com/trips/%@/waypoints/?gallery_mode=1"
#define ISMOREURL @"http://api.breadtrip.com/v2/index/?next_start=%@"
#define SEARCHURL @"http://api.breadtrip.com/v2/search/?key=%@&start=0&count=20&data_type="
#define MORETAIPSURL @"http://api.breadtrip.com/v2/search/?count=20&data_type=trip&key=%@&start="
#define PLAYCEURL @"http://api.breadtrip.com/destination/index_places/%d/"
//include city place sights
#define ALLPLACESURL @"http://api.breadtrip.com/destination/place%@"
#define WANTPLACEURL @"http://api.breadtrip.com/destination/v3/?last_modified_since=0"

#define PICTURL @"http://api.breadtrip.com/destination/place%@photos/?start=%lu&count=21&gallery_mode=true"

#define APP_WALL_PAPER @"https://coding.net/api/wallpaper/wallpapers?"

#define UMENG_SHAREKEY @"56924dac67e58eb28e00057d"

#define mainScreenW ([UIScreen mainScreen].bounds.size.width)
#define mainScreenH ([UIScreen mainScreen].bounds.size.height)
#endif /* AllUrl_h */
