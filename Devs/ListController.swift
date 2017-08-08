//
//  Created by Mitja Semolic on 02/08/2017.
//  Copyright © 2017 Mitja Semolic. All rights reserved.
//

import UIKit

class ListController: UIViewController {

// MARK: - IBOutlet

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var pageLabel: UILabel!
    
// MARK: - Properties

    var developers: [DeveloperDetails] = [] {
        didSet {
            tableView.reloadData()
            shareToWidgetRandomDeveloper(developers: developers)
        }
    }
    var searchString: String?
    var currentPageCursor: String?
    var nextPageCursor: String?
    var stackPrevPageCursor = [String?]()
    var pageNumber = [1, 0]

// MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        loadDevelopers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

// MARK: - UserDefaults

    func shareToWidgetRandomDeveloper(developers: [DeveloperDetails]) {
        let index = Int(arc4random_uniform(UInt32(developers.count)))
        shareToWidget(developer: developers[index])
    }
    
    func shareToWidget(developer: DeveloperDetails) {
        let name = developer.name
        let registredYear = formatDate(from: developer.createdAt, format: "YYYY")
        let followersCount = formatPoints(from: developer.followers.totalCount)
        let desc = "Registred \(registredYear!) • Followers \(followersCount)"
        let thumbUrl = "\(developer.avatarUrl)&s=80"
        
        UserDefaults.init(suiteName: "group.co.mitja.devs-ios")?.setValue(name, forKey: "name")
        UserDefaults.init(suiteName: "group.co.mitja.devs-ios")?.setValue(desc, forKey: "desc")
        UserDefaults.init(suiteName: "group.co.mitja.devs-ios")?.setValue(thumbUrl, forKey: "thumbUrl")
    }

// MARK: - IBAction
    
    @IBAction func nextPagePressed(_ sender: Any) {
        self.stackPrevPageCursor.append(self.currentPageCursor)
        self.currentPageCursor = self.nextPageCursor
        self.pageNumber[0] = self.pageNumber[0] + 1
        
        loadDevelopers()
        self.tableView.contentOffset = CGPoint(x: 0, y:0 - self.tableView.contentInset.top)
    }
    
    @IBAction func prevPagePressed(_ sender: Any) {
        self.currentPageCursor = self.stackPrevPageCursor.popLast()!
        self.pageNumber[0] = self.pageNumber[0] - 1
        
        loadDevelopers()
        self.tableView.contentOffset = CGPoint(x: 0, y: 0 - self.tableView.contentInset.top)
    }
    
    // MARK: - Load
    
    func loadDevelopers() {
        let query = SearchUsersQuery(searchString: searchString!, afterCursor: currentPageCursor)
        apollo.fetch(query: query) { result, error in
            
            if let error = error {
                print("error: fetching github query, \(error.localizedDescription)")
                return
            }
            
            guard let data = result?.data else { return }
            let pageInfo = data.search.pageInfo
            self.nextPageCursor = pageInfo.endCursor
            let developerCount = data.search.userCount
            let pageCount = Int(ceil(Double(developerCount)/10))
            self.pageNumber[1] = pageCount
            
            guard let edges = data.search.edges else { return }
            let developers = edges.map { ($0?.node?.fragments.developerDetails)! }
        
            self.pageLabel.text = "\(formatNumber(from: self.pageNumber[0]))/\(formatNumber(from: self.pageNumber[1]))"
            self.prevButton.isHidden = self.pageNumber[0] == 1
            self.nextButton.isHidden = self.pageNumber[0] == self.pageNumber[1]
            self.developers = developers
        }
    }
}

// MARK: - UITableView

extension ListController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return developers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell

        let developer = developers[indexPath.row]
        let registredYear = formatDate(from: developer.createdAt, format: "YYYY")
        let followersCount = formatPoints(from: developer.followers.totalCount)
        let description = "Registred \(registredYear!) • Followers \(followersCount)"
        let thumbnailUrl = "\(developer.avatarUrl)&s=80"
        
        cell.nameLabel.text = developer.name
        cell.descLabel.text = description
        loadImageAsync(url: thumbnailUrl, imageView: cell.thumbImage)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetails", sender: nil)
    }
}

// MARK: - Navigation

extension ListController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let developerDetails = self.developers[selectedIndex]
            let detailsController = segue.destination as! DetailsController
        
            detailsController.developer = developerDetails
        }
    }
}
