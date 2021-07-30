# GoodWalletCF

Repository with google cloud functions to be used together with the frontend code here: [goodwallet](https://github.com/bejaeger/goodwallet/).

# Setup

1. Clone the Repository
2. Run `firebase init` in the directory the code was cloned to
3. Select to initialize Firestore, Functions, and Emulators
4. Use TypeScript as a language and press No when you are asked whether you want to overwrite existing files
5. Go to the functions/ folder and run `npm install firebase-backend`

# Resources - Tutorial and explanation of setup

We use the [firebase-backend](https://www.npmjs.com/package/firebase-backend) package to setup our cloud functions. Watch this [video on the Fireship channel](https://www.youtube.com/watch?v=W_VV2Fx32_Y&ab_channel=Fireship), where Dane Mackier explains the setup.
