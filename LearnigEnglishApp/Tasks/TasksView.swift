//
//  TasksView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 02.04.2024.
//

import SwiftUI

struct TasksView: View {
    
    @ObservedObject private var vm = TaskViewModel()
    
    var body: some View {
//        NavigationView {
            ScrollView {
                HStack {
                    
                    NavigationLink {
                        TaskView()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color(.systemGreen))
                                .cornerRadius(15)
                            Text("1st")
                                .foregroundStyle(.white)
                                .font(.system(size: 55, weight: .thin, design: .rounded))
                        }
                    }
                    .shadow(radius: 10)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color(.systemGreen))
                                .cornerRadius(15)
                            Text("2nd")
                                .foregroundStyle(.white)
                                .font(.system(size: 55, weight: .thin, design: .rounded))
                        }
                        
                    }
                    .shadow(radius: 10)
                }
                .padding(.vertical)
                .padding(.horizontal, 25)
                
                HStack {
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color(.systemGreen))
                                .cornerRadius(15)
                            Text("3rd")
                                .foregroundStyle(.white)
                                .font(.system(size: 55, weight: .thin, design: .rounded))
                        }
                    }
                    .shadow(radius: 10)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color(.systemGreen))
                                .cornerRadius(15)
                            Text("4th")
                                .foregroundStyle(.white)
                                .font(.system(size: 55, weight: .thin, design: .rounded))
                        }
                    }
                    .shadow(radius: 10)
                }
                .padding(.vertical)
                .padding(.horizontal, 25)
            }
//        }
    }
}

#Preview {
    TasksView()
}
