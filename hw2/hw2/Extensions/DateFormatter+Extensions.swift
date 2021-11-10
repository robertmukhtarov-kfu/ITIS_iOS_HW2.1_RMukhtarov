//
//  DateFormatter+Extensions.swift
//  hw2
//
//  Created by RRMukhtarov on 03.11.2021.
//

import Foundation

extension DateFormatter {
    static var time: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter
    }
}
