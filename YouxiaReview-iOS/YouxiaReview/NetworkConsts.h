//
//  NetworkConsts.h
//  MeiYuan-iOS
//
//  Created by kino on 15/9/7.
//
//

#ifndef MeiYuan_iOS_NetworkConsts_h
#define MeiYuan_iOS_NetworkConsts_h

#define KODefineAPI(Name,Path)\
static NSString * const (Name) = (Path);

typedef enum {
    APIMethodGet = 0,
    APIMethodPost ,
    APIMethodPut,
    APIMethodDelete
}APIMethod;


KODefineAPI(BASE_API_URL, @"http://localhost:3000/api")
KODefineAPI(TEST_BASE_API_URL,  @"http://localhost:3000/api")


/**
 *  Art List API
 */
KODefineAPI(API_ReviewList, @"v1/reviews")


/**
 *  User API
 */


#endif
