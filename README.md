# advanced_mobile_flutter
###
1. widget: https://drive.google.com/file/d/1p5o1U4XlPUB9qdhQXbtYy3uQeLqhFi39/view?usp=sharing
2. video: https://youtu.be/rYNHMG8Uih4 
3. report: https://drive.google.com/file/d/1V2cJTVWpzS3SAfahq5btH00fIc_SbYNO/view?usp=sharing 
## Common
1. Create a new flutter project <a href="https://docs.flutter.dev/get-started/codelab">here</a>:

2. Config your project follow the steps <a href="https://docs.flutter.dev/deployment/android">here</a>:
    - Important step: You must sign your app follow <a href="https://docs.flutter.dev/deployment/android#sign-the-app">here</a>.

## Without cicd
1. flutter pub get
2. flutter test --dart-define=FLAVOR=testing
3. flutter build appbundle --dart-define=FLAVOR=testing
4. Notify to team members about new version.
5. Upload appbundle to play store manually.
6. ...

To release new version, you must repeat step 1, 2, 3, 4, 5, 6. It's very boring and take a lot of time. So, we can use cicd to automate these steps.

With cicd the only thing you can do is merge your code to main/beta/testing branch.

## With cicd

1. Config your repository to build, test and release follow the steps bellow:
    - Add environment secrets: https://github.com/username/repo-name/settings/secrets/actions
        - Add `KEYSTORE_BASE64` secret:
            - cmd: base64 -i <path-to-file-keystore> -w 0. Then copy the result and paste to secret value.
        - Add `STORE_PASSWORD` secret:
            - The password of your keystore file.
        - Add `KEY_PASSWORD` secret:
            - The password of your key in keystore file.
        - Add `KEY_ALIAS` secret:
            - May be is: upload, you can check it in the document.
        - Add `PLAYSTORE_ACCOUNT_KEY` secret:
            - This secret is used to upload your app to play store. Get in google play console.
        - Add `SLACK_WEBHOOK` secret:
            - Guide: https://www.svix.com/resources/guides/how-to-get-slack-webhook-url/
    - Enable read and write permissions in setting -> action -> general to push to GitHub artifact.
        - https://github.com/username/repo-name/settings/actions
2. Trigger the workflow to build, test and release your app.
    - You can trigger the workflow by push code or pull request to main/beta/testing branch with commit or pull message is always contain "Version: x.y.z".
    - You can check and change with your requirement, the workflow status in: .github/workflows/android-release.yml

## References
    - https://blog.logrocket.com/flutter-ci-cd-using-github-actions/ 
    - https://docs.flutter.dev/deployment/android#sign-the-app
## Do by
    ### HCMUS - Phát triển ứng dụng cho thiết bị di động nâng cao - 20_3 - Group 26.
    - Dương Tấn Tồn - 20120598