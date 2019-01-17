//
//  ViewController.swift
//  HackingWithSwift
//
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, LoggerHandle {
    let allProjects: [Project] = Bundle.main.decode(from: "projects")
    var showingProjects = [Project]()
    var user = User()
    
    var projectTableDataSource: ProjectTableDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(showSettings))
        
        projectTableDataSource = ProjectTableDataSource(projects: allProjects)
        tableView.dataSource = projectTableDataSource!
        updatePreferences()
    }

    @objc func showSettings() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            fatalError("Unable to find SettingsViewController")
        }

        vc.delegate = self
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }

    func updateUser(_ newUser: User) {
        user = newUser
        user.save()
        updatePreferences()
    }

    func updatePreferences() {
        title = user.name

        if user.showProjects == 0 {
            // show all projects
            showingProjects = allProjects
        } else {
            // show only the project types they selected
            showingProjects = allProjects.filter {
                $0.number % 3 == user.showProjects - 1
            }
        }
        projectTableDataSource?.projects = showingProjects
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = showingProjects[indexPath.row]

        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }

        detailVC.project = project
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


class ProjectTableDataSource: NSObject, UITableViewDataSource {
    var projects: [Project]
    
    init(projects: [Project]) {
        self.projects = projects
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let project = projects[indexPath.row]
        cell.textLabel?.attributedText = project.displayText
        return cell
    }
}
