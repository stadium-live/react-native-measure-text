#import "Mmkv.h"
#import "YeetJSIUtils.h"

#import <React/RCTBridge+Private.h>
#import <React/RCTUtils.h>
#import <jsi/jsi.h>
#import <React/RCTFont.h>

using namespace facebook;

@implementation Mmkv
@synthesize bridge = _bridge;
@synthesize methodQueue = _methodQueue;

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup {
    return YES;
}


static void install(jsi::Runtime & jsiRuntime)
{
    // MMKV.set(key: string, value: string | number | bool)
//    auto mmkvSet = jsi::Function::createFromHostFunction(jsiRuntime,
//                                                         jsi::PropNameID::forAscii(jsiRuntime, "mmkvSet"),
//                                                         2,  // key, value
//                                                         [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {
//        if (!arguments[0].isString()) throw jsi::JSError(runtime, "MMKV::set: First argument ('key') has to be of type string!");
//        auto keyName = convertJSIStringToNSString(runtime, arguments[0].getString(runtime));
//
//        if (arguments[1].isBool()) {
//            [MMKV.defaultMMKV setBool:arguments[1].getBool() forKey:keyName];
//        } else if (arguments[1].isNumber()) {
//            [MMKV.defaultMMKV setDouble:arguments[1].getNumber() forKey:keyName];
//        } else if (arguments[1].isString()) {
//            auto stringValue = convertJSIStringToNSString(runtime, arguments[1].getString(runtime));
//            [MMKV.defaultMMKV setString:stringValue forKey:keyName];
//        } else {
//            throw jsi::JSError(runtime, "MMKV::set: 'value' argument is not of type bool, number or string!");
//        }
//        return jsi::Value::undefined();
//    });
//    jsiRuntime.global().setProperty(jsiRuntime, "mmkvSet", std::move(mmkvSet));


    // MMKV.getBoolean(key: string)
//    auto mmkvGetBoolean = jsi::Function::createFromHostFunction(jsiRuntime,
//                                                                jsi::PropNameID::forAscii(jsiRuntime, "mmkvGetBoolean"),
//                                                                1,  // key
//                                                                [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {
//        if (!arguments[0].isString()) throw jsi::JSError(runtime, "First argument ('key') has to be of type string!");
//
//        auto keyName = convertJSIStringToNSString(runtime, arguments[0].getString(runtime));
//        auto value = [MMKV.defaultMMKV getBoolForKey:keyName];
//        return jsi::Value(value);
//    });
//    jsiRuntime.global().setProperty(jsiRuntime, "mmkvGetBoolean", std::move(mmkvGetBoolean));


    // MMKV.getString(key: string)
//    auto mmkvGetString = jsi::Function::createFromHostFunction(jsiRuntime,
//                                                               jsi::PropNameID::forAscii(jsiRuntime, "mmkvGetString"),
//                                                               1,  // key
//                                                               [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {
//        if (!arguments[0].isString()) throw jsi::JSError(runtime, "First argument ('key') has to be of type string!");
//
//        auto keyName = convertJSIStringToNSString(runtime, arguments[0].getString(runtime));
//        auto value = [MMKV.defaultMMKV getStringForKey:keyName];
//        if (value != nil)
//            return convertNSStringToJSIString(runtime, value);
//        else
//            return jsi::Value::undefined();
//    });
//    jsiRuntime.global().setProperty(jsiRuntime, "mmkvGetString", std::move(mmkvGetString));


    // MMKV.getNumber(key: string)
//    auto mmkvGetNumber = jsi::Function::createFromHostFunction(jsiRuntime,
//                                                               jsi::PropNameID::forAscii(jsiRuntime, "mmkvGetNumber"),
//                                                               1,  // key
//                                                               [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {
//        if (!arguments[0].isString()) throw jsi::JSError(runtime, "First argument ('key') has to be of type string!");
//
//        auto keyName = convertJSIStringToNSString(runtime, arguments[0].getString(runtime));
//        auto value = [MMKV.defaultMMKV getDoubleForKey:keyName];
//        return jsi::Value(value);
//    });
//    jsiRuntime.global().setProperty(jsiRuntime, "mmkvGetNumber", std::move(mmkvGetNumber));


    // MMKV.delete(key: string)
//    auto mmkvDelete = jsi::Function::createFromHostFunction(jsiRuntime,
//                                                            jsi::PropNameID::forAscii(jsiRuntime, "mmkvDelete"),
//                                                            1,  // key
//                                                            [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {
//        if (!arguments[0].isString()) throw jsi::JSError(runtime, "First argument ('key') has to be of type string!");
//
//        auto keyName = convertJSIStringToNSString(runtime, arguments[0].getString(runtime));
//        [MMKV.defaultMMKV removeValueForKey:keyName];
//        return jsi::Value::undefined();
//    });
//    jsiRuntime.global().setProperty(jsiRuntime, "mmkvDelete", std::move(mmkvDelete));

  auto measureText = jsi::Function::createFromHostFunction(jsiRuntime,
                                                          jsi::PropNameID::forAscii(jsiRuntime, "measureText"),
                                                          1,  // key
                                                          [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {
//      if (!arguments[0].isString()) throw jsi::JSError(runtime, "First argument ('key') has to be of type string!");
//    arguments[0].isObject()
   auto spec =  arguments[0].getObject(runtime);


    NSString * fontFamily = convertJSIStringToNSString(runtime, spec.getProperty(runtime, "fontFamily").asString(runtime));

    NSString *text = convertJSIStringToNSString(runtime, spec.getProperty(runtime, "text").asString(runtime));

    NSNumber * fontSize = [NSNumber numberWithDouble:spec.getProperty(runtime, "fontSize").getNumber()];

    auto font = [RCTFont updateFont:nil withFamily: fontFamily size: fontSize weight: nil style: nil variant: nil scaleMultiplier:1];

    CGFloat optWidth = spec.getProperty(runtime, "width").asNumber();
    CGSize maxSize = CGSizeMake(optWidth, CGFLOAT_MAX);

    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize: maxSize];
   textContainer.lineFragmentPadding = 0.0;
   textContainer.lineBreakMode = NSLineBreakByClipping; // no maxlines support

   NSLayoutManager *layoutManager = [NSLayoutManager new];
   [layoutManager addTextContainer:textContainer];
   layoutManager.allowsNonContiguousLayout = YES;      // 'cause lastLineWidth


    NSDictionary<NSAttributedStringKey,id> *const attributes = @{NSFontAttributeName: font};

   NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:text attributes:attributes];
   [textStorage addLayoutManager:layoutManager];

   [layoutManager ensureLayoutForTextContainer:textContainer];
   CGSize size = [layoutManager usedRectForTextContainer:textContainer].size;

    NSRange lineRange;
    NSUInteger glyphCount = layoutManager.numberOfGlyphs;
    NSInteger lineCount = 0;

    for (NSUInteger index = 0; index < glyphCount; lineCount++) {
      [layoutManager
       lineFragmentUsedRectForGlyphAtIndex:index effectiveRange:&lineRange withoutAdditionalLayout:YES];
      index = NSMaxRange(lineRange);
    }
    
    CGFloat width = MIN(RCTCeilPixelValue(size.width + 0.001), maxSize.width);
    
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys: @(width), @"width", @(lineCount), @"lineCount", nil];
    
    auto ret = convertNSDictionaryToJSIObject(runtime, result);

    return ret;

//    return convertNSNumberToJSINumber(runtime, [NSNumber numberWithInt:lineCount]);
  });

  jsiRuntime.global().setProperty(jsiRuntime, "measureText", std::move(measureText));


    // MMKV.getAllKeys()
//    auto mmkvGetAllKeys = jsi::Function::createFromHostFunction(jsiRuntime,
//                                                                jsi::PropNameID::forAscii(jsiRuntime, "mmkvGetAllKeys"),
//                                                                0,
//                                                                [](jsi::Runtime& runtime, const jsi::Value& thisValue, const jsi::Value* arguments, size_t count) -> jsi::Value {
//        auto keys = [MMKV.defaultMMKV allKeys];
//        return jsi::Value(convertNSArrayToJSIArray(runtime, keys));
//    });
//    jsiRuntime.global().setProperty(jsiRuntime, "mmkvGetAllKeys", std::move(mmkvGetAllKeys));
}

- (void)setBridge:(RCTBridge *)bridge
{
    _bridge = bridge;
    _setBridgeOnMainQueue = RCTIsMainQueue();

    RCTCxxBridge *cxxBridge = (RCTCxxBridge *)self.bridge;
    if (!cxxBridge.runtime) {
        return;
    }

    // [MMKV initializeMMKV:nil];
    install(*(jsi::Runtime *)cxxBridge.runtime);
}

- (void)invalidate {
    // [MMKV.defaultMMKV close];
}

@end
