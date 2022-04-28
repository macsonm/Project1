import UIKit

class TableViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        pictures = pictures.sorted { x1, x2 in
            Int(x1.filter("0123456789".contains)) ?? 2 < Int(x2.filter("0123456789".contains)) ?? 3
            //Int(x1.dropFirst(4))! > Int(x2.dropFirst(4))!
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pictures.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        //content.image = UIImage(named: pictures[indexPath.row])
        //content.text = pictures[indexPath.item]
        let numbersAllPictures = pictures.count
        content.text = "Image \(indexPath.item+1) of \(numbersAllPictures)"
        cell.contentConfiguration = content
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.nameOfSelectedImage = "\(indexPath.item+1)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    
}
