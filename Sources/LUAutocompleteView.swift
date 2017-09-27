//
//  LUAutocompleteView.swift
//  LUAutocompleteView
//
//  Created by Laurentiu Ungur on 24/04/2017.
//  Copyright © 2017 Laurentiu Ungur. All rights reserved.
//

/// Highly configurable autocomplete view that is attachable to any `UITextField`.
open class LUAutocompleteView: UIView {
    // MARK: - Public Properties

    /// The object that acts as the data source of the autocomplete view.
    public weak var dataSource: LUAutocompleteViewDataSource?
    /// The object that acts as the delegate of the autocomplete view.
    public weak var delegate: LUAutocompleteViewDelegate?

    /** The time interval responsible for regulating the rate of calling data source function.
    If typing stops for a time interval greater than `throttleTime`, then the data source function will be called.
    Default value is `0.4`.
    */
    public var throttleTime: TimeInterval = 0.4
    /// The maximum height of autocomplete view. Default value is `200.0`.
    public var maximumHeight: CGFloat = 200.0
    /// A boolean value that determines whether the view should hide after a suggestion is selected. Default value is `true`.
    public var shouldHideAfterSelecting = true
    /** The attributes for the text suggestions.
     
    - Note: This property will be ignored if `autocompleteCell` is not `nil`.
    */
    public var textAttributes: [NSAttributedStringKey: Any]?
    /// The text field to which the autocomplete view will be attached.
    public weak var textField: UITextField? {
        didSet {
            guard let textField = textField else {
                return
            }

            textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            textField.addTarget(self, action: #selector(textFieldEditingEnded), for: .editingDidEnd)

            setupConstraints()
        }
    }
    /** A `LUAutocompleteTableViewCell` subclass that will be used to show a text suggestion.
    Set your own in order to customise the appearance.
    Default value is `nil`, which means the default one will be used.
     
    - Note: `textAttributes` will be ignored if this property is not `nil`
    */
    public var autocompleteCell: LUAutocompleteTableViewCell.Type? {
        didSet {
            guard let autocompleteCell = autocompleteCell else {
                return
            }

            tableView.register(autocompleteCell, forCellReuseIdentifier: LUAutocompleteView.cellIdentifier)
            tableView.reloadData()
        }
    }
    /// The height of each row (that is, table cell) in the autocomplete table view. Default value is `40.0`.
    public var rowHeight: CGFloat = 40.0 {
        didSet {
            tableView.rowHeight = rowHeight
        }
    }

    // MARK: - Private Properties

    private let tableView = UITableView()
    private var heightConstraint: NSLayoutConstraint?
    private static let cellIdentifier = "AutocompleteCellIdentifier"
    private var elements = [String]() {
        didSet {
            tableView.reloadData()
            height = tableView.contentSize.height
        }
    }
    private var height: CGFloat = 0 {
        didSet {
            guard height != oldValue else {
                return
            }

            guard let superview = superview else {
                heightConstraint?.constant = (height > maximumHeight) ? maximumHeight : height
                return
            }

            superview.layoutIfNeeded()
            UIView.animate(withDuration: 0.2) {
                self.heightConstraint?.constant = (self.height > self.maximumHeight) ? self.maximumHeight : self.height
                superview.layoutIfNeeded()
            }
        }
    }

    // MARK: - Init

    /** Initializes and returns a table view object having the given frame and style.

    - Parameters:
        - frame: A rectangle specifying the initial location and size of the table view in its superview’s coordinates. The frame of the table view changes as table cells are added and deleted.
        - style: A constant that specifies the style of the table view. See `UITableViewStyle` for descriptions of valid constants.

    - Returns: Returns an initialized `UITableView` object, or `nil` if the object could not be successfully initialized.
    */
    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    /** Returns an object initialized from data in a given unarchiver.

    - Parameter coder: An unarchiver object.
    
    - Retunrs: `self`, initialized using the data in *decoder*.
    */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    // MARK: - Private Functions

    private func commonInit() {
        addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: LUAutocompleteView.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = rowHeight
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.contentInset = .zero
        tableView.bounces = false
    }

    private func setupConstraints() {
        guard let textField = textField else {
            assertionFailure("Sanity check")
            return
        }

        tableView.removeConstraints(tableView.constraints)
        removeConstraints(self.constraints)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false

        heightConstraint = heightAnchor.constraint(equalToConstant: 0)

        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            topAnchor.constraint(equalTo: textField.bottomAnchor),
            heightConstraint!
        ]

        NSLayoutConstraint.activate(constraints)
    }

    @objc private func textFieldEditingChanged() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getElements), object: nil)
        perform(#selector(getElements), with: nil, afterDelay: throttleTime)
    }

    @objc private func getElements() {
        guard let dataSource = dataSource else {
            return
        }

        guard let text = textField?.text, !text.isEmpty else {
            elements.removeAll()
            return
        }

        dataSource.autocompleteView(self, elementsFor: text) { [weak self] elements in
            self?.elements = elements
        }
    }

    @objc private func textFieldEditingEnded() {
        height = 0
    }
}

// MARK: - UITableViewDataSource

extension LUAutocompleteView: UITableViewDataSource {
    /** Tells the data source to return the number of rows in a given section of a table view.

    - Parameters:
        - tableView: The table-view object requesting this information.
        - section: An index number identifying a section of `tableView`.

    - Returns: The number of rows in `section`.
    */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !(textField?.text?.isEmpty ?? true) ? elements.count : 0
    }

    /** Asks the data source for a cell to insert in a particular location of the table view.

    - Parameters:
        - tableView: A table-view object requesting the cell.
        - indexPath: An index path locating a row in `tableView`.

    - Returns: An object inheriting from `UITableViewCell` that the table view can use for the specified row. An assertion is raised if you return `nil`.
    */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LUAutocompleteView.cellIdentifier) else {
            assertionFailure("Cell shouldn't be nil")
            return UITableViewCell()
        }

        guard indexPath.row < elements.count else {
            assertionFailure("Sanity check")
            return cell
        }

        let text = elements[indexPath.row]

        guard autocompleteCell != nil, let customCell = cell as? LUAutocompleteTableViewCell  else {
            cell.textLabel?.attributedText = NSAttributedString(string: text, attributes: textAttributes)
            cell.selectionStyle = .none

            return cell
        }

        customCell.set(text: text)

        return customCell
    }
}

// MARK: - UITableViewDelegate

extension LUAutocompleteView: UITableViewDelegate {
    /** Tells the delegate that the specified row is now selected.

    - Parameters:
        - tableView: A table-view object informing the delegate about the new row selection.
        - indexPath: An index path locating the new selected row in `tableView`.
    */
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < elements.count else {
            assertionFailure("Sanity check")
            return
        }

        if shouldHideAfterSelecting {
            height = 0
        }
        textField?.text = elements[indexPath.row]
        delegate?.autocompleteView(self, didSelect: elements[indexPath.row])
    }
}
