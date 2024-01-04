//
//  StringProtocol.ext.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 23.12.2023.
//

import UIKit


extension StringProtocol{
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}
