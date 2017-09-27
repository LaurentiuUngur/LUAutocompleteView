//
//  ViewController.swift
//  LUAutocompleteViewExample
//
//  Created by Laurentiu Ungur on 24/04/2017.
//  Copyright © 2017 Laurentiu Ungur. All rights reserved.
//

import UIKit
import LUAutocompleteView

final class ViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet weak var textField: UITextField!
    private let autocompleteView = LUAutocompleteView()

    private let elements = (1...100).map { "\($0)" }

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(autocompleteView)

        autocompleteView.textField = textField
        autocompleteView.dataSource = self
        autocompleteView.delegate = self

        // Customisation

        autocompleteView.rowHeight = 45
        //autocompleteView.autocompleteCell = CustomAutocompleteTableViewCell.self // Uncomment this line in order to use customised autocomplete cell
    }
}

// MARK: - LUAutocompleteViewDataSource

extension ViewController: LUAutocompleteViewDataSource {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, elementsFor text: String, completion: @escaping ([String]) -> Void) {
        let elementsThatMatchInput = elements.filter { $0.lowercased().contains(text.lowercased()) }
        completion(elementsThatMatchInput)
    }
}

// MARK: - LUAutocompleteViewDelegate

extension ViewController: LUAutocompleteViewDelegate {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, didSelect text: String) {
        print(text + " was selected from autocomplete view")
    }
}
