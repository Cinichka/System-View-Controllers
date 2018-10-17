//
//  ViewController.swift
//  System View Controllers
//
//  Created by Вероника Садовская on 15/10/2018.
//  Copyright © 2018 Veronika Sadovskaya. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

	@IBOutlet weak var imageView: UIImageView!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	@IBAction func shareButtonTapped(_ sender: UIButton) {
		guard let image = imageView.image else {return}
		let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		activityController.popoverPresentationController?.sourceView = sender
		present(activityController, animated: true, completion: nil)
	}
	@IBAction func safariButtonTapped(_ sender: UIButton) {
		if let url = URL(string: "https://apple.com") {
			let safariViewController = SFSafariViewController(url: url)
			present(safariViewController, animated: true, completion: nil)
		}
		
	}
	@IBAction func cameraButtonTapped(_ sender: UIButton) {
		
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		
		let alertController = UIAlertController(title: "Выберите источник изображения", message: nil, preferredStyle: .actionSheet)
		let cancelAlert = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
		alertController.addAction(cancelAlert)
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
		let cameraAction = UIAlertAction(title: "Камера", style: .default) { _ in
			imagePicker.sourceType = .camera
			self.present(imagePicker, animated: true, completion: nil)
		}
		alertController.addAction(cameraAction)
		}
			if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
		let photoAction = UIAlertAction(title: "Фото", style: .default) {
			_ in
			imagePicker.sourceType = .photoLibrary
			self.present(imagePicker, animated: true, completion: nil)
		}
		alertController.addAction(photoAction)
		}
		alertController.popoverPresentationController?.sourceView = sender
		
		present(alertController, animated: true, completion: nil)
	}
	
	
	
	
	@IBAction func emailButtonTapped(_ sender: UIButton) {
		if MFMailComposeViewController.canSendMail() {
			let mail = MFMailComposeViewController()
			mail.mailComposeDelegate = self
			mail.setToRecipients(["cinichka85@gmail.com"])
			mail.setSubject(NSLocalizedString("Send image", comment: "Send image"))
			let imageData = imageView.image!.jpegData(compressionQuality: 0.75)
			mail.addAttachmentData(imageData!, mimeType:"image/jpeg", fileName:"image")
			
			mail.setMessageBody(NSLocalizedString("<b> Новое фото </b>", comment: "<b>  Новое фото </b>"), isHTML: true)
			present(mail, animated: true, completion: nil)
		} else {
			print("Cannot send mail")
		}
	}
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			imageView.image = selectedImage
			dismiss(animated: true, completion: nil)
		}
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
		self.dismiss(animated: true, completion: nil)
	}
}


