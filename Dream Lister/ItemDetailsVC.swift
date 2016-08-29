//
//  ItemDetailsVC.swift
//  Dream Lister
//
//  Created by Melissa Bain on 8/29/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var descriptionField: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    
    var stores = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
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
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        let item = Item(context: context)
        
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
}
