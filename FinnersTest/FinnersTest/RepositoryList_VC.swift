//
//  RepositoryList_VC.swift
//  FinnersTest
//
//  Created by Lucas Castro on 02/01/2018.
//  Copyright © 2018 Atlantic Solutions. All rights reserved.
//

//MARK: - • INTERFACE HEADERS

//MARK: - • FRAMEWORK HEADERS
import UIKit
import Kingfisher

//MARK: - • OTHERS IMPORTS

//MARK: - • EXTENSIONS

//MARK: - • CLASS

class RepositoryList_VC: UIViewController, UITableViewDataSource, UITableViewDelegate, repositoryDSDelegate {
    
    //MARK: - • LOCAL DEFINES
    
    
    //MARK: - • PUBLIC PROPERTIES
    @IBOutlet weak var tbvRepositories:UITableView!
    
    //MARK: - • PRIVATE PROPERTIES
    private var repoArray:Array<Repository>!
    private var selectedRepo:Repository!
    private let refreshControl = UIRefreshControl()
    private var lastItemsLoaded = false
    private var repositoryDS = Repository_DS.init()
    private var lastPageRequeted = 0
    
    //MARK: - • INITIALISERS
    
    
    //MARK: - • CUSTOM ACCESSORS (SETS & GETS)
    
    
    //MARK: - • DEALLOC
    
    deinit {
        // NSNotificationCenter no longer needs to be cleaned up!
    }
    
    //MARK: - • SUPER CLASS OVERRIDES
    
    
    //MARK: - • CONTROLLER LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositoryDS.delegate = self
        
        tbvRepositories.register(UINib.init(nibName: "RepositoryView", bundle: nil), forCellReuseIdentifier: "CustomCellRepository")
        
        //adding pull to refresh (checking system version)
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tbvRepositories.refreshControl = refreshControl
        } else {
            tbvRepositories.addSubview(refreshControl)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        App.Delegate.activityView?.startActivity(.loading, true, nil, nil)
        repositoryDS.getRepositories(page: 1)
        lastPageRequeted = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "") {
            
            //TODO: alterar ao ter o view controller RP
            let pullRequestVC = segue.destination as! PullRequest_TVC
            
        }
    }
    
    //MARK: - • INTERFACE/PROTOCOL METHODS
    func didLoadRepositoryItems(repoDS: Repository_DS, repoArray: Array<Repository>?, reponse: Dictionary<String, Any>?, lastItemsLoaded: Bool?, page: Int) {
        
        App.Delegate.activityView?.stopActivity(nil)
        if(repoArray != nil) {
            
            if(page == 1){
                
                self.repoArray = repoArray
                
            } else {
                
                for repository in repoArray! {

                    self.repoArray.append(repository)
                }
                
            }
            
            lastPageRequeted = page
            self.lastItemsLoaded = lastItemsLoaded != nil ? lastItemsLoaded! : false
            //
            if #available(iOS 10.0, *) {
                tbvRepositories.refreshControl?.endRefreshing()
            } else {
                // Fallback on earlier versions
            }
            tbvRepositories.reloadData()
        }
    }
    
    
    //MARK: - • TABLE VIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellRepository") as! Repository_TVC
        let repo = repoArray[indexPath.row]
        
        cell.setupLayout()
        cell.lblRepoName.text = repo.name
        cell.lblRepoDescription.text = repo.description
        cell.lblRepoStars.text = String.init(format: "%i", repo.stars_count!)
        cell.lblRepoForks.text = String.init(format: "%i", repo.forks_count!)
        cell.lblOwnerName.text = repo.owner?.name
        cell.imvOwnerAvatar.kf.setImage(with: URL(string: (repo.owner?.avatar_url)!), placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRepo = repoArray[indexPath.row].copy()
        self.performSegue(withIdentifier: "Segue_PR", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == repoArray.count - 3 && lastItemsLoaded == false) {
            
            repositoryDS.getRepositories(page: lastPageRequeted + 1)
            
        }
        
    }
    
    //MARK: - • PUBLIC METHODS
    
    
    //MARK: - • ACTION METHODS
    @objc private func pullToRefresh() {
        
        repositoryDS.getRepositories(page: 1)
        
    }
    
    //MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
}
