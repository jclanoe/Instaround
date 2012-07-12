//
//  Config.h
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#ifndef Flick_Around_Config_h
#define Flick_Around_Config_h

#define FLICKR_API_KEY @"3c84e2e4edaa0c3ff8f8e2c3a9e170f6"

#define INSTAGRAM_CLIENT_ID @"a7d990b451ea46b98fd799d226ea451c"
#define INSTAGRAM_CLIENT_SECRET @"ff6ce2d025434c88ab8034e3c851696a"
#define INSTAGRAM_REDIRECT_URI @"instaround://"
#define INSTAGRAM_REDIRECT_URI_PREFIX @"instaround"

#define FORMAT @"json"

#define INSTAGRAM_SERVER_ROOT_URL @"https://api.instagram.com/"
// ?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=code
#define INSTAGRAM_AUTH @"oauth/authorize/"
#define INSTAGRAM_ACCESS @"oauth/access_token"
#define INSTAGRAM_SEARCH_LOCATION @"v1/media/search"

#define FLICKR_SERVER_ROOT_URL @"http://api.flickr.com/services/rest/"

#define API_FIND_PLACE_BY_LOCATION @"flickr.places.findByLatLon"
#define API_SEARCH @"flickr.photos.search"
#define API_GET_LOCATION @"flickr.photos.geo.getLocation"

#define SQLITE_FILE @"FlickAround.sqlite"

#define LATITUDE_DEGREE_DELTA_VALUE 111.2
#define MAX_DISTANCE_DELTA_ALLOWED 36.0

#endif
