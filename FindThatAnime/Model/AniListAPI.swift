import Foundation
import Apollo

struct AniListAPI {
    let aniListUrl = "https://graphql.anilist.co"
    
    func ObtainData(AnimeID: Int, completion: @escaping (QueryQuery.Data) -> Void) {

       var TheData: QueryQuery.Data
            
            let TheInfo = QueryQuery(id: AnimeID)
            
            GraphClient.fetch(query: TheInfo) { result in
                switch result {
                
                case .failure(let error):
                    print("A big no no happened retard \(error)")
                    
                case .success(let GraphQLResult):
                    guard let Info = GraphQLResult.data else {return}
                    
                    completion(Info)
                }
                
            }
    }

    
    
    
    
}
