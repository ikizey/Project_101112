//
//  ViewController.swift
//  Project_101112
//
//  Created by PrincePhoenix on 09.06.2021.
//

import UIKit

class ViewController: UITableViewController,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        
        loadphotos()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let photo = photos[indexPath.item]
        cell?.textLabel?.text = photo.name
        
        let path = getDocumntsDirectory().appendingPathComponent(photo.image)
        cell?.imageView?.image = UIImage(contentsOfFile: path.path)
        
        return cell!
    }
    
    func savePhotos() {
        if let encodedPhotos = try? JSONEncoder().encode(photos) {
            UserDefaults.standard.set(encodedPhotos, forKey: "photos")
        }
    }
    
    func loadphotos() {
        if let photosData = UserDefaults.standard.object(forKey: "photos") as? Data {
            do {
                photos = try JSONDecoder().decode([Photo].self, from: photosData)
            } catch {
                //
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailView") as? DetailViewController {
            let photo = photos[indexPath.row]
            
            let path = getDocumntsDirectory().appendingPathComponent(photo.image)
            vc.image = UIImage(contentsOfFile: path.path)
            vc.name = photo.name
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getDocumntsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func addPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let photo = info[.editedImage] as? UIImage else { return }
        let photoName = UUID().uuidString
        let photoPath = getDocumntsDirectory().appendingPathComponent(photoName)
        
        if let jpedData = photo.jpegData(compressionQuality: 1) {
            try? jpedData.write(to: photoPath)
        }
        let photoObj = Photo(image: photoName, name: "Unknown")
        photos.append(photoObj)
        savePhotos()
        tableView.reloadData()
        
        dismiss(animated: true)
    }
}
