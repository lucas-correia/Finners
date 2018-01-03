//
//  PullRequest_VCViewController.swift
//  FinnersTest
//
//  Created by Lucas Correia Granados Castro on 03/01/18.
//  Copyright © 2018 Atlantic Solutions. All rights reserved.
//

//MARK: - • INTERFACE HEADERS

//MARK: - • FRAMEWORK HEADERS
import UIKit
import Kingfisher

//MARK: - • OTHERS IMPORTS

//MARK: - • EXTENSIONS

//MARK: - • CLASS

class PullRequest_VC: UIViewController, UITableViewDataSource, UITableViewDelegate, pullRequestDSDelegate {


    //MARK: - • LOCAL DEFINES
    
    
    //MARK: - • PUBLIC PROPERTIES
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var lblOpen:UILabel!
    @IBOutlet weak var lblClosed:UILabel!
    @IBOutlet weak var tbvPullRequests:UITableView!
    //
    var selectedRepository:Repository?
    var loadedLastPage:Bool = false
    
    //MARK: - • PRIVATE PROPERTIES
    private var prArray:Array<PullRequest> = Array<PullRequest>.init()
    private var prDS = PullRequest_DS.init()
    private var oppened = 0
    private var closed = 0
    private var lastPageLoaded = 0
    private let refreshControl = UIRefreshControl()
    
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
        
        prDS.delegate = self
        tbvPullRequests.register(UINib.init(nibName: "PullRequestView", bundle: nil), forCellReuseIdentifier: "CustomCellPullRequest")
        self.navigationItem.title = "Pull Resquests"
        
        //adding pull to refresh (checking system version)
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tbvPullRequests.refreshControl = refreshControl
        } else {
            tbvPullRequests.addSubview(refreshControl)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupLayout()
        App.Delegate.activityView?.startActivity(.loading, true, nil, nil)
        prDS.getPullRequestList(page: 1, url: (selectedRepository?.pulls_url)!)
}

//MARK: - • TABLEVIEW/ DATA-SOURCE
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "CustomCellPullRequest") as! PullRequest_TVC
        let pull = prArray[indexPath.row]
        
        cell.setupaLayout()
        cell.lblPRBody.text = pull.body
        cell.lblPRTitle.text = pull.title
        cell.lblOwnerName.text = pull.owner?.name
        cell.imvOwnerAvatar.kf.setImage(with: URL(string: (pull.owner?.avatar_url)!), placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == prArray.count - 3 && loadedLastPage == false) {
            
            prDS.getPullRequestList(page: lastPageLoaded + 1, url: (selectedRepository?.pulls_url)!)
            
        }
        
    }

//MARK: - • INTERFACE/PROTOCOL METHODS
    func didLoadPullRequestItems(pullRequestDS: PullRequest_DS, repoArray: Array<PullRequest>?, reponse: Dictionary<String, Any>?, lastItemsLoaded: Bool?, page: Int) {
        
        App.Delegate.activityView?.stopActivity(nil)
        
        if(repoArray != nil) {
            
            lastPageLoaded = page
            
            if(lastPageLoaded == 1){
                
                self.prArray = repoArray!
                self.closed = 0
                self.oppened = 0
                
            } else {
                
                for pr in repoArray! {
                    self.prArray.append(pr)
                }
            }
            
            if((repoArray?.count)! < App.Constants.ITEMS_PER_PAGE) {
                
                self.loadedLastPage = true
                
            }
            
            for pr in self.prArray {
                
                if(pr.status == "open") {
                    
                    self.oppened = self.oppened + 1
                } else if (pr.status == "closed") {
                    
                    self.closed = self.closed + 1
                }
            }
            
            if #available(iOS 10.0, *) {
                tbvPullRequests.refreshControl?.endRefreshing()
            } else {
                refreshControl.endRefreshing()
                // Fallback on earlier versions
            }
            lblOpen.text = String.init(format: "opened %i", self.oppened)
            lblClosed.text = String.init(format: " / %i closed", self.closed)
            tbvPullRequests.reloadData()
        }
    }

//MARK: - • PUBLIC METHODS


//MARK: - • ACTION METHODS
    func pullToRefresh() {
        prDS.getPullRequestList(page: 1, url: (selectedRepository?.pulls_url)!)
    }

//MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
    
    func setupLayout() {
        
        viewHeader.backgroundColor = nil
        lblClosed.backgroundColor = nil
        lblOpen.backgroundColor = nil
        //
        lblOpen.textColor = App.Style.colorText_Yellow
        lblClosed.textColor = App.Style.colorText_Black
        //
        lblOpen.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_BOLD, size: App.Constants.FONT_SIZE_LABEL_NORMAL)
        lblClosed.font = UIFont(name: App.Constants.FONT_SAN_FRANCISCO_BOLD, size: App.Constants.FONT_SIZE_LABEL_NORMAL)
    }
    
}
