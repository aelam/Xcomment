 //
 //  TextStorageTerminal.h
 //  Crescat
 //
 //  Created by Fritz Anderson on Mon Aug 25 2003.
 //  Copyright (c) 2003 Trustees of the University of Chicago. All rights reserved.
 //
 
 #import <Cocoa/Cocoa.h>
 
 typedef enum {
     tcRegularFore = -2,
     tcRegularBack,
     
     tcBlack,    
     tcRed,      
     tcGreen,    
     tcYellow,   
     tcBlue,     
     tcMagenta,  
     tcCyan,     
     tcWhite     
 }   TerminalColor;
 
 extern NSString * const TSTBlinkingAttribute;
 extern NSString * const TSTInvisibleAttribute;
 extern NSString * const TSTBoldAttribute;
 extern NSString * const TSTEmailAttribute;
 extern NSString * const TSTAlternateAttribute;
 extern NSString * const TSTSpellingAttribute;
 extern NSString * const TSTProperNameAttribute;
 
 extern NSString * const TSScreenContentChangedNotification;
 extern NSString * const TSScreenAttrsChangedNotification;
 extern NSString * const TSScreenCursorNotification;
 extern NSString * const TSScreenScrolledNotification;
 
 
 @interface TextStorageTerminal : NSObject
 {
     NSTextStorage *         content;
     
     int                     rows;
     int                     columns;
     int                     cursorRow;
     int                     cursorColumn;
     BOOL                    cursorVisible;
     
     BOOL                    invertMode;
     
     BOOL                    insertMode;
     BOOL                    wrapMode;
     BOOL                    deferredCursorWrap;
     
     BOOL                    eatsNewlines;
     BOOL                    justWrapped;
     
     int                     scrollTop;
     int                     scrollBottom;
     
     int                     savedCursorRow;
     int                     savedCursorColumn;
     
     unichar                 lastCharacter;
     NSMutableDictionary *   attrDictionary;
     BOOL *                  tabStops;
     BOOL                    defaultTabStops;
     
     NSFont *                defaultFont;
     NSColor *               defaultForeColor;
     NSColor *               defaultBackColor;
     NSMutableDictionary *   plainAttributes;
     
     NSMutableString *       printScreenBuffer;
     NSMutableString *       printLineBuffer;
     NSTimer *               printLineTimer;
     
     NSTimer *               spellingTimer;
     int                     spellingTag;
     
     id                      delegate;
 }
 
 + (NSColor *) colorForCode: (TerminalColor) code;
 + (NSFont *) defaultFont;
 
 - (id) init;
 - (id) initWithRows: (int) nRows columns: (int) nColumns;
 
 - (NSTextStorage *) textStorage;
 - (void) setAttributedString: (NSAttributedString *) string;
 - (NSDictionary *) currentAttributes;
 - (NSDictionary *) plainAttributes;
 
 - (NSFont *) defaultFont;
 - (void) setDefaultFont: (NSFont *) aFont;
 - (NSColor *) defaultForeColor;
 - (void) setDefaultForeColor: (NSColor *) aColor;
 - (NSColor *) defaultBackColor;
 - (void) setDefaultBackColor: (NSColor *) aColor;
 
 - (void) resizeToRows: (int) nRows columns: (int) nColumns;
 
 - (id) delegate;
 - (void) setDelegate: (id) theDelegate;
 
 - (void) resetCurrentAttributes;
 - (void) resetTabs;
 - (void) clearOneTabStop;
 - (void) clearTabStops;
 - (void) setTabStop;
 - (void) horizontalTab;
 - (void) backTab;
 - (void) hardwareTab;
 
 - (int) rows;
 - (int) columns;
 
 - (void) acceptCharacter: (unichar) aChar;
 - (void) acceptASCII: (const void *) chars length: (int) length;
 
 - (void) repeatLastCharacter: (int) howMany;
 
 - (void) scrollLines: (int) positiveForUp;
 - (void) scrollUp;
 - (void) scrollDown;
 
 - (BOOL) insertMode;
 - (void) setInsertMode: (BOOL) newMode;
 - (BOOL) wrapMode;
 - (void) setWrapMode: (BOOL) newMode;
 - (BOOL) eatsNewlines;
 - (void) setEatsNewlines: (BOOL) value;
 
 - (void) scrollAreaTop: (int *) top bottom: (int *) bottom;
 - (void) setScrollAreaTop: (int) top bottom: (int) bottom;
 - (void) unsetScrollArea;
 
 - (void) cursorLocationX: (int *) cursorX Y: (int *) cursorY;
 - (void) setCursorLocationX: (int) cursorX Y: (int) cursorY;
 - (void) moveToRow: (int) cursorToRow column: (int) cursorToColumn;
 - (void) cursorToLine: (int) line;
 - (void) cursorToColumn: (int) column;
 - (int) characterOffsetOfCursor;
 - (void) setCursorVisible: (BOOL) visibility;
 - (BOOL) isCursorVisible;
 
 - (void) cursorUp: (int) howMany;
 - (void) cursorUp;
 - (void) cursorDown: (int) howMany;
 - (void) cursorDown;
 - (void) cursorLeft: (int) howMany;
 - (void) cursorLeft;
 - (void) cursorRight: (int) howMany;
 - (void) cursorRight;
 
 - (void) reverseIndex: (int) howMany;
 
 - (void) carriageReturn;
 - (void) lineFeed;
 
 - (void) saveCursorPosition;
 - (void) restoreCursorPosition;
 
 - (void) homeCursor;
 
 - (void) eraseScreen;
 - (void) eraseToEndOfScreen;
 - (void) eraseToStartOfScreen;
 - (void) eraseScrollArea;
 - (void) eraseToEndOfLine;
 - (void) eraseToStartOfLine;
 - (void) eraseLine;
 - (void) eraseCharacters: (int) howMany;
 - (void) eraseCharacter;
 
 - (void) insertLines: (int) howMany;
 - (void) insertLine;
 - (void) deleteLines: (int) howMany;
 - (void) deleteLine;
 
 - (void) insertCharacters: (int) howMany;
 - (void) deleteCharacters: (int) howMany;
 - (void) deleteCharacter;
 
 - (void) startBold;
 - (void) startUnderline;
 - (void) startBlink;
 - (void) startInverse;
 - (void) startInvisible;
 - (void) startAlternate;
 - (void) endBold;
 - (void) endUnderline;
 - (void) endBlink;
 - (void) endInverse;
 - (void) endInvisible;
 - (void) endAlternate;
 - (void) setForeground: (TerminalColor) color;
 - (void) setBackground: (TerminalColor) color;
 - (void) setPlainForeground;
 - (void) setPlainBackground;
 
 - (unichar) characterAtRow: (int) row column: (int) column;
 
 - (void) reportDeviceCode;
 - (void) reportDeviceStatus;
 - (void) reportCursorPosition;
 
 - (void) soundBell;
 - (void) invertScreen: (BOOL) inverted;
 
 - (void) enableAlternateCharacters;
 
 - (void) resetAll: (BOOL) hard;
 
 - (void) printScreen;
 - (void) startPrintLog;
 - (void) endPrintLog;
 - (void) printLine;
 
 - (void) checkSpelling: (BOOL) doCheck;
 - (BOOL) isCheckingSpelling;
 @end
 
 @interface NSObject (TerminalScreenDelegate)
 
 - (void) terminalScreen: (TextStorageTerminal *) screen sendsReportData: (NSData *) report;
 - (void) terminalScreenPrintsScreen: (TextStorageTerminal *) screen;
 - (void) terminalScreen: (TextStorageTerminal *) screen printsBuffer: (NSString *) aBuffer;
 - (void) terminalScreen: (TextStorageTerminal *) screen scrollsOffText: (NSAttributedString *) someText;
 
 @end
 
