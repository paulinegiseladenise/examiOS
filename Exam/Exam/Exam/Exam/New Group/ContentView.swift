//
//  ContentView.swift
//  Exam
//
//  Created by Pauline Broängen on 2022-11-07.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @StateObject var diary = Diary()
    @State var showPopup = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if dbConnection.userLoggedIn {
                    NavigationView {
                        MainDiaryView(diary: diary, showPopup: $showPopup).blur(radius: showPopup ? 3 : 0)
                        
                            .toolbar { ToolbarItem(placement: .automatic, content: {
                                
                                Text("+").font(.system(size: 32)).onTapGesture {
                                    withAnimation {
                                        showPopup = true
                                        
                                    }
                                }
                            })
                            }
                    }
                    if showPopup {
                        PopupView(diary: diary, showPopup: $showPopup)
                    }
                } else {
                    NavigationView {
                        LoginView()
                        RegisterView()
                    }
                }
                
            }
            
        }.navigationTitle("Diary")
    }
}



struct PopupView: View {
    
    @ObservedObject var diary: Diary
    @Binding var showPopup: Bool
    
    @State var diaryTitle = ""
    @State var diaryContent = ""
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 10) {
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Skriv en titel")
                    TextField("", text: $diaryTitle).textFieldStyle(.roundedBorder).foregroundColor(.black)
                    
                    Text("Lägg till innehåll")
                    TextEditor(text: $diaryContent).cornerRadius(5).foregroundColor(.black)
                    
                    
                }.padding()
                
                
                
                
                Button(action: {
                    if diaryTitle == "" || diaryContent == "" {
                        return
                    }
                    
                    diary.addPage(page: DiaryPage(diaryTitle: diaryTitle, diaryContent: diaryContent))
                    
                    showPopup = false
                    
                }, label: {
                    Text("Add to diary").bold()
                }).padding().background(.white).foregroundColor(.black)
                    .cornerRadius(9)
                
                
                Button(action: {
                    showPopup = false
                }, label: {
                    Text("Cancel")
                })
                
                
                Spacer()
                
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6, alignment: .center)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .transition(.slide)
        }
    }
}



struct MainDiaryView: View {
    
    @ObservedObject var diary: Diary
    
    @Binding var showPopup: Bool
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("This is where your pages will be...").padding()
                //ScrollView(showsIndicators: false) {
                List() {
                    
                    ForEach(diary.getPages()) {
                        page in
                        
                        NavigationLink(destination: {
                            PictureView()
                        }, label: {
                            Text(page.diaryTitle)
                        })
                        
                    }
                }
            }
        }
    }
}






struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DatabaseConnection())
        //PopupView(diary: Diary(), showPopup: .constant(true))
        //MainDiaryView(diary: Diary(), showPopup: .constant(true))
        //PictureView()
    }
}
