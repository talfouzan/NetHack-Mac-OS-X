//
//  SwiftNetHack bridge.swift
//  NetHack3D
//
//  Created by C.W. Betts on 8/8/15.
//
//

import Foundation


//#define GLYPH_MON_OFF		0

@available(*, unavailable, renamed: "NetHackGlyphPetOffset")
var GLYPH_PET_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphInvisibleOffset")
var GLYPH_INVIS_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphDetectOffset")
var GLYPH_DETECT_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphBodyOffset")
var GLYPH_BODY_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphRiddenOffset")
var GLYPH_RIDDEN_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphObjectOffset")
var GLYPH_OBJ_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphCMapOffset")
var GLYPH_CMAP_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphExplodeOffset")
var GLYPH_EXPLODE_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphZapOffset")
var GLYPH_ZAP_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphSwallowOffset")
var GLYPH_SWALLOW_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphWarningOffset")
var GLYPH_WARNING_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphStatueOffset")
var GLYPH_STATUE_OFF: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphMaxGlyph")
var MAX_GLYPH: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphNoGlyph")
var NO_GLYPH: Int32 {
	fatalError()
}
@available(*, unavailable, renamed: "NetHackGlyphInvisible")
var GLYPH_INVISIBLE: Int32 {
	fatalError()
}

//MARK: for font
/*
var NH3DMSGFONT: String! {
	return NSUserDefaults.standardUserDefaults().stringForKey(NH3DMsgFontKey)
}

var NH3DWINDOWFONT: String! {
	return NSUserDefaults.standardUserDefaults().stringForKey(NH3DWindowFontKey)
}
var NH3DMAPFONT: String! {
	return NSUserDefaults.standardUserDefaults().stringForKey(NH3DMapFontKey)
}
var NH3DBOLDFONT: String! {
	return NSUserDefaults.standardUserDefaults().stringForKey(NH3DBoldFontKey)
}
var NH3DINVFONT: String! {
	return NSUserDefaults.standardUserDefaults().stringForKey(NH3DInventryFontKey)
}

var NH3DMSGFONTSIZE: CGFloat {
	return CGFloat(NSUserDefaults.standardUserDefaults().floatForKey(NH3DMsgFontSizeKey))
}

var NH3DWINDOWFONTSIZE: CGFloat {
	return CGFloat(NSUserDefaults.standardUserDefaults().floatForKey(NH3DWindowFontSizeKey))
}
var NH3DMAPFONTSIZE: CGFloat {
	return CGFloat(NSUserDefaults.standardUserDefaults().floatForKey(NH3DMapFontSizeKey))
}
var NH3DBOLDFONTSIZE: CGFloat {
	return CGFloat(NSUserDefaults.standardUserDefaults().floatForKey(NH3DBoldFontSizeKey))
}
var NH3DINVFONTSIZE: CGFloat {
	return CGFloat(NSUserDefaults.standardUserDefaults().floatForKey(NH3DInventryFontSizeKey))
}

var TRADITIONAL_MAP: Bool {
	return NSUserDefaults.standardUserDefaults().boolForKey(NH3DUseTraditionalMapKey)
}

var TRADITIONAL_MAP_TILE: Bool {
	return NSUserDefaults.standardUserDefaults().boolForKey(NH3DTraditionalMapModeKey)
}

var TILE_FILE_NAME: String! {
	return NSUserDefaults.standardUserDefaults().stringForKey(NH3DTileNameKey)
}

var TILES_PER_LINE: Int {
	return NSUserDefaults.standardUserDefaults().integerForKey(NH3DTilesPerLineKey)
}
var NUMBER_OF_TILES_ROW: Int {
	return NSUserDefaults.standardUserDefaults().integerForKey(NH3DNumberOfTilesRowKey)
}
*/

var HSee_invisible: Int {
	return u.uprops.12.intrinsic
}

var ESee_invisible: Int {
	return u.uprops.12.extrinsic
}

private func perceives(_ ptr: UnsafePointer<permonst>) -> Bool {
	return (ptr.pointee.mflags1 & UInt(M1_SEE_INVIS)) != 0
}

var See_invisible: Bool {
	return (HSee_invisible != 0 || ESee_invisible != 0 ||
		perceives(youmonst.data))
}

// MARK: Appearance and behavior
var Adornment: Int {
	return u.uprops.9.extrinsic
}

var HInvis: Int {
	return u.uprops.13.intrinsic
}

var EInvis: Int {
	return u.uprops.13.extrinsic
}

var BInvis: Int {
	return u.uprops.13.blocked
}

var Invisible: Bool {
	return (Swift_Invis() && !See_invisible)
}
