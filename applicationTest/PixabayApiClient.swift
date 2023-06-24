import RxSwift

class PixabayApiClient {
    
    private let apiKey = "18021445-326cf5bcd3658777a9d22df6f"
    private let apiUrl = "https://pixabay.com/api/?key="
    
    func getPixbayPicture(search:String = "") -> Observable<PixabayResponse> {
        return Observable.create { observer in
            guard let url = URL(string: self.apiUrl + self.apiKey + "&q=" + search + "&image_type=photo") else {
                observer.onError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PixabayResponse.self, from: data ?? Data())
                    observer.onNext(response)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
