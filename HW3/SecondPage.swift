//
//  SecondPage.swift
//  HW3
//
//  Created by User20 on 2020/5/3.
//  Copyright © 2020 00657143. All rights reserved.
//

import SwiftUI

struct SecondPage: View {
    @Binding var showSecondPage: Bool
    @Binding var name: Int
    var roles = ["卡斯帕爾(五年後)", "伊古納茲(五年後)", "多洛緹雅(五年後)", "希爾凡(五年後)", "希爾妲(五年後)", "貝爾娜提塔(五年後)", "亞修(五年後)", "佩托拉(五年後)", "拉斐爾(五年後)", "林哈爾特(五年後)", "洛廉茲(五年後)", "英谷莉特(五年後)", "梅爾賽德司(五年後)", "莉斯提亞(五年後)", "菲力克斯(五年後)", "菲爾迪南特(五年後)", "雅妮特(五年後)", "雷歐妮(五年後)", "瑪莉安奴(五年後)"]
    @Binding var gender: String
    @Binding var heigh: Int
    @Binding var organization: String
    @Binding var experience: CGFloat
    @Binding var startDate: Date
    @Binding var notation: Bool
    @Binding var notationContent: String
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    @State private var showAlert = false
    @State private var showSort = false
    @State private var showPic = false
    @State private var sort = 1
    var sortClass = ["不喜歡", "普普通通", "我的最愛"]
    

    
    var body: some View {
        VStack{
            Text("角色資料")
            HStack {
                Image(roles[name])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipped()
                    .border(Color.gray, width: 4)
                VStack(alignment: .leading){
                    Text("資料分類: \(sortClass[sort])")
                    Button(action: {self.showSort = true}){
                        Text("選擇分類")
                    }
                    .actionSheet(isPresented: self.$showSort){
                        ActionSheet(title: Text("選擇分類"), message:Text("對角色喜惡程度"), buttons: [
                            .default(Text("不喜歡"), action:{
                                self.sort = 0
                                self.showPic = true
                                
                            })
                            ,.default(Text("普普通通"), action:{
                                self.sort = 1
                                self.showPic = true
                            })
                            ,.default(Text("我的最愛"), action:{
                                self.sort = 2
                                self.showPic = true
                            })
                        ])
                    }
                    Text("名字: \(roles[name])")
                }
            }
            HStack {
                VStack(alignment: .leading){
                    Text("性別: \(gender)")
                    Text("身高: \(heigh) cm")
                    Text("效忠國家: \(organization)")
                    Text("戰鬥經驗: \(Int(experience)+5) 年")
                    Text("挖角日期: \(dateFormatter.string(from: startDate))")
                    if notation{
                        Text("註記:\(notationContent)")
                    }
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width * 12 / 17)
            
            PicView(showPic: $showPic, sort: $sort)
            
            HStack{
                Button(action: {self.showAlert = true}){
                    HStack{
                        Text("添加資料")
                            .fontWeight(.heavy)
                        Image(systemName: "folder.badge.plus")
                    }
                    .padding()

                    .frame(width: 140, height: 50)
                }
                .alert(isPresented: self.$showAlert){ () -> Alert in
                    return Alert(title: Text("已添加到\(sortClass[sort])"))
                }
                Spacer()
                Button(action: {self.showSecondPage = false}){
                    HStack {
                        Text("重新填寫")
                            .fontWeight(.heavy)
                        Image(systemName: "trash")
                    }
                        
                    .padding()
                    .frame(width: 130, height: 50)
                }
            }
            .offset(y:80)
            .frame(width: UIScreen.main.bounds.width * 8 / 11)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Image("背景2").resizable().frame(width: UIScreen.main.bounds.width).opacity(0.7))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SecondPage_Previews: PreviewProvider {
    static var previews: some View {
        SecondPage(showSecondPage: .constant(true), name: .constant(0), gender: .constant("女"), heigh: .constant(165), organization: .constant("阿德剌斯忒亞帝國"), experience: .constant(11), startDate: .constant(Date()), notation: .constant(true), notationContent: .constant("哈哈"))
    }
}

struct PicView: View {
    @Binding var showPic: Bool
    @Binding var sort: Int
    var sortClass = ["不喜歡", "普普通通", "我的最愛"]
    
    var body: some View {
        ZStack{
            if showPic {
                if sort == 0{
                    Image(sortClass[0])
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 70, height: 220)
                        .clipped()
                        .contextMenu{
                            Button(action:{
                                self.sort = 1
                            }){
                                Text("普普通通")
                                Image(systemName: "folder")
                            }
                            Button(action:{
                                self.sort = 2
                            }){
                                Text("我的最愛")
                                Image(systemName: "heart")
                            }
                    }
                    .transition(.opacity)
                }else if sort == 1{
                    Image(sortClass[1])
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 70, height: 220)
                        .clipped()
                        .contextMenu{
                            Button(action:{
                                self.sort = 0
                                self.showPic = true
                            }){
                                Text("不喜歡")
                                Image(systemName: "hand.thumbsdown")
                            }
                            Button(action:{
                                self.sort = 2
                                self.showPic = true
                            }){
                                Text("我的最愛")
                                Image(systemName: "heart")
                            }
                    }
                    .transition(.opacity)
                }else if sort == 2{
                    Image(sortClass[2])
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 70, height: 220)
                        .clipped()
                        .contextMenu{
                            Button(action:{
                                self.sort = 0
                                self.showPic = true
                            }){
                                Text("不喜歡")
                                Image(systemName: "hand.thumbsdown")
                            }
                            Button(action:{
                                self.sort = 1
                                self.showPic = true
                            }){
                                Text("普普通通")
                                Image(systemName: "folder")
                            }
                    }
                    .transition(.opacity)
                }
            }else{
                Image(sortClass[1])
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 70, height: 220)
                    .clipped()
                    .contextMenu{
                        Button(action:{
                            self.sort = 0
                            self.showPic = true
                        }){
                            Text("不喜歡")
                            Image(systemName: "hand.thumbsdown")
                        }
                        Button(action:{
                            self.sort = 2
                            self.showPic = true
                        }){
                            Text("我的最愛")
                            Image(systemName: "heart")
                        }
                }
            }
        }
        .animation(.easeInOut(duration: 3))
        .offset(y:50)
    }
}

