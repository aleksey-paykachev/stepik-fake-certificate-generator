//
//  CourseType.swift
//  Stepik_Fake_Certificate_Generator
//
//  Created by Aleksey on 24/07/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

enum CourseType: Int {
	case yandexSwiftBegin
	case yandexSwiftTookOff
	
	var title: String {
		switch self {
		case .yandexSwiftBegin: return "Разработка под iOS. Начинаем"
		case .yandexSwiftTookOff: return "Разработка под iOS. Взлетаем"
		}
	}
	
	var link: String {
		switch self {
		case .yandexSwiftBegin: return "https://stepik.org/course/52478"
		case .yandexSwiftTookOff: return "https://stepik.org/course/53561"
		}
	}
	
	var logoImage: UIImage {
		switch self {
		case .yandexSwiftBegin: return UIImage(named: "logo-begin")!
		case .yandexSwiftTookOff: return UIImage(named: "logo-took-off")!
		}
	}
}
