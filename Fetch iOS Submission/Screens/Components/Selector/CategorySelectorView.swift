//
//  CategorySelectorView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/22/24.
//

import SwiftUI
import CachedAsyncImage

struct CategorySelectorView: View {
    @Binding var selectedCategory: MealCategory
    @Binding var mealCatagories: [MealCategory]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(mealCatagories) { category in
                    HStack {
                        CachedAsyncImage(url: URL(string: category.strCategoryThumb ?? "")) { image in
                            image
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                            
                        } placeholder: {
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                        }
                        
                        Text(category.strCategory ?? "Desserts")
                            .font(.system(size: 18,
                                          weight: selectedCategory == category ? .bold : .light))
                            .lineLimit(1)
                            .padding(.leading, 10)
                            .scaledToFill()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background{
                        Capsule()
                            .foregroundColor(.white.opacity(0.75))
                    }
                    .shadow(radius: 3)
                    .onTapGesture {
                        selectedCategory = category
                    }
                    
                }
            }
        }
        .scrollIndicators(.never)
        .padding(.bottom, 6)
        .padding(.horizontal, 6)
    }
}


#Preview {
    CategorySelectorView(
        selectedCategory: .constant(MealCategory.DevData.mealCategory),
        mealCatagories: .constant(MealCategory.DevData.mealCategoryCollection))
}
