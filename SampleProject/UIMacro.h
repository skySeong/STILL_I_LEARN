//
//  UIMacro.h
//  SampleProject
//
//  Created by 60000737 on 2018. 8. 27..
//  Copyright © 2018년 sky. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

// UIColor RGB Macro
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a)[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// HEX Color Code
#define UIColorFromHEX(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0f green:((float)((value & 0xFF00) >> 8))/255.0f blue:((float)(value & 0xFF))/255.0f alpha:1.0f]

#endif /* UIMacro_h */
