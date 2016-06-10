//
//  NotesTableViewController.swift
//  CoolNotes
//
//  Created by KEITH GROUT on 6/9/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: CoreDataTableViewController {
    
    var notebook: Notebook? // muggle code
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let note = fetchedResultsController?.objectAtIndexPath(indexPath) as! Note
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = note.text
        return cell
    }
    
    @IBAction func addNote(sender: UIBarButtonItem) {
        
        if let nb = notebook, context = fetchedResultsController?.managedObjectContext {
            let newNote = Note(text: "New Note",
                               context: context)
            newNote.notebook = nb
            print("Create a new note: \(newNote)")
        }
    }
    
 
    
    
}