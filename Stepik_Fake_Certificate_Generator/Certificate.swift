//
//  Certificate.swift
//  Stepik_Fake_Certificate_Generator
//
//  Created by Aleksey on 24/07/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class Certificate {
	private(set) var certificateImage: UIImage?
	
	private let templateImage = UIImage(named: "certificate-template")!
	private let coverImage = UIImage(named: "cover")!
	private let footerImage = UIImage(named: "footer")!
	
	private let certificateLink = "https://stepik.org/cert/"
	
	func updateImage(name: String, grade: String, certificateId: String, date: String, showCoverImage isCoverImageShowing: Bool, course: CourseType) -> UIImage? {
		
		UIGraphicsBeginImageContextWithOptions(templateImage.size, false, 0)
		
		//images
		templateImage.draw(atX: 0, y: 0)
		if isCoverImageShowing {
			coverImage.draw(atX: 378, y: 256, width: 606, height: 495)
		}
		footerImage.draw(atX: 375, y: 1250, width: 2086, height: 337)
		course.logoImage.draw(atX: 377, y: 1693, width: 102, height: 102)
		
		//text - AttributedStrings
		getAttributedString(for: name).draw(atX: 383, y: 976)
		getAttributedString(for: course.title).draw(atX: 383, y: 1196)
		getAttributedString(for: grade).draw(atX: 2461, y: 1196, alignment: .right)
		getAttributedString(for: course.link, textType: .link).draw(atX: 515, y: 1741)
		getAttributedString(for: certificateLink + certificateId, textType: .link).draw(atX: 515, y: 1792)
		getAttributedString(for: date, textType: .date).draw(atX: 2461, y: 1769, alignment: .right)
	
		
		certificateImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return certificateImage
	}
	
	func getImage(withScale scale: CGFloat) -> UIImage? {
		guard let image = certificateImage else { return nil }
		
		let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
		UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
		image.draw(in: CGRect(origin: .zero, size: newSize))
		let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return scaledImage
	}
	
	private func getAttributedString(for text: String, textType: TextType = .main) -> NSAttributedString {
		
		let textFontAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: textType.fontName, size: textType.fontSize)!,
			.foregroundColor: textType.textColor
		]
		return NSAttributedString(string: text, attributes: textFontAttributes)
	}
	
	private enum TextType {
		case main
		case link
		case date
		
		var fontName: String {
			return self == .link ? "Helvetica" : "Helvetica Bold"
		}
		
		var fontSize: CGFloat {
			switch self {
			case .main: return 72
			case .link: return 29
			case .date: return 40
			}
		}
		
		var textColor: UIColor {
			switch self {
			case .main: return UIColor(hue: 0, saturation: 0, brightness: 0.37, alpha: 1)
			case .link: return UIColor(red: 60 / 255, green: 103 / 255, blue: 177 / 255, alpha: 1)
			case .date: return UIColor(red: 239 / 255, green: 70 / 255, blue: 100 / 255, alpha: 1)
			}
		}
	}
	
}
