//
//  String+Extensions.swift
//  Calculator
//
//  Created by Mike Vork on 12/22/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import Foundation

extension String {
    // concatenate two strings together.  First remove leading and trailing whitespace from each string, then add one space between them.
    // this removes need for multiple places in code
    func concatenateWithTrimming(_ stringToAdd: String) -> String {
        let trimmed = self.trimmingCharacters(in: .whitespaces)
        if trimmed == "" {
            return stringToAdd.trimmingCharacters(in: .whitespaces)
        } else {
            return trimmed + " " + stringToAdd.trimmingCharacters(in: .whitespaces)
        }
    }
    
}
