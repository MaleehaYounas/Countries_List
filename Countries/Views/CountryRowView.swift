import SwiftUI

struct CountryRowView: View {
    let country: Country

    var body: some View {
        HStack {
            FlagImage
            VStack(alignment: .leading) {
                NameText
                RegionText
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
    
    
    var FlagImage:some View{
        AsyncImage(url: URL(string: country.flags.png)){ image in
            image
                .resizable()
                .frame(width: 40, height: 25)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                
        }
        placeholder:{
                    Color.gray.frame(width: 40, height: 25)
                }

    }
    var NameText:some View{
        Text(country.name.common)
            .font(.headline)
    }
    
    var RegionText:some View{
        Text(country.region.rawValue)
            .font(.subheadline)
            .foregroundColor(.gray)
    }
}
