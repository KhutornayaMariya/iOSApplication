//
//  String+Extensions.swift
//  Navigation
//
//  Created by m.khutornaya on 01.12.2022.
//

import Foundation

extension String {
    var localized: String  {
        NSLocalizedString(self, comment: "")
    }
}
