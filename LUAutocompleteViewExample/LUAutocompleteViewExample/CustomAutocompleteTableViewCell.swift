//
//  CustomAutocompleteTableViewCell.swift
//  LUAutocompleteViewExample
//
//  Created by Laurentiu Ungur on 25/04/2017.
//  Copyright © 2017 Laurentiu Ungur. All rights reserved.
//

import UIKit
import LUAutocompleteView

final class CustomAutocompleteTableViewCell: LUAutocompleteTableViewCell {
    // MARK: - Base Class Overrides
    
    override func set(text: String) {
        textLabel?.text = text
        textLabel?.textColor = .red
    }
}
