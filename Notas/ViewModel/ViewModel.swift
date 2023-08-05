//
//  ViewModel.swift
//  Notas
//
//  Created by Giggs on 04/12/22.
//

import Foundation
import CoreData
import SwiftUI


class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    
    //Guardar
    func saveNota(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do {
            
            try context.save()
            print("Guardo")
            //Cierra la ventana modal
            show.toggle()
            
        } catch let error as NSError {
 
            print("No guardo", error.localizedDescription)
            
        }
    }
    
    func deleteNota(item: Notas, context: NSManagedObjectContext) {
        context.delete(item)
        
        do {
            
            try context.save()
            print("Elimino")
            
            
        } catch let error as NSError {
 
            print("No Elimino", error.localizedDescription)
            
        }
        
    }
    func sendDatos(item: Notas){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    func editNota(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("edito")
            show.toggle()
        } catch let error as NSError {
            print("No edito", error.localizedDescription)
        }
    }
    
//    func sendDatos(item: Notas){
//        updateitem = item
//
//        nota = item.nota ?? ""
//        fecha = item.fecha ?? Date()
//
//        //self.show.toggle()
//        print("ventana")
//    }
//
//
//    func editNota(context: NSManagedObjectContext) {
//
//        updateitem.fecha = fecha
//        updateitem.nota = nota
//        print("jsdkfjll")
//        do {
//            try context.save()
//            print("Edito")
//            show.toggle()
//        } catch let error as NSError {
//            print("No edito", error.localizedDescription)
//        }
//
//    }
    
}

