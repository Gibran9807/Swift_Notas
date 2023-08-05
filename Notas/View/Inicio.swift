//
//  Inicio.swift
//  Notas
//
//  Created by Giggs on 04/12/22.
//

import SwiftUI

struct Inicio: View {
    
    
    var body: some View {
        NavigationView{
            VStack{
                TopBar().shadow(radius: 10)
                ListaNotas().shadow(radius: 10)
                Spacer()
                ButtonAdd()
                
            }
        
            
        }
    }

}

struct ButtonAdd: View {
    @StateObject var model = ViewModel()

    var body: some View  {

        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        model.show.toggle()
                    })
                    {
                        Image(systemName: "plus")
                    }   .padding(20)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(50)
                        .shadow(radius: 5 )
                        .sheet(isPresented: $model.show, content: {
                            An_adir(model: model)
                        })
                }.padding(.trailing, 30)

            }
        }.frame( height: 75, alignment: .center)
    }
}


struct TopBar : View {
    var body: some View {
        VStack (spacing: 20){
            HStack {
                Spacer()
            }
        }.padding(.top,(UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.blue)


    }
}

struct ListaNotas: View {
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results : FetchedResults<Notas>

    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {

        List{
            ForEach(results){ item in
                VStack(alignment: .leading){
                    Text(item.nota ?? "Sin nota")
                        .font(.title)
                        .bold()
                    Text(item.fecha ?? Date(), style: .date)
                }.contextMenu(ContextMenu(menuItems: {
                    Button(action:{
                        model.sendDatos(item: item)
                    }){
                        Label(title:{
                            Text("Editar")
                        }, icon:{
                            Image(systemName: "pencil")
                        })
                    }
                    Button(action:{
                        model.deleteNota(item: item, context: context)
                    }){
                        Label(title:{
                            Text("Eliminar")
                        }, icon:{
                            Image(systemName: "trash")
                        })
                    }
                }))
            }
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle(Text("Notas App"))
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(trailing:
                                Button(action:{
                                    model.show.toggle()
        }){
                                    Image(systemName: "plus")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.blue)
        }.disabled(true)
        ).sheet(isPresented: $model.show, content: {
            An_adir(model: model)
        })
    
    }
    
}


struct Inicio_Previews: PreviewProvider {
    static var previews: some View {
        Inicio()
            .previewDevice("iPhone 11")
    }
}

