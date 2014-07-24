//
//  Macros.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#ifndef OWNTT_Macros_h
#define OWNTT_Macros_h

#pragma mark - Enum Factory Macros
#define ENUM_VALUE(name,assign) name assign,
#define ENUM_CASE(name,assign) case name: return @#name;
#define ENUM_STRCMP(name,assign) if ([string isEqualToString:@#name]) return name;
#define DECLARE_ENUM(EnumType,ENUM_DEF) \
typedef enum EnumType { \
ENUM_DEF(ENUM_VALUE) \
}EnumType; \
NSString *NSStringFrom##EnumType(EnumType value); \
EnumType EnumType##FromNSString(NSString *string); \

#define DEFINE_ENUM(EnumType, ENUM_DEF) \
NSString *NSStringFrom##EnumType(EnumType value) \
{ \
switch(value) \
{ \
ENUM_DEF(ENUM_CASE) \
default: return @""; \
} \
} \
EnumType EnumType##FromNSString(NSString *string) \
{ \
ENUM_DEF(ENUM_STRCMP) \
return (EnumType)0; \
} 

#endif
