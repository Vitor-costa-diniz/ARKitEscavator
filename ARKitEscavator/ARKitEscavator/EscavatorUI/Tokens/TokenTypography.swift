//
//  TokenTypography.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI
struct TokenTypography {

    fileprivate enum FontSize: CGFloat {
        case small = 12
        case medium = 20
        case large = 24
        case extraLarge = 28
        case extraExtraExtraLarge = 55
    }

    fileprivate enum FontType: String {
        case regular = "LoveYaLikeASister-Regular"
        case boldManjari = "Manjari-Bold"
    }
}

enum TypographyCase {
    /// Font: LoveYaLikeASister-Regular; Size: 24
    case body1Regular
    /// Font: LoveYaLikeASister-Regular; Size: 20
    case body2Regular
    /// Font: LoveYaLikeASister-Regular; Size: 28
    case body3Regular
    /// Font: LoveYaLikeASister-Regular; Size: 55
    case body4Regular
    /// Font: Manjari-Bold; Size: 12
    case headingManjari5
}

extension Font {
    static func escavatorUI(_ typographyCase: TypographyCase) -> Font {
        switch typographyCase {
        case .body1Regular:
            return Font.custom(TokenTypography.FontType.regular.rawValue, size: TokenTypography.FontSize.large.rawValue)
        case .body2Regular:
            return Font.custom(TokenTypography.FontType.regular.rawValue, size: TokenTypography.FontSize.medium.rawValue)
        case .body3Regular:
            return Font.custom(TokenTypography.FontType.regular.rawValue, size: TokenTypography.FontSize.extraLarge.rawValue)
        case .body4Regular:
            return Font.custom(TokenTypography.FontType.regular.rawValue, size: TokenTypography.FontSize.extraExtraExtraLarge.rawValue)
        case .headingManjari5:
            return Font.custom(TokenTypography.FontType.boldManjari.rawValue, size: TokenTypography.FontSize.small.rawValue)
        }
    }
}
