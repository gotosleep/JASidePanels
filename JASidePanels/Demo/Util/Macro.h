//
//  Macro.h
//  JASidePanels
//
//  Created by Calvin Sun on 13-4-17.
//
//

#ifndef JASidePanels_Macro_h
#define JASidePanels_Macro_h


#ifdef DEBUG

#define JAPrintBaseLog      NSLog(@"%s %@ [line %d]", __FUNCTION__, self, __LINE__)
#define JALog(format, ...)  NSLog(@"%s %@ [line %d]", __PRETTY_FUNCTION__, self, __LINE__, ##__VA_ARGS_)

#else

#define JAPrintBaseLog ;
#define JALog;

#endif


#endif
