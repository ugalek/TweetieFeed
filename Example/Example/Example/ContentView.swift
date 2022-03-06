//
//  ContentView.swift
//  Example
//
//  Created by Galina on 06/03/2022.
//

import SwiftUI
import TweetieFeed

struct ContentView: View {
    @ObservedObject var viewModel: ExampleViewModel
    @State private var apiVersion = TwitterAPIVersion.v1

    var body: some View {
        VStack {
            VStack {
                Text("Twitter API \(apiVersion.rawValue)")
                    .onChange(of: apiVersion) { newValue in
                        viewModel.getData(version: newValue)
                    }
                Picker("Twitter API?", selection: $apiVersion) {
                    ForEach(TwitterAPIVersion.allCases, id: \.rawValue) { version in
                        Text(version.rawValue).tag(version)
                    }
                }
                .pickerStyle(.segmented)
            }
              
            if viewModel.dataReceived {
                TweetieFeedView(tweetieDecoder: viewModel.feedDecoder!)
            }
        }
        .onAppear {
            viewModel.getData(version: apiVersion)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ExampleViewModel())
            .environmentObject(TweetieFeedUISettings())
    }
}
