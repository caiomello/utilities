//
//  WebViewController.swift
//  Utilities
//
//  Created by Caio Mello on 8/30/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit
import SafariServices

public class WebViewController: SFSafariViewController {
    public convenience init(url: URL, tintColor: UIColor) {
        self.init(url: url)
        preferredControlTintColor = tintColor
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        preferredBarTintColor = .black
    }
}
