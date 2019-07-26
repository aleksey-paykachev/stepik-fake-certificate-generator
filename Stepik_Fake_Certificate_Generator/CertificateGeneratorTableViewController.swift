//
//  CertificateGeneratorTableViewController.swift
//  Stepik_Fake_Certificate_Generator
//
//  Created by Aleksey on 24/07/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CertificateGeneratorTableViewController: UITableViewController {
	
	@IBOutlet private weak var certificateImageView: UIImageView!
	@IBOutlet private weak var courseSelectorSegmentedControl: UISegmentedControl!
	@IBOutlet private weak var useCoverImageSwitch: UISwitch!
	@IBOutlet private weak var nameTextField: UITextField!
	@IBOutlet private weak var gradeTextField: UITextField!
	@IBOutlet private weak var certificateIdTextField: UITextField!
	@IBOutlet private weak var dateDatePicker: UIDatePicker!
	
	private var nameTextFieldValue: String?
	private var gradeTextFieldValue: String?
	private var certificateIdTextFieldValue: String?

	private var certificate = Certificate()
	
	let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.MM.YYYY"
		return dateFormatter
	}()

	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.keyboardDismissMode = .onDrag
		
		nameTextField.delegate = self
		gradeTextField.delegate = self
		certificateIdTextField.delegate = self
		
		updateCertificateImage()
    }
	
	@IBAction func dateDatePickerChangedValue(_ sender: UIDatePicker) {
		updateCertificateImage()
	}
	
	@IBAction func useCoverImageSwitchChangedValue(_ sender: UISwitch) {
		updateCertificateImage()
	}
	
	@IBAction func courseSelectorSegmentedControlChangedValue(_ sender: UISegmentedControl) {
		updateCertificateImage()
	}
	
	@IBAction func saveToFilesystemButtonPressed(_ sender: UIBarButtonItem) {
		guard let pngData = certificate.certificateImage?.pngData() else { return }
		
		let fileName = "certificate.png"
		let pathUrl = FileManager.documentDirectory.appendingPathComponent(fileName, isDirectory: false)
		
		do {
			try pngData.write(to: pathUrl, options: .atomic)
			showCertificateSavedAlertConfirmation(savedPathUrl: pathUrl)
		} catch {
			print("Can't save data. Error: \(error.localizedDescription)")
		}
	}
	
	private func showCertificateSavedAlertConfirmation(savedPathUrl: URL) {

		let alertController = UIAlertController(
			title: "Изображение сохранено",
			message: "Полноразмерное изображение сохранено в папку:\n\(savedPathUrl)",
			preferredStyle: .alert
		)
		alertController.addAction(UIAlertAction(title: "ОК", style: .default))
		present(alertController, animated: true)
		
		print("Certificate successfully saved to: \(savedPathUrl)") //simplify copy-paste url path from simulator
	}
	
	@IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
		if let image = certificate.getImage(withScale: 0.6) {
			let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
			activityViewController.popoverPresentationController?.barButtonItem = sender
			present(activityViewController, animated: true)
		}
	}
	
	private func updateCertificateImage() {

		let name = nameTextFieldValue ?? ""
		let grade = gradeTextFieldValue ?? ""
		let certificateId = certificateIdTextFieldValue ?? ""
		let date = dateFormatter.string(from: dateDatePicker.date)
		let isCoverImageShowing = useCoverImageSwitch.isOn
		let course =  CourseType(rawValue: courseSelectorSegmentedControl.selectedSegmentIndex) ?? .yandexSwiftBegin
		
		DispatchQueue.global(qos: .userInitiated).async {
			let certificateImage = self.certificate.updateImage(name: name, grade: grade, certificateId: certificateId, date: date, showCoverImage: isCoverImageShowing, course: course)
			
			DispatchQueue.main.async {
				self.certificateImageView.image = certificateImage
			}
		}

	}
}


// MARK: - UITableViewDelegate

extension CertificateGeneratorTableViewController {
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			let imageSize = certificateImageView.image!.size
			let screenSize = UIScreen.main.bounds
			
			let width = screenSize.width * imageSize.height / imageSize.width
			return min(width, 520)
		}
		
		return UITableView.automaticDimension
	}
}


// MARK: - UITextFieldDelegate

extension CertificateGeneratorTableViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		switch textField {
		case nameTextField:
			gradeTextField.becomeFirstResponder()
		case gradeTextField:
			certificateIdTextField.becomeFirstResponder()
		default:
			textField.resignFirstResponder()
		}

		return true
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		if let text = textField.text, let range = Range(range, in: text) {
			let textFieldValue = text.replacingCharacters(in: range, with: string)

			switch textField {
			case nameTextField:
				nameTextFieldValue = textFieldValue
			case gradeTextField:
				gradeTextFieldValue = textFieldValue
			case certificateIdTextField:
				certificateIdTextFieldValue = textFieldValue
			default:
				break
			}
			
			updateCertificateImage()
		}

		return true
	}

}
