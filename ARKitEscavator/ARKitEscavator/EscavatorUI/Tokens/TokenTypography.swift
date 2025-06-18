//
//  TokenTypography.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 18/06/25.
//

import SwiftUI
struct TokenTypography {

    fileprivate enum FontSize: CGFloat {
        case medium = 20
        case large = 24
        case extraLarge = 28
        case extraExtraExtraLarge = 55
    }

    fileprivate enum FontType: String {
        case regular = "LoveYaLikeASister-Regular"
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
        }
    }
}
