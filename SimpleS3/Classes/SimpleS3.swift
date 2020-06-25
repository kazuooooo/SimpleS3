
//
//  S3Uploader.swift
//  SokkuriApp
//
//  Created by 松本和也 on 2020/06/25.
//  Copyright © 2020 松本和也. All rights reserved.
//

import Foundation
import AWSS3

public struct SimpleS3 {
    static var bucketName: String!
    
    public static func setUp(
        region: AWSRegionType,
        identityPoolId: String,
        defaultBucketName: String
    ) {
        
        // Init Cognito
        let credentialsProvider = AWSCognitoCredentialsProvider(
           regionType: region,
           identityPoolId: identityPoolId
        )

        let configuration = AWSServiceConfiguration(
            region: region,
            credentialsProvider:credentialsProvider
        )

        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        self.bucketName = defaultBucketName
    }

    public static func uploadObject(
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
    
    public static func deleteObject(
        fileName: String,
        handler: @escaping (_ : Result<Bool, Error>) -> Void
    ) {
        let s3 = AWSS3.default()
        let deleteObjectRequest = AWSS3DeleteObjectRequest()!
        deleteObjectRequest.bucket = bucketName
        deleteObjectRequest.key = fileName
        
        s3.deleteObject(deleteObjectRequest).continueWith(block: { (task:AWSTask) -> AnyObject? in
            if let error = task.error {
                print("Error occurred: \(error)")
                handler(.failure(error))
                return nil
            }
            print("Deleted successfully.")
            handler(.success(true))
            return nil
        })
    }
}

public enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
}
