//
//  CollectionViewController.swift
//  shareKakeibo
//
//  Created by nishimaru on 2021/10/26.
//  Copyright © 2021 nishimaru. All rights reserved.
//
import UIKit
import SDWebImage

protocol CollectionDeligate {
    func SendArray(selectedUserImageArray:[String],userIDArray: [String],userNameArray: [String])
}


class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,LoadOKDelegate {
    
    var loadDBModel = LoadDBModel()
    var collectionDeligate:CollectionDeligate?
    
    @IBOutlet weak var decideButton: UIButton!
    @IBOutlet weak var searchUserTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
   //// var userIDArray = [String]()
  //  var selectedIDArray = [String]()
   // var imageArray = [String]()
    var selectedUserImageArray = [UserSearchSets]() //profile画像のURLが入る
   // var userNameArray = [String]()
   // var selectedUserNameArray = [String]()
   // var colorArray = [UIColor.blue,UIColor.red,UIColor.green,UIColor.yellow,UIColor.purple] //あとで消す
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decideButton.layer.cornerRadius = 5
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
       
        tableView.delegate = self
        tableView.dataSource = self
        loadDBModel.loadOKDelegate = self
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedUserImageArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.profileImage!.image = UIImage(systemName: selectedUserImageArray[indexPath.row])
        cell.profileImage.backgroundColor = colorArray[indexPath.row]
        cell.deleteButton!.addTarget(self, action: #selector(tapDeleteButton(_:)), for: .touchUpInside)
        print("daigoitemAt")
        print(cell.deleteButton.tag)
        
        return cell
    }
    
    @objc func tapDeleteButton(_ sender:UIButton){
        let cell = sender.superview?.superview as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        print(indexPath?.row)
        selectedUserImageArray.remove(at: indexPath!.row)
        colorArray.remove(at: indexPath!.row)
        collectionView.deleteItems(at: [IndexPath(item: indexPath!.row, section: 0)])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         
        let profileImage = cell.contentView.viewWithTag(1) as! UIImageView
        let userNameLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        profileImage.image = UIImage(systemName: loadDBModel.userSearchSets[indexPath.row].profileImage)
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       // selectedUserImageArray.append(imageArray[indexPath.row])
        selectedUserImageArray.append(loadDBModel.userSearchSets[indexPath.row])
       
        loadDBModel.userSearchSets.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        collectionView.reloadData()
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    @IBAction func searchButton(_ sender: Any){
        loadDBModel.loadUserSearch(email: searchUserTextField.text)
    
//        userIDArray.append(UserSearchSets: "userID")
//        userNameArray.append(UserSearchSets: "userName")
       
    }
    
    func loadUserSearch_OK() {
        loadDBModel.userSearchSets[]
    }
    
    @IBAction func decideButton(_ sender: Any) {
        collectionDeligate?.SendArray(selectedUserImageArray: selectedUserImageArray, emailArray: emailArray)
        print(selectedUserImageArray)
        dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

