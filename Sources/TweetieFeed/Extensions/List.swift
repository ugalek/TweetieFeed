//
//  List.swift
//  
//
//  Created by Galina on 18/01/2023.
//

import SwiftUI

/**
 Custom extension to apply a `ListStyle`.
 
 SupportDocs uses a custom enum (`SupportOptions.CustomListStyle`) that wraps SwiftUI's `ListStyle`. This is because `ListStyle` conforms to a generic, which makes it hard to store as a property inside `SupportOptions`.
 */
internal extension List {
    @ViewBuilder
    func listStyle(for customListStyle: TweetieFeedUISettings.CustomListStyle) -> some View {
        switch customListStyle {
        case .defaultListStyle:
            listStyle(DefaultListStyle())
        case .plainListStyle:
            listStyle(PlainListStyle())
        case .groupedListStyle:
            listStyle(GroupedListStyle())
        case .insetGroupedListStyle:
            if #available(iOS 14.0, *) {
                listStyle(InsetGroupedListStyle())
            } else {
                listStyle(DefaultListStyle())
            }
        case .insetListStyle:
            if #available(iOS 14.0, *) {
                listStyle(InsetListStyle())
            } else {
                listStyle(DefaultListStyle())
            }
        case .sidebarListStyle:
            if #available(iOS 14.0, *) {
                listStyle(SidebarListStyle())
            } else {
                listStyle(DefaultListStyle())
            }
        }
    }
}
