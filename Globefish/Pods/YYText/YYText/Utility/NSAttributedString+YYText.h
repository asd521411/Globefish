#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#if __has_include(<YYText/YYText.h>)
#import <YYText/YYTextAttribute.h>
#import <YYText/YYTextRubyAnnotation.h>
#else
#import "YYTextAttribute.h"
#import "YYTextRubyAnnotation.h"
#endif
NS_ASSUME_NONNULL_BEGIN
@interface NSAttributedString (YYText)
- (nullable NSData *)yy_archiveToData;
+ (nullable instancetype)yy_unarchiveFromData:(NSData *)data;
#pragma mark - Retrieving character attribute information
@property (nullable, nonatomic, copy, readonly) NSDictionary<NSString *, id> *yy_attributes;
- (nullable NSDictionary<NSString *, id> *)yy_attributesAtIndex:(NSUInteger)index;
- (nullable id)yy_attribute:(NSString *)attributeName atIndex:(NSUInteger)index;
#pragma mark - Get character attribute as property
@property (nullable, nonatomic, strong, readonly) UIFont *yy_font;
- (nullable UIFont *)yy_fontAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSNumber *yy_kern;
- (nullable NSNumber *)yy_kernAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) UIColor *yy_color;
- (nullable UIColor *)yy_colorAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) UIColor *yy_backgroundColor;
- (nullable UIColor *)yy_backgroundColorAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSNumber *yy_strokeWidth;
- (nullable NSNumber *)yy_strokeWidthAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) UIColor *yy_strokeColor;
- (nullable UIColor *)yy_strokeColorAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSShadow *yy_shadow;
- (nullable NSShadow *)yy_shadowAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSUnderlineStyle yy_strikethroughStyle;
- (NSUnderlineStyle)yy_strikethroughStyleAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) UIColor *yy_strikethroughColor;
- (nullable UIColor *)yy_strikethroughColorAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSUnderlineStyle yy_underlineStyle;
- (NSUnderlineStyle)yy_underlineStyleAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) UIColor *yy_underlineColor;
- (nullable UIColor *)yy_underlineColorAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSNumber *yy_ligature;
- (nullable NSNumber *)yy_ligatureAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSString *yy_textEffect;
- (nullable NSString *)yy_textEffectAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSNumber *yy_obliqueness;
- (nullable NSNumber *)yy_obliquenessAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSNumber *yy_expansion;
- (nullable NSNumber *)yy_expansionAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSNumber *yy_baselineOffset;
- (nullable NSNumber *)yy_baselineOffsetAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) BOOL yy_verticalGlyphForm;
- (BOOL)yy_verticalGlyphFormAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSString *yy_language;
- (nullable NSString *)yy_languageAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSArray<NSNumber *> *yy_writingDirection;
- (nullable NSArray<NSNumber *> *)yy_writingDirectionAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) NSParagraphStyle *yy_paragraphStyle;
- (nullable NSParagraphStyle *)yy_paragraphStyleAtIndex:(NSUInteger)index;
#pragma mark - Get paragraph attribute as property
@property (nonatomic, readonly) NSTextAlignment yy_alignment;
- (NSTextAlignment)yy_alignmentAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSLineBreakMode yy_lineBreakMode;
- (NSLineBreakMode)yy_lineBreakModeAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_lineSpacing;
- (CGFloat)yy_lineSpacingAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_paragraphSpacing;
- (CGFloat)yy_paragraphSpacingAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_paragraphSpacingBefore;
- (CGFloat)yy_paragraphSpacingBeforeAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_firstLineHeadIndent;
- (CGFloat)yy_firstLineHeadIndentAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_headIndent;
- (CGFloat)yy_headIndentAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_tailIndent;
- (CGFloat)yy_tailIndentAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_minimumLineHeight;
- (CGFloat)yy_minimumLineHeightAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_maximumLineHeight;
- (CGFloat)yy_maximumLineHeightAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_lineHeightMultiple;
- (CGFloat)yy_lineHeightMultipleAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSWritingDirection yy_baseWritingDirection;
- (NSWritingDirection)yy_baseWritingDirectionAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) float yy_hyphenationFactor;
- (float)yy_hyphenationFactorAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGFloat yy_defaultTabInterval;
- (CGFloat)yy_defaultTabIntervalAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, copy, readonly) NSArray<NSTextTab *> *yy_tabStops;
- (nullable NSArray<NSTextTab *> *)yy_tabStopsAtIndex:(NSUInteger)index;
#pragma mark - Get YYText attribute as property
@property (nullable, nonatomic, strong, readonly) YYTextShadow *yy_textShadow;
- (nullable YYTextShadow *)yy_textShadowAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) YYTextShadow *yy_textInnerShadow;
- (nullable YYTextShadow *)yy_textInnerShadowAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) YYTextDecoration *yy_textUnderline;
- (nullable YYTextDecoration *)yy_textUnderlineAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) YYTextDecoration *yy_textStrikethrough;
- (nullable YYTextDecoration *)yy_textStrikethroughAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) YYTextBorder *yy_textBorder;
- (nullable YYTextBorder *)yy_textBorderAtIndex:(NSUInteger)index;
@property (nullable, nonatomic, strong, readonly) YYTextBorder *yy_textBackgroundBorder;
- (nullable YYTextBorder *)yy_textBackgroundBorderAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) CGAffineTransform yy_textGlyphTransform;
- (CGAffineTransform)yy_textGlyphTransformAtIndex:(NSUInteger)index;
#pragma mark - Query for YYText
- (nullable NSString *)yy_plainTextForRange:(NSRange)range;
#pragma mark - Create attachment string for YYText
+ (NSMutableAttributedString *)yy_attachmentStringWithContent:(nullable id)content
                                                  contentMode:(UIViewContentMode)contentMode
                                                        width:(CGFloat)width
                                                       ascent:(CGFloat)ascent
                                                      descent:(CGFloat)descent;
+ (NSMutableAttributedString *)yy_attachmentStringWithContent:(nullable id)content
                                                  contentMode:(UIViewContentMode)contentMode
                                               attachmentSize:(CGSize)attachmentSize
                                                  alignToFont:(UIFont *)font
                                                    alignment:(YYTextVerticalAlignment)alignment;
+ (nullable NSMutableAttributedString *)yy_attachmentStringWithEmojiImage:(UIImage *)image
                                                                 fontSize:(CGFloat)fontSize;
#pragma mark - Utility
- (NSRange)yy_rangeOfAll;
- (BOOL)yy_isSharedAttributesInAllRange;
- (BOOL)yy_canDrawWithUIKit;
@end
@interface NSMutableAttributedString (YYText)
#pragma mark - Set character attribute
- (void)yy_setAttributes:(nullable NSDictionary<NSString *, id> *)attributes;
- (void)setYy_attributes:(nullable NSDictionary<NSString *, id> *)attributes;
- (void)yy_setAttribute:(NSString *)name value:(nullable id)value;
- (void)yy_setAttribute:(NSString *)name value:(nullable id)value range:(NSRange)range;
- (void)yy_removeAttributesInRange:(NSRange)range;
#pragma mark - Set character attribute as property
@property (nullable, nonatomic, strong, readwrite) UIFont *yy_font;
- (void)yy_setFont:(nullable UIFont *)font range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) NSNumber *yy_kern;
- (void)yy_setKern:(nullable NSNumber *)kern range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) UIColor *yy_color;
- (void)yy_setColor:(nullable UIColor *)color range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) UIColor *yy_backgroundColor;
- (void)yy_setBackgroundColor:(nullable UIColor *)backgroundColor range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) NSNumber *yy_strokeWidth;
- (void)yy_setStrokeWidth:(nullable NSNumber *)strokeWidth range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) UIColor *yy_strokeColor;
- (void)yy_setStrokeColor:(nullable UIColor *)strokeColor range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) NSShadow *yy_shadow;
- (void)yy_setShadow:(nullable NSShadow *)shadow range:(NSRange)range;
@property (nonatomic, readwrite) NSUnderlineStyle yy_strikethroughStyle;
- (void)yy_setStrikethroughStyle:(NSUnderlineStyle)strikethroughStyle range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) UIColor *yy_strikethroughColor;
- (void)yy_setStrikethroughColor:(nullable UIColor *)strikethroughColor range:(NSRange)range NS_AVAILABLE_IOS(7_0);
@property (nonatomic, readwrite) NSUnderlineStyle yy_underlineStyle;
- (void)yy_setUnderlineStyle:(NSUnderlineStyle)underlineStyle range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) UIColor *yy_underlineColor;
- (void)yy_setUnderlineColor:(nullable UIColor *)underlineColor range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) NSNumber *yy_ligature;
- (void)yy_setLigature:(nullable NSNumber *)ligature range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) NSString *yy_textEffect;
- (void)yy_setTextEffect:(nullable NSString *)textEffect range:(NSRange)range NS_AVAILABLE_IOS(7_0);
@property (nullable, nonatomic, strong, readwrite) NSNumber *yy_obliqueness;
- (void)yy_setObliqueness:(nullable NSNumber *)obliqueness range:(NSRange)range NS_AVAILABLE_IOS(7_0);
@property (nullable, nonatomic, strong, readwrite) NSNumber *yy_expansion;
- (void)yy_setExpansion:(nullable NSNumber *)expansion range:(NSRange)range NS_AVAILABLE_IOS(7_0);
@property (nullable, nonatomic, strong, readwrite) NSNumber *yy_baselineOffset;
- (void)yy_setBaselineOffset:(nullable NSNumber *)baselineOffset range:(NSRange)range NS_AVAILABLE_IOS(7_0);
@property (nonatomic, readwrite) BOOL yy_verticalGlyphForm;
- (void)yy_setVerticalGlyphForm:(BOOL)verticalGlyphForm range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) NSString *yy_language;
- (void)yy_setLanguage:(nullable NSString *)language range:(NSRange)range NS_AVAILABLE_IOS(7_0);
@property (nullable, nonatomic, strong, readwrite) NSArray<NSNumber *> *yy_writingDirection;
- (void)yy_setWritingDirection:(nullable NSArray<NSNumber *> *)writingDirection range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) NSParagraphStyle *yy_paragraphStyle;
- (void)yy_setParagraphStyle:(nullable NSParagraphStyle *)paragraphStyle range:(NSRange)range;
#pragma mark - Set paragraph attribute as property
@property (nonatomic, readwrite) NSTextAlignment yy_alignment;
- (void)yy_setAlignment:(NSTextAlignment)alignment range:(NSRange)range;
@property (nonatomic, readwrite) NSLineBreakMode yy_lineBreakMode;
- (void)yy_setLineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_lineSpacing;
- (void)yy_setLineSpacing:(CGFloat)lineSpacing range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_paragraphSpacing;
- (void)yy_setParagraphSpacing:(CGFloat)paragraphSpacing range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_paragraphSpacingBefore;
- (void)yy_setParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_firstLineHeadIndent;
- (void)yy_setFirstLineHeadIndent:(CGFloat)firstLineHeadIndent range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_headIndent;
- (void)yy_setHeadIndent:(CGFloat)headIndent range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_tailIndent;
- (void)yy_setTailIndent:(CGFloat)tailIndent range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_minimumLineHeight;
- (void)yy_setMinimumLineHeight:(CGFloat)minimumLineHeight range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_maximumLineHeight;
- (void)yy_setMaximumLineHeight:(CGFloat)maximumLineHeight range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_lineHeightMultiple;
- (void)yy_setLineHeightMultiple:(CGFloat)lineHeightMultiple range:(NSRange)range;
@property (nonatomic, readwrite) NSWritingDirection yy_baseWritingDirection;
- (void)yy_setBaseWritingDirection:(NSWritingDirection)baseWritingDirection range:(NSRange)range;
@property (nonatomic, readwrite) float yy_hyphenationFactor;
- (void)yy_setHyphenationFactor:(float)hyphenationFactor range:(NSRange)range;
@property (nonatomic, readwrite) CGFloat yy_defaultTabInterval;
- (void)yy_setDefaultTabInterval:(CGFloat)defaultTabInterval range:(NSRange)range NS_AVAILABLE_IOS(7_0);
@property (nullable, nonatomic, copy, readwrite) NSArray<NSTextTab *> *yy_tabStops;
- (void)yy_setTabStops:(nullable NSArray<NSTextTab *> *)tabStops range:(NSRange)range NS_AVAILABLE_IOS(7_0);
#pragma mark - Set YYText attribute as property
@property (nullable, nonatomic, strong, readwrite) YYTextShadow *yy_textShadow;
- (void)yy_setTextShadow:(nullable YYTextShadow *)textShadow range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) YYTextShadow *yy_textInnerShadow;
- (void)yy_setTextInnerShadow:(nullable YYTextShadow *)textInnerShadow range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) YYTextDecoration *yy_textUnderline;
- (void)yy_setTextUnderline:(nullable YYTextDecoration *)textUnderline range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) YYTextDecoration *yy_textStrikethrough;
- (void)yy_setTextStrikethrough:(nullable YYTextDecoration *)textStrikethrough range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) YYTextBorder *yy_textBorder;
- (void)yy_setTextBorder:(nullable YYTextBorder *)textBorder range:(NSRange)range;
@property (nullable, nonatomic, strong, readwrite) YYTextBorder *yy_textBackgroundBorder;
- (void)yy_setTextBackgroundBorder:(nullable YYTextBorder *)textBackgroundBorder range:(NSRange)range;
@property (nonatomic, readwrite) CGAffineTransform yy_textGlyphTransform;
- (void)yy_setTextGlyphTransform:(CGAffineTransform)textGlyphTransform range:(NSRange)range;
#pragma mark - Set discontinuous attribute for range
- (void)yy_setSuperscript:(nullable NSNumber *)superscript range:(NSRange)range;
- (void)yy_setGlyphInfo:(nullable CTGlyphInfoRef)glyphInfo range:(NSRange)range;
- (void)yy_setCharacterShape:(nullable NSNumber *)characterShape range:(NSRange)range;
- (void)yy_setRunDelegate:(nullable CTRunDelegateRef)runDelegate range:(NSRange)range;
- (void)yy_setBaselineClass:(nullable CFStringRef)baselineClass range:(NSRange)range;
- (void)yy_setBaselineInfo:(nullable CFDictionaryRef)baselineInfo range:(NSRange)range;
- (void)yy_setBaselineReferenceInfo:(nullable CFDictionaryRef)referenceInfo range:(NSRange)range;
- (void)yy_setRubyAnnotation:(nullable CTRubyAnnotationRef)ruby range:(NSRange)range NS_AVAILABLE_IOS(8_0);
- (void)yy_setAttachment:(nullable NSTextAttachment *)attachment range:(NSRange)range NS_AVAILABLE_IOS(7_0);
- (void)yy_setLink:(nullable id)link range:(NSRange)range NS_AVAILABLE_IOS(7_0);
- (void)yy_setTextBackedString:(nullable YYTextBackedString *)textBackedString range:(NSRange)range;
- (void)yy_setTextBinding:(nullable YYTextBinding *)textBinding range:(NSRange)range;
- (void)yy_setTextAttachment:(nullable YYTextAttachment *)textAttachment range:(NSRange)range;
- (void)yy_setTextHighlight:(nullable YYTextHighlight *)textHighlight range:(NSRange)range;
- (void)yy_setTextBlockBorder:(nullable YYTextBorder *)textBlockBorder range:(NSRange)range;
- (void)yy_setTextRubyAnnotation:(nullable YYTextRubyAnnotation *)ruby range:(NSRange)range NS_AVAILABLE_IOS(8_0);
#pragma mark - Convenience methods for text highlight
- (void)yy_setTextHighlightRange:(NSRange)range
                           color:(nullable UIColor *)color
                 backgroundColor:(nullable UIColor *)backgroundColor
                        userInfo:(nullable NSDictionary *)userInfo
                       tapAction:(nullable YYTextAction)tapAction
                 longPressAction:(nullable YYTextAction)longPressAction;
- (void)yy_setTextHighlightRange:(NSRange)range
                           color:(nullable UIColor *)color
                 backgroundColor:(nullable UIColor *)backgroundColor
                       tapAction:(nullable YYTextAction)tapAction;
- (void)yy_setTextHighlightRange:(NSRange)range
                           color:(nullable UIColor *)color
                 backgroundColor:(nullable UIColor *)backgroundColor
                        userInfo:(nullable NSDictionary *)userInfo;
#pragma mark - Utilities
- (void)yy_insertString:(NSString *)string atIndex:(NSUInteger)location;
- (void)yy_appendString:(NSString *)string;
- (void)yy_setClearColorToJoinedEmoji;
- (void)yy_removeDiscontinuousAttributesInRange:(NSRange)range;
+ (NSArray<NSString *> *)yy_allDiscontinuousAttributeKeys;
@end
NS_ASSUME_NONNULL_END
