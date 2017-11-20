
import Foundation
import Alamofire
import Unbox

struct URLConst {
    static let apiBase = "https://qiita.com/api/v2"
}

class HttpTask<T: Unboxable> {
    /// 通信タスク
    var task: DataRequest? = nil
    
    /// パス
    let path: String
    /// メソッド
    let method: HTTPMethod
    /// パラメーター
    let params: [String: Any]?
    /// ヘッダー
    let headers: [String: String]?
    
    init(path: String, method: HTTPMethod = .get, params: [String: Any]? = nil, headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
    
    /// 実行
    func execute(completion: ((T?, Error?) -> ())?) {
        if let _ = task {
            task?.cancel()
            task = nil
        }
        
        let url = URLConst.apiBase + path
        print("url is ", url)
        
        task = Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers)
        
        task?.responseJSON(queue: .main, options: .allowFragments, completionHandler: { [weak self] (res) in
            guard res.result.isSuccess, let data = res.data else {
                completion?(nil, res.result.error)
                self?.task = nil
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            var entity: T?
            var error: Error?
            
            do {
                let e: T = try unbox(data: data)
                entity = e
            } catch let e {
                error = e
            }
            
            completion?(entity, error)
            self?.task = nil
        }).resume()
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}
