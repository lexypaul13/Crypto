//
//  Color.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import SwiftUI

struct Colors {
    ///
    /// Color       LightMode       DarkMode
    /// Brown       #F4B93F         #FFC857
    /// Blue        #2E305F         #25264C
    /// Red         #EA3943         #EA3943
    /// Green       #76E268         #76E268
    /// LightBlue   #6D6E8F         #B5B4BD
    /// DarkBlue       -            #0F1020
    ///
    /// Color naming breakdown
    /// first color name -> light mode color
    /// second color name -> dark mode color
    /// numeric value after color name indicated opacity/alpha of the color preceding it
    /// eg. brown8DarkBlue85 is
    ///         Light Mode - brown color with 8% opacity
    ///         Dark Mode -  dark blue with 85% opacity
    static let brown                = Color("brown")
    static let brownWhite           = Color("brownWhite")
    static let brownBrown20         = Color("brownBrown20")
    static let brown0Brown          = Color("brown0Brown")
    static let brown0White          = Color("brown0White")
    static let brown8Brown5         = Color("brown8Brown5")
    static let brown8DarkBlue       = Color("brown8DarkBlue")
    static let brown8DarkBlue70     = Color("brown8DarkBlue70")
    static let brown8DarkBlue85     = Color("brown8DarkBlue85")
    static let brown8LightBrown     = Color("brown8LightBrown")
    static let brown20Brown5        = Color("brown20Brown5")
    static let brown25Blue          = Color("brown25Blue")
    static let brown25Blue70        = Color("brown25Blue70")
    static let lightBlue            = Color("lightBlue")
    static let blue                 = Color("blue")
    static let blueBrown            = Color("blueBrown")
    static let blueWhite            = Color("blueWhite")
    static let blue70White          = Color("blue70White")
    static let blue70White70        = Color("blue70White70")
    static let pureWhiteDarkBlue70  = Color("pureWhiteDarkBlue70")
    static let pureBlack            = Color("pureBlack")
    static let whiteDarkBlue        = Color("whiteDarkBlue")
    static let red                  = Color("red")
    static let green                = Color("green")
}
