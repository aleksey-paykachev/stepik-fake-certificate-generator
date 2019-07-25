//
//  UIImage+extension.swift
//  Stepik_Fake_Certificate_Generator
//
//  Created by Aleksey on 25/07/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIImage {

	func draw(atX x: CGFloat, y: CGFloat) {
		draw(in: CGRect(origin: CGPoint(x: x, y: y), size: size))
	}

	func draw(atX x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
		draw(in: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height)))
	}

}
