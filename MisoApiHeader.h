//
//  MisoApiHeader.h
//  MisoVirtualInstruments
//
//  Created by HEENA RASTOGI on 6/11/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#if _PushToApple_

// ----------- Production Server
#define miso_current_server @"Production Server"
#define miso_api_url @"https://music.misomedia.com/api"
#define miso_device_login_api_url @"https://music.misomedia.com/api/account/login.json?api_key=%@&version=%@"

#else

// ----------- Dev server
#define miso_current_server @"Dev Server"
#define miso_api_url @"http://dev.misomedia.com/api"
#define miso_device_login_api_url @"http://dev.misomedia.com/api/account/login.json?api_key=%@&version=%@"

#endif

// ----------- Staging server

//#define miso_current_server @"Staging Server"
//#define miso_api_url @"http://staging.misomedia.com/api"
//#define miso_device_login_api_url @"http://staging.misomedia.com/api/account/login.json?api_key=%@&version=%@"
