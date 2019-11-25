//
//  TableViewController.swift
//  UITableViewTemplate
//
//  Created by Paola Latino on 11/24/19.
//  Copyright © 2019 Paola Latino. All rights reserved.
//

import UIKit
import Foundation

struct Headline {

     var id : Int
     var date : Date
     var title : String
     var text : String
     var image : String
}

struct MonthSection {
    var month: Date
    var headlines: [Headline]
}

func convertStringToDate(inputDate: String) -> Date {
    //Variable that will help to convert the string to date
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    return dateFormat.date(from: inputDate)!
}
class TableViewController: UITableViewController {

    var sections = [MonthSection]()
    
    // Array with all the data
     var headlines = [
        Headline(id: 1, date: convertStringToDate(inputDate: "2018-05-15"), title: "Proin suscipit maximus", text: "Quisque ultrices odio in neque eleifend eleifend. Praesent tincidunt euismod sem, et rhoncus lorem facilisis eget.", image: "Blueberry"),
        Headline(id: 2, date: convertStringToDate(inputDate: "2018-02-15"), title: "In ac ante sapien", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc in ipsum vehicula accumsan quis sit amet quam. Sed vel feugiat eros.", image: "Cantaloupe"),
        Headline(id: 3, date:convertStringToDate(inputDate: "2018-03-05"), title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque id ornare tortor, quis dictum enim. Morbi convallis tincidunt quam eget bibendum. Suspendisse malesuada maximus ante, at molestie massa fringilla id.", image: "Apple"),
        Headline(id: 4, date: convertStringToDate(inputDate: "2018-02-10"), title: "Aenean condimentum", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non, finibus et diam. Morbi et felis a lacus pharetra blandit.", image: "Banana"),
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Computes the values grouped by date using Dictionary(grouping:by:). Map the result to an Array of MonthSections
        let groups = Dictionary(grouping: headlines) { headline in
            firstDayOfMonth(date: headline.date)
        }
        self.sections = groups.map(MonthSection.init(month:headlines:))
        self.sections.sort { (lhs, rhs) in lhs.month < rhs.month }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.headlines.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        // Sets the values for the labels and the header
        let section = self.sections[indexPath.section]
        let headline = section.headlines[indexPath.row]
        cell.textLabel?.text = headline.title
        cell.detailTextLabel?.text = headline.text
        cell.imageView?.image = UIImage(named: headline.image)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        let date = section.month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    //Computes the first day of the month for a given date
    private func firstDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
}
