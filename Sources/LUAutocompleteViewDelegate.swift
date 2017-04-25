//
//  LUAutocompleteViewDelegate.swift
//  LUAutocompleteView
//
//  Created by Laurentiu Ungur on 24/04/2017.
//  Copyright © 2017 Laurentiu Ungur. All rights reserved.
//

import Foundation

/// The delegate of a `LUAutocompleteView` object.
public protocol LUAutocompleteViewDelegate: class {
    /** Tells the delegate the text that user selected.

    - Parameters:
        - autocompleteView: An autocomplete view object informing the delegate about the selected text.
        - text: A string that was selected in autocomplete view.
    */
    func autocompleteView(_ autocompleteView: LUAutocompleteView, didSelect text: String)
}
