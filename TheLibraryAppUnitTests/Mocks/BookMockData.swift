//
//  BookMockData.swift
//  TheLibraryAppUnitTests
//
//  Created by MacBook Pro on 26/07/2565 BE.
//

import Foundation

public final class BookMockData {
    class BookList {
        public static let overview: URL = Bundle(for: BookMockData.self).url(forResource: "overview", withExtension: "json")!
        
        public static let noApiKey: URL = Bundle(for: BookMockData.self).url(forResource: "overview_fail", withExtension: "json")!
    }
    
    class SearchList {
        public static let search: URL = Bundle(for: BookMockData.self).url(forResource: "search", withExtension: "json")!
    }
}
