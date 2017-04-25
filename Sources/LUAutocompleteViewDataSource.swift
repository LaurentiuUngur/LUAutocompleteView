//
//  LUAutocompleteViewDataSource.swift
//  LUAutocompleteView
//
//  Created by Laurentiu Ungur on 24/04/2017.
//  Copyright © 2017 Laurentiu Ungur. All rights reserved.
//

import Foundation

/** The `LUAutocompleteViewDataSource` protocol is adopted by an object that mediates the application’s data model for a `LUAutocompleteView` object.
The data source provides the autocomplete view object with the information it needs to display.
*/
public protocol LUAutocompleteViewDataSource: class {
    /** Asks the data source to provide elements that should be displayed for given text.

    - Parameters:
        - autocompleteView: An object representing the autocomplete view requesting this information.
        - text: A string representing the input from the text field.
        - completion: A closure that contains the elements matching `text` that will be displayed by autocomplete view.
    */
    func autocompleteView(_ autocompleteView: LUAutocompleteView, elementsFor text: String, completion: @escaping ([String]) -> Void)
}
