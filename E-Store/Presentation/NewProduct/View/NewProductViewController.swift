//
//  NewProductViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 13/01/24.
//

import UIKit
import Kingfisher

protocol NewProductView: AnyObject {
    func reloadData()
}

class NewProductViewController: UIViewController, NewProductView {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    let spacing: CGFloat = 10
    let inset: CGFloat = 10
    
    var presenter: NewProductPresenter!
    var selectedCategoryIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        presenter.loadCategories()
    }
    
    // MARK: - Helpers
    func setup() {
        title = "New Product"
        cameraButton.setTitle(nil, for: .normal)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
    }
    
    // MARK: NewProductView Implementation
    func reloadData() {
        collectionView.reloadData()
        categoryPicker.reloadAllComponents()
    }
    
    //memilih gambar dari kamera maupun galery
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = false //set image to square
        present(imagePicker, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func cameraButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.presentImagePicker(sourceType: .camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.presentImagePicker(sourceType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let title = titleTextField.text ?? ""
        let price = Double(priceTextField.text ?? "0") ?? 0
        let description = descriptionTextView.text ?? ""
        
        presenter.createProduct(title: title, price: price, description: description, categoryIndex: selectedCategoryIndex)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension NewProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_cell", for: indexPath) as! ImageViewCell
        cell.imageView.kf.setImage(with: URL(string: presenter.images[indexPath.row]))
        return cell
    }
}

extension NewProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //atur ukuran menjadi square
        let rows: CGFloat = 1
        let width = UIScreen.main.bounds.width
        let height = (9 / 16 * width) - ((rows - 1) * spacing) - (inset * 2)
        
        return CGSize(width: floor(height / rows), height: floor(height / rows))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        //ngasi margin
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension NewProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            presenter.uploadImage(image)
        }
        dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDataSource
extension NewProductViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategoryIndex = row
    }
}
