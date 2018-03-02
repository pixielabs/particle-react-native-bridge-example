# Particle SDK - React Native bridge

A React Native integration for the [Particle iOS SDK](https://docs.particle.io/guide/getting-started/intro/photon/).

Using this basic app as an example, you should be able to integrate the setup process of Particle-powered products into your own React Native app.

If you aren't familiar with the process of creating native modules, React Native have some [useful documentation](https://facebook.github.io/react-native/docs/native-modules-ios.html) to get you started.

## Prerequisites

You will need node.js, Watchman, the command line interface for React Native, and Xcode installed. Follow the [Getting Started guide](https://facebook.github.io/react-native/docs/getting-started.html) (Building projects with Native Code) to ensure these are all correctly installed.

## Running the sample app

```
$ git clone https://github.com/pixielabs/particle-react-native-bridge-example.git
$ cd particle-react-native-bridge-example
$ yarn
```

You'll then need to build and run the app from within Xcode using the generated project workspace.

## Using the Particle SDK

#### Particle Device Setup Library

In this example, we use the [Particle Device Setup Library](https://docs.particle.io/reference/ios/#particle-device-setup-library) only; this allows you to create a setup wizard inside your app for users to manually configure their Particle devices.

In addition to creating the native modules `ParticleSetupBridge.m` and `ParticleSetupViewController.m` included in the sample app, you will need to install the Partilce library via [Cocoapods](https://guides.cocoapods.org/using/getting-started.html). Follow the installation instructions in the [Particle documentation](https://docs.particle.io/reference/ios/#installation-1).

#### Particle Cloud SDK

For your mobile app to interact directly with internet-connected hardware, you'll need to integrate separately with the [Cloud SDK](https://docs.particle.io/reference/ios/#ios-cloud-sdk).

For example, if you use your own backend to authenticate your users, you can use the Cloud SDK to inject their session access token and treat them as logged in. Simply add the following code to `ParticleSetupBridge.m` before setting up the `ParticleSetupMainController`:

```objective-c
if ([[ParticleCloud sharedInstance] injectSessionAccessToken:accessToken]) {
  NSLog(@"Session is active!");
} else {
  // Do something here to alert the user that their token has expired.
  // They'll need to log in again.
  return;
}
```
