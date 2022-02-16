//
//  StaggeredGrid.swift
//  StaggereGrid0908
//
//  Created by 张亚飞 on 2021/9/8.
//

import SwiftUI

// custom view builder...

// T -> is to hold identifiable collection of data...

struct StaggeredGrid<Content: View, T: Identifiable>: View where T : Hashable {
    
    //it will return each object from collection to build view...
    var content: (T) -> Content
    
    var list: [T]
    
    // Columns...
    var columns: Int
    
    // properties...
    var showsIndeicators: Bool
    var spacing: CGFloat
    init(columns: Int = 1,showsIndeicators: Bool = false, spacing: CGFloat = 24,list: [T], @ViewBuilder content: @escaping (T) -> Content) {
        
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showsIndeicators = showsIndeicators
        self.columns = columns
    }
    
    //staggered grid function..
    func SetUpList() -> [[T]] {
        
        // creating empty sub arrays of columns count...
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        // spiliting array for Vstack oriented view...
        var currentIndex : Int = 0
        
        for object in list {
            
            gridArray[currentIndex].append(object)
            
            if currentIndex == (columns - 1) {
                
                currentIndex = 0
            }
            else {
                
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {
        
        VStack {
            
            ScrollView(.vertical, showsIndicators: showsIndeicators) {
                
                HStack(alignment: .top) {
                    
                    ForEach(SetUpList(), id: \.self) { columnsData in
                        
                        // for optimized using lazyStack...
                        LazyVStack(spacing: spacing) {
                            ForEach(columnsData) {object in
                                
                                content(object)
                                    .padding(.horizontal,4)
                                    
                            }
                        }
                        
                       
                    }
                    
                 
                    
                }
            
               
                //only vertical padding...
                //horizonatal padding will be user's optional...
                .padding(.vertical)
     
            
            }
          
        }
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
   
        AdvertismentView()
        
    }
}
