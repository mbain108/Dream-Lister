//
//  ItemDetailsVC.swift
//  Dream Lister
//
//  Created by Melissa Bain on 8/29/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var descriptionField: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
//        let store  = Store(context: context)
//        store.name = "Best Buy"
//        
//        let store2  = Store(context: context)
//        store2.name = "Tesla Dealership"
//        
//        let store3  = Store(context: context)
//        store3.name = "Frys Electronics"
//        
//        let store4  = Store(context: context)
//        store4.name = "Target"
//        
//        let store5  = Store(context: context)
//        store5.name = "Amazon"
//        
//        let store6  = Store(context: context)
//        store6.name = "Lowes"
//        
//        let store7  = Store(context: context)
//        store7.name = "Home Depot"
//        
//        ad.saveContext()
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        
        return store.name 
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //update when selected
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            //handle the error
        }
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            thumbnailImage.image = item.toImage?.image as? UIImage
            titleField.text = item.title
            priceField.text = "\(item.price)"
            descriptionField.text = item.details
            
            if let store = item.toStore {
                var index = 0
                
                repeat {
                    let s = stores[index]
                    
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    
                    index += 1
                } while (index < stores.count)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbnailImage.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        var item: Item!
        let picture = Image(context: context)
        
        picture.image = thumbnailImage.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let description = descriptionField.text {
            item.details = description
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImagePressed(_ sender: UIButton) {
    
        present(imagePicker, animated: true, completion: nil)
    }
    
}
