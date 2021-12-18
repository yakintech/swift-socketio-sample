//
//  ContentView.swift
//  SocketSample
//
//  Created by Çağatay Yıldız on 18.12.2021.
//

import SwiftUI
import SocketIO






struct ContentView: View {
    
    @State var messages = [String]()
    @State var sendmessage = ""
    let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .compress])

   
    
    var body: some View {
        VStack{
          
            
            TextField("your message: ", text: $sendmessage)
                .padding()
            
            Button("Send"){
                
                let socket = manager.defaultSocket
            
      
                socket.emit("sendermessage", sendmessage)
            }
            .padding()
            
         
            List(messages, id:\.self){item in
                Text(item)
            }
            
        }
        .onAppear(){
            let socket = manager.defaultSocket
            
            
            socket.on("newmessage") {data, ack in
              
                guard let newMessage = data[0] as? String else { return }
                
                messages.append(newMessage)
                
                print(messages)
                
            }


            socket.connect()
            
        }
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
