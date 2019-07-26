//
//  FileManager+extension.swift
//  Stepik_Fake_Certificate_Generator
//
//  Created by Aleksey on 26/07/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import Foundation

extension FileManager {
	static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}
