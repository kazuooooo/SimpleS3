# SimpleS3
Very thin s3 wrapper for swift.
Currently support only in Upload and Delete Object.

[![Version](https://img.shields.io/cocoapods/v/SimpleS3.svg?style=flat)](https://cocoapods.org/pods/SimpleS3)
[![License](https://img.shields.io/cocoapods/l/SimpleS3.svg?style=flat)](https://cocoapods.org/pods/SimpleS3)
[![Platform](https://img.shields.io/cocoapods/p/SimpleS3.svg?style=flat)](https://cocoapods.org/pods/SimpleS3)

## Installation

SimpleS3 is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleS3'
```

## Preparation
### Create S3 Bucket
Create S3 Bucket

### Create Cognito Identity Pool.

1. Access AWS Cognito, Select "Manage Identity Pools"
2. select Create new Identity pool
3. Put information for new identity pool
If you can allow access from unauthenticated user, check "Enable access to unauthenticated identities"
Then select create pool.

![New_identity_pool](https://user-images.githubusercontent.com/6919381/85688119-6ded9a00-b70c-11ea-9f6a-5107e8b9af5d.png)

4. Edit policy document for authenticated identities and unauthenticated identitties.

![Cursor_と_IAM_Management_Console](https://user-images.githubusercontent.com/6919381/85689047-4519d480-b70d-11ea-8f4d-19d9eeb71a26.png)

It is depend on your usage.
For example, you want to add S3 full access on specific bucket, unauthenticated identity policy will be like this.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetAccessPoint",
                "s3:PutAccountPublicAccessBlock",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:ListAccessPoints",
                "s3:ListJobs",
                "mobileanalytics:PutEvents",
                "s3:CreateJob",
                "s3:HeadBucket",
                "cognito-sync:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::your-bucket-name",
                "arn:aws:s3:::your-bucket-name/*"
            ]
        }
    ]
}
```


5. After creating identity pool, you will see Identity pool Id. Copy this to be used later

![Sample_code_-_Amazon_Cognito_-_Amazon_Web_Services](https://user-images.githubusercontent.com/6919381/85689872-fae52300-b70d-11ea-86c8-b1472c502798.png)


## Usage

1. Setup SimpleS3 in AppDelegate

```swift
import SimpleS3

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ...
        // Initialize Cognito
        SimpleS3.setUp(
            region: .APNortheast1,
            identityPoolId: "your-identity-pool-id-here",
            defaultBucketName: "your-bucket-name-here"
        )
        return true
    }
    ...
}
```

2. Then, you can upload and delete object easily 😄

```swift
// Upload Object
SimpleS3.uploadObject(
    fileName: "your_file_name.png",　          // File name in s3
    data: UIImage(named: "Boy2")!.pngData()!,  // Upload data 
    contentType: "image/png",                  // Content type
    uploadProgressBlock: nil)                  // Progress closure
{ (task, error) in
        if let error = error {
            print("#upload error: \(error.localizedDescription)")
        } else {
            print("#upload success")
        }
}

// Delete Object
// just pass file name
SimpleS3.deleteObject(fileName: "test.png") { result in
    switch result {
    case let .success(res):
        print("#delete success delttion!!")
    case let .failure(error):
        print("#delete error" + error.localizedDescription)
    }
}
```

## Author

kazuooooo, matsumotokazuya7@gmail.com

## License

SimpleS3 is available under the MIT license. See the LICENSE file for more info.
