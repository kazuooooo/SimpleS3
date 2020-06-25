
//
//  S3Uploader.swift
//  SokkuriApp
//
//  Created by 松本和也 on 2020/06/25.
//  Copyright © 2020 松本和也. All rights reserved.
//

import Foundation
import AWSS3

public class SimpleS3 {
    public static func initCognito(
        region: AWSRegionType,
        identityPoolId: String
    ){
        let credentialsProvider = AWSCognitoCredentialsProvider(
           regionType: region,
           identityPoolId: identityPoolId
        )

        let configuration = AWSServiceConfiguration(
            region: region,
            credentialsProvider:credentialsProvider
        )

        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }

    public static func uploadObject(
        bucketName: String,
        fileName: String,
        data: Data,
        contentType: String, // ex) "image/png",
        uploadProgressBlock: AWSS3TransferUtilityProgressBlock?,
        completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    ) {
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = uploadProgressBlock
        
        let transferUtility = AWSS3TransferUtility.default()

        transferUtility.uploadData(
            data,
            bucket: bucketName,
            key: fileName,
            contentType: contentType,
            expression: expression,
            completionHandler: completionHandler
        )
    }
    
    public static func deleteObject(bucketName: String, fileName: String){
        
    }
}
