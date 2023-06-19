//
//  LikeDislikePostApi.swift
//  soundchattv
//
//  Created by RAJKUMAR on 19/06/23.
//

import Foundation
import Alamofire

func likeDislikePost(timelineId: String, likeIconId: String){
    AF.request("\(baseUrl)addtimelinelikes", method: .post, parameters: ["timeline_id": timelineId, "likes_icon_id": likeIconId, "user_id": getUserId().description], encoder: JSONParameterEncoder.json)
            .responseDecodable(of: LoginResponse.self) { response in
                if(response.error == nil){
                    print(response.value.debugDescription);
                    if(response.value?.status == 200){
                        
                    }else{
                        print(response.value!.message!)
//                        message = response.value!.message!
//                        showToast.toggle()
                    }
                    
                }else{
                    print(response.error!.localizedDescription)
                }
                
            }
    

}
