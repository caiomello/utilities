//
//  NSDirectionalEdgeInsets+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 7/5/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension NSDirectionalEdgeInsets {
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
