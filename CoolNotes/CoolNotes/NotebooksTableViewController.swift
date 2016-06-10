//
//  NotebooksTableViewController.swift
//  CoolNotes
//
//  Created by KEITH GROUT on 6/8/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import UIKit
import CoreData

class NotebooksTableViewController: CoreDataTableViewController {

    @IBAction func addNotebook(sender: UIBarButtonItem) {
        let newNotebook = Notebook(name: "New Notebook",
                           context: fetchedResultsController!.managedObjectContext)
        print("Create a new note: \(newNotebook)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Çøøl Nø†es"
        
        // get the stack
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let stack = appDelegate.stack
        
        // create the fetch request
        let fr = NSFetchRequest(entityName: "Notebook")
        fr.sortDescriptors = [NSSortDescriptor(key:"name", ascending: true), NSSortDescriptor(key:"creationDate", ascending: false)]
        
        // create a fetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // find the notebook
        let notebook = fetchedResultsController?.objectAtIndexPath(indexPath) as! Notebook
        
        // create the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("NotebookCell", forIndexPath: indexPath)
        
        // sync notebook to cell
        cell.textLabel?.text = notebook.name
        cell.detailTextLabel?.text = "\(notebook.notes!.count) notes"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "displayNote" {
            if let notesVC = segue.destinationViewController as? NotesTableViewController {
                // create fetch request
                let fr = NSFetchRequest(entityName: "Note")
                
                fr.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false),
                                      NSSortDescriptor(key: "text", ascending: true)]
                
                // find the notebook
                let indexPath = tableView.indexPathForSelectedRow!
                let notebook = fetchedResultsController?.objectAtIndexPath(indexPath) as? Notebook
                
                let pred = NSPredicate(format: "notebook = %@", argumentArray: [notebook!])
                fr.predicate = pred
                
                let fetchedRC = NSFetchedResultsController(fetchRequest: fr,
                                                           managedObjectContext: fetchedResultsController!.managedObjectContext,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
                
                notesVC.fetchedResultsController = fetchedRC
                notesVC.notebook = notebook
                
            }
        }
    }
    

}
