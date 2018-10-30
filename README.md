
# Build an example app using Sync API and Persistence Library with Contentstack’s iOS SDK

The [Persistence Library](https://www.contentstack.com/docs/guide/synchronization/using-realm-persistence-library-with-ios-sync-sdk) lets you store data on the device’s local storage, helping you create apps that can work offline too.

This is an example app built using Contentstack’s iOS SDK, Sync API, and Persistence Library. You can try out and play with our Sync API and data persistence with this example app, before building bigger and better applications.

Perform the steps given below to get started with this app.

## Prerequisites

-   [Xcode 7.0 and later](https://developer.apple.com/xcode/)
-   Mac OS X 10.10.4 and later
-   [Contentstack account](https://www.app.contentstack.com/)
-   [Basic knowledge of Contentstack](https://www.contentstack.com/docs/)

In this tutorial, we will first go through the steps involved in configuring Contentstack and then look at the steps required to customize and use the presentation layer.

## Step 1: Create a stack

Log in to your Contentstack account, and [create a new stack](https://www.contentstack.com/docs/guide/stack#create-a-new-stack). Read more about [stack](https://www.contentstack.com/docs/guide/stack).

## Step 2: Add a publishing environment

[Add a publishing environment](https://www.contentstack.com/docs/guide/environments#add-an-environment) to publish your content in Contentstack. Provide the necessary details as per your requirement. Read more about [environments](https://www.contentstack.com/docs/guide/environments).

## Step 3: Import content types

For this app, we need one content type: Session. Here’s what it is needed for:

-   Session: Lets you add the session content to your app

For quick integration, we have already created the content type. [Download the content types](https://drive.google.com/open?id=1q6JlsAhFjYKnWmMllUrNY4NQMP0ZnEIW) and [import](https://www.contentstack.com/docs/guide/content-types#importing-a-content-type) it to your stack. (If needed, you can [create your own content types](https://www.contentstack.com/docs/guide/content-types#creating-a-content-type). Read more about [Content Types](https://www.contentstack.com/docs/guide/content-types).)

Now that all the content types are ready, let’s add some content for your Stack.

## Step 4: Add content

[Create](https://www.contentstack.com/docs/guide/content-management#add-a-new-entry) and [publish](https://www.contentstack.com/docs/guide/content-management#publish-an-entry) entries for the ‘Session’ content type.

Now that we have created the sample data, it’s time to use and configure the presentation layer.

## Step 5: Clone and configure the application

To get your app up and running quickly, we have created a sample app. Clone the Github repo given below and change the configuration as per your need:

```
$ git clone  https://github.com/contentstack/contentstack-ios-persistence-example.git
```

Now add your Contentstack API Key, Delivery Token, and Environment to the ```APIManager.swift``` file within your project. (Find your [Stack's API Key and Delivery Token](https://www.contentstack.com/docs/apis/content-delivery-api/#authentication).)

```
class StackConfig {
    static var APIKey = "API_KEY"
    static var AccessToken = "DELIVERY_TOKEN"
    static var EnvironmentName = "ENVIRONMENT"
    static var _config : Config {
        get {
            let config = Config()
            config.host = "URL"
            return config
        }
    }
}
```

## Step 6: Install ContentstackPersistenceRealm iOS SDK

You can configure the SDK in two ways – installation using CocoaPods and manual installation.

### Method 1: Using Cocoapods

Add the following command to your Podfile:
```
pod 'ContentstackPersistenceRealm'
```
Then, run the command given below to get the latest release of Contentstack.
```
pod install
```
### Method 2: Manual method

1.  Download and set up the Contentstack iOS Persistence Library.
```
https://github.com/contentstack/contentstack-ios-persistence.git
```
2.  You will find the ContentstackPersistence folder, which contains the following four files:
-   SyncManager.h
-   SyncManager.m
-   SyncPersistable.h
-   SyncProtocol.h

3. You will find the ContentstackPersistenceRealm folder, which contains the following Two files:
-   RealmStore.h
-   RealmStore.m

4.  Add the ContentstackPersistence and ContentstackPersistenceRealm folder to your project.
5.  Add the Bridge.h header file. Import the SyncManager.h file using the command given below:
```
#import "SyncManager.h"
```

## Step 7: Install and set up Realm
If you have downloaded Contentstack Persistence Library, then the next step is to downloakd and set up Realm. To do so, perform the steps given below:

1. Download the latest version of [Realm](https://realm.io/docs/objc/latest/) for Objective C.
2. In your Podfile, add pod named ```'Realm'``` to your ‘app’ targets.
3. From the command line, run pod install.
4. Use the .xcworkspace file generated by CocoaPods to work on your project.

## Step 8: Map data

There are three important items to be mapped in the synchronization process:

-   Sync token/pagination token
-   Entries
-   Assets

Let’s look at how each of the above can be mapped.

### Sync token/pagination token
To save the Sync Token and Pagination Token, you need to create a new file (File > New > File) named SyncStore extending RLMObject,  and add the following code to implement SyncStoreProtocol:
```
class SyncStore: RLMObject, SyncStoreProtocol {
@objc dynamic var syncToken: String!
@objc dynamic var paginationToken: String!
}
```
### Entry Mapping
To begin with, let’s consider an example of a Conference app. Let’s say you have a content type called 'Session', and you want to implement it.

Create a new file (File > New > File) named Session, extending RLMObject,  and add following code to implement EntityProtocol, as shown below:
```
class Session: RLMObject, EntryProtocol {
    @objc dynamic var sessionId = 0
    @objc dynamic var type: String!
    @objc dynamic var title: String!
    @objc dynamic var desc: String!
    @objc dynamic var url: String!
    @objc dynamic var uid: String!
    @objc dynamic var publishLocale: String!
    @objc dynamic var createdAt: Date!
    @objc dynamic var updatedAt: Date!
    @objc dynamic var locale: String!
    @objc dynamic var isPopular = false
    @objc dynamic var startTime: Date!
    @objc dynamic var endTime: Date!

    static func contentTypeid() -> String! {
        return "session"
    }
    static func fieldMapping() -> [AnyHashable : Any]! {
        return ["sessionId":"session_id",
        "desc": "description",
        "type":"type",
        "isPopular":"is_popular",
        "startTime":"start_time",
        "endTime":"end_time"]
    }
}
```
In the above code, we have to implement contentTypeid for which you are mapping the Entry content type.

You also need to implement the fieldMapping function, which returns the mapping of the attributes and entry fields in Contentstack.

Similarly, we can add other entries and perform mapping for each entry.

### Assets Mapping
To save assets, create a new file (File > New > File) named Assets, extending RLMObject, and add the following code to implement AssetProtocol.

```
class Assets: RLMObject, AssetProtocol{
@objc dynamic var publishLocale: String!
@objc dynamic var title: String!
@objc dynamic var uid: String!
@objc dynamic var createdAt: Date!
@objc dynamic var updatedAt: Date!
@objc dynamic var fileName: String!
@objc dynamic var url: String!
}
```

Now, the final step is to initiate SyncManager and begin with the sync process.

## Step 9: Initiate SyncManager and Sync

After content mapping is done, initiate SyncManager by providing the required details:
```
static var stack : Stack = Contentstack.stack(withAPIKey: StackConfig.APIKey, accessToken: StackConfig.AccessToken, environmentName: StackConfig.EnvironmentName, config:StackConfig._config)

var realmStore = RealmStore(realm: try? RLMRealm(configuration: RLMRealmConfiguration.default()))

var syncManager : SyncManager = SyncManager(stack: stack, persistance: realmStore)

self.syncManager.sync { (totalCount, loadedCount, error) in

}
```
This will initiate your project.

<img src='https://lh3.googleusercontent.com/DzdkSx-GQ0TRRTKqKCNkaPJSgh35opZnFybGl7eqpTErkcT6uYgGtp2s6srRHon-KwC4mirsuCuGA9PWVTvOWNujB5W0Z5AImtTlKley86k-07i5cZXZv4m03ND9_UJtk2WLz2Hs' width='300' height='550'/>

## More Resources

-   [Getting started with iOS SDK](https://www.contentstack.com/docs/platforms/ios)
-   [Using the Sync API with iOS SDK](https://www.contentstack.com/docs/guide/synchronization/using-the-sync-api-with-ios-sdk)
-   [Using Persistence Library with iOS SDK](https://www.contentstack.com/docs/guide/synchronization/using-realm-persistence-library-with-ios-sync-sdk)
-   [iOS Persistence Library](https://github.com/contentstack/contentstack-iOS-persistence)
