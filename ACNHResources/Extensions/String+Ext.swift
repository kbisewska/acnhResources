//
//  String+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import CryptoKit
import Foundation

extension String {
    
    func sha256() -> String {
        return SHA256.hash(data: Data(self.utf8))
            .compactMap { String(format: "%02x", $0) }.joined()
    }
}
