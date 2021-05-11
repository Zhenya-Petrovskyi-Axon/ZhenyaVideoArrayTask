//
//  StringExtension.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 11.05.2021.
//

import Foundation

// MARK: - Check for empty text fields
extension String {
    /// True if string contains only newlines or whitespaces, or is empty
    var isBlank: Bool { trimmed.isEmpty }
    var trimmed: String { self.trimmingCharacters(in: .whitespacesAndNewlines) }
    var isPresent: Bool { !isBlank }
}

