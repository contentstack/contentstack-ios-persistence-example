
# Build an example app using Sync API and Persistence Library with Contentstack’s iOS SDK

This is an example app built using Contentstack’s iOS SDK, Sync API, and Persistence Library. You can try out and play with our Sync API and data persistence with this example app, before building bigger and better applications.

The [Persistence Library](https://www.contentstack.com/docs/guide/synchronization/using-realm-persistence-library-with-ios-sync-sdk) lets you store data on the device’s local storage, helping you create apps that can work offline too. Perform the steps given below to use the app.

## Prerequisites

-   [Xcode 7.0 and later](https://developer.apple.com/xcode/)
-   Mac OS X 10.10.4 and later
-   [Contentstack account](https://www.app.contentstack.com/)
-   [Basic knowledge of Contentstack](https://www.contentstack.com/docs/)

In this tutorial, we will first go through the steps involved in configuring Contentstack and then look at the steps required to customize and use the presentation layer.

## Step 1: Create a stack

Log in to your Contentstack account, and [create a new stack](https://www.contentstack.com/docs/guide/stack#create-a-new-stack). Read more about [stacks](https://www.contentstack.com/docs/guide/stack).

## Step 2: Add a publishing environment

[Add a publishing environment](https://www.contentstack.com/docs/guide/environments#add-an-environment) to publish your content in Contentstack. Provide the necessary details as per your requirement. Read more about [environments](https://www.contentstack.com/docs/guide/environments).

## Step 3: Import content types

For this app, we need one content type: Session. Here’s what it is needed for:

-   Session: Lets you add the session content to your app

For quick integration, we have already created the content type. [Download the content types](https://drive.google.com/open?id=1q6JlsAhFjYKnWmMllUrNY4NQMP0ZnEIW) and [import](https://www.contentstack.com/docs/guide/content-types#importing-a-content-type) it to your stack. (If needed, you can [create your own content types](https://www.contentstack.com/docs/guide/content-types#creating-a-content-type). Read more about [Content Types](https://www.contentstack.com/docs/guide/content-types).)

Now that all the content types are ready, let’s add some content for your Sync Playground app.

## Step 4: Adding content

[Create](https://www.contentstack.com/docs/guide/content-management#add-a-new-entry) and [publish](https://www.contentstack.com/docs/guide/content-management#publish-an-entry) entries for the ‘Session’ content type.

Now that we have created the sample data, it’s time to use and configure the presentation layer.

## Step 5: Set up and initialize iOS SDK

To set up and initialize Contentstack’s iOS SDK, refer to our documentation[
](https://www.contentstack.com/docs/platforms/ios#getting-started).

## Step 6: Clone and configure the application

To get your app up and running quickly, we have created a sample app. Clone the Github repo given below and change the configuration as per your need:

```
$ git clone  https://github.com/contentstack/contentstack-ios-persistence-example.git
```

Now add your Contentstack API Key, Delivery Token, and Environment to the APIManager.swift file within your project. (Find your [Stack's API Key and Delivery Token](https://www.contentstack.com/docs/apis/content-delivery-api/#authentication).)

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

## Step 7: Install Contentstack iOS SDK and SyncManager

Now that your Realm framework is ready, let's look at the steps involved in setting up your Contentstack SDK.

1.  Download and set up the Contentstack iOS SDK. Read the [Contentstack iOS SDK Documentation](https://www.contentstack.com/docs/platforms/ios) for more details.
2.  Download the current folder of Persistence Library from GitHub and unzip it. You will find the SyncWrapper folder, which contains the following six files:
        -   SyncManager.h
        -   SyncManager.m
        -   RealmPersistenceHelper.h
        -   RealmPersistenceHelper.m
        -   SyncPersistable.h
        -   SyncProtocol.h
3.  Add the SyncWrapper folder to your project.
4.  Add the Bridge.h header file. Import the SyncManager.h file using the command given below:
```
#import "SyncManager.h"
```
## Step 8: Map data

There are three important items to be mapped in our Synchronization process:

-   Sync token/pagination token
-   Entries
-   Assets

Let’s look at how each of the above can be mapped.

### Sync token/pagination token
To save the sync token and pagination token, you need to create a new file (File > New > File) named SyncStore extending RLMObject,  and add the following code to implement SyncStoreProtocol:
```
class SyncStore: RLMObject, SyncStoreProtocol {
    @objc dynamic var syncToken: String!
    @objc dynamic var paginationToken: String!
}
```
### Entry
To begin with, let’s consider an example of a Conference app. Let’s say we have a content type: Session. Let’s see how to implement this example.
Create a new file (File > New > File) named Session  extending RLMObject,  and add following code to implement EntityProtocol  as shown below:
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
In the above code, we have to implement contentTypeid  for which you are mapping the Entry content type.

You also need to implement the fieldMapping  function, which returns the mapping of the attributes and entry fields in Contentstack.

Similarly, we can add other entities and perform mapping for each entity.

### Asset
To save assets, create a new file (File > New > File) named  Assets  extending RLMObject,  and add the following code to implement AssetProtocol.

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

After setting up the content mapping, initiate SyncManager by providing the required details:
```
static var stack : Stack = Contentstack.stack(withAPIKey: StackConfig.APIKey, accessToken: StackConfig.AccessToken, environmentName: StackConfig.EnvironmentName, config:StackConfig._config)

var realmPersistenceHelper = RealmPersistenceHelper(realm: try? RLMRealm(configuration: RLMRealmConfiguration.default()))

var syncManager : SyncManager = SyncManager(stack: stack, persistance: realmPersistenceHelper)

self.syncManager.sync { (totalCount, loadedCount, error) in

}
```
This will initiate your project.

<img src='https://lh3.googleusercontent.com/DzdkSx-GQ0TRRTKqKCNkaPJSgh35opZnFybGl7eqpTErkcT6uYgGtp2s6srRHon-KwC4mirsuCuGA9PWVTvOWNujB5W0Z5AImtTlKley86k-07i5cZXZv4m03ND9_UJtk2WLz2Hs' width='300' height='550'/>

## More Resources

-   [Getting started with iOS SDK](https://www.contentstack.com/docs/platforms/ios)
-   [Using the Sync API with iOS SDK](https://www.contentstack.com/docs/guide/synchronization/using-the-sync-api-with-ios-sdk)
-   [Using Persistence Library with iOS SDK](https://www.contentstack.com/docs/guide/synchronization/using-realm-persistence-library-with-ios-sync-sdk)
-   [Sync API documentation](https://www.google.com/url?q=https://www.contentstack.com/docs/apis/content-delivery-api/#synchronization&sa=D&ust=1540373553842000&usg=AFQjCNErftWljzbGy77oAYK01xsOU4z_rw)

