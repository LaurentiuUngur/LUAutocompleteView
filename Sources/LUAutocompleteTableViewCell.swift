//
//  LUAutocompleteTableViewCell.swift
//  LUAutocompleteView
//
//  Created by Laurentiu Ungur on 24/04/2017.
//  Copyright © 2017 Laurentiu Ungur. All rights reserved.
//

import UIKit

/// The base class for cells used in `LUAutocompleteView`
open class LUAutocompleteTableViewCell: UITableViewCell {
    // MARK - Public Functions

    /** Function that is called when cell is configured with given text.
     
    - Parameter text: A string that should be displayed.
     
    - Warning: Must be implemented by each subclass.
    */
    open func set(text: String) {
        preconditionFailure("This function must be implemented by each subclass")
    }
}
