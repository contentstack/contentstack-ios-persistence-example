
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

To set up and initialize Contentstack’s iOS SDK, refer to our documentation [
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

This will initiate your project.

## Step 7: Initialize Sync

To perform the initial sync, use the sync method, which fetches all the content of the specified environment.

```
APIManager.stack.sync {[weak self] (stack, error) in
    guard let slf = self, let syncStack = stack else {return}
    if (error == nill) {
        syncStack.items.count;
    }
}
```

On successful sync completion, you will get a sync token in response, which is used to get subsequent (delta) syncs.

## Step 8: Use pagination token

If the result of the initial sync contains more than 100 records, the response would be paginated. Now, if the sync process is interrupted midway (due to network issues, etc.), a pagination token is returned in the response using which you can reinitiate ‘Intial Sync’.

To complete the sync process, use the following function:

```
APIManger.stack.syncPaginationToken(<pagination_token>, completion: {[weak self] (stack, error) in
    guard let slf = self, let syncStack = stack else {return}
    if (error == nill) {
        syncStack.items.count;
    }
})
```
# Step 9: Subsequent sync

If the existing content is updated by means of addition, deletion, publishing, or unpublishing of content, you need to re-sync your content. You need to use the sync token (that you receive after initial sync) to get the updated content next time. The sync token fetches only the content that was added, updated, or deleted since your last sync.

For the Delta sync button on the storyboard, add the following action in ViewController:
```
@IBAction func deltaSync(_ sender: Any) {}
```

To perform Subsequent sync process, add the following function:
```
APIManager.stack.syncToken(<sync_token>, completion: { (syncStack:SyncStack, error:NSError) in
    guard let slf = self, let syncStack = stack else {return}
    if (error == nill) {
        syncStack.items.count;
    }
})
```
<img src='https://lh3.googleusercontent.com/DzdkSx-GQ0TRRTKqKCNkaPJSgh35opZnFybGl7eqpTErkcT6uYgGtp2s6srRHon-KwC4mirsuCuGA9PWVTvOWNujB5W0Z5AImtTlKley86k-07i5cZXZv4m03ND9_UJtk2WLz2Hs' width='300' height='550'/>

## More Resources

-   [Getting started with iOS SDK](https://www.contentstack.com/docs/platforms/ios)
-   [Using the Sync API with iOS SDK](https://www.contentstack.com/docs/guide/synchronization/using-the-sync-api-with-ios-sdk)
-   [Using Persistence Library with iOS SDK](https://www.contentstack.com/docs/guide/synchronization/using-realm-persistence-library-with-ios-sync-sdk)
-   [Sync API documentation](https://www.google.com/url?q=https://www.contentstack.com/docs/apis/content-delivery-api/#synchronization&sa=D&ust=1540373553842000&usg=AFQjCNErftWljzbGy77oAYK01xsOU4z_rw)

