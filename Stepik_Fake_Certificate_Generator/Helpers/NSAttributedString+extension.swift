//
//  NSAttributedString+extension.swift
//  Stepik_Fake_Certificate_Generator
//
//  Created by Aleksey on 25/07/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension NSAttributedString {
	func draw(atX x: CGFloat, y: CGFloat, alignment: NSTextAlignment = .left) {
		
		let x = alignment == .right ? x - self.size().width : x
		self.draw(at: CGPoint(x: x, y: y - self.size().height))
	}
}
