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

class RepositoryList_VC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - • LOCAL DEFINES
    
    
    //MARK: - • PUBLIC PROPERTIES
    @IBOutlet weak var tbvRepositories:UITableView!
    
    //MARK: - • PRIVATE PROPERTIES
    private var repoArray:Array<Repository>!
    private var selectedRepo:Repository!
    private let refreshControl = UIRefreshControl()
    private var lastItemsLoaded = false
    
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
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "") {
            
            //TODO: alterar ao ter o view controller RP
            let pullRequestVC = segue.destination as! PullRequest_TVC
            
        }
    }
    
    //MARK: - • INTERFACE/PROTOCOL METHODS
    
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
            
            //TODO:REALIZAR CHAMA AO DS
            
        }
        
    }
    
    //MARK: - • PUBLIC METHODS
    
    
    //MARK: - • ACTION METHODS
    @objc private func pullToRefresh() {
        
        //TODO:REALIZAR CHAMA AO DS
    }
    
    //MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
}
