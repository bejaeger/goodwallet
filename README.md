# Development Considerations
## App architecture / State Management Solution
- We use the stacked package by FilledStacks which provides an incredibly clean solutions for state management and realizing an MVVM architecture in flutter [[stacked](https://pub.dev/packages/stacked)]
- Highly recommended to watch the architecture tutorials [[here](https://github.com/FilledStacks/flutter-tutorials)] (especially the tutorials 48, 49, 50). I basically set up the code like explained there. Having views separate from viewmodels and services allows the code to be incredibly clean and maintainable, so let's try that! :)
- From the FilledStacks I can additionally recommend the tutorials starting from number 38. They helped me a ton!

## Git workflow
See below for a long blob

# Learning Material
## Tutorials
- Learning UI: [Layouts in Flutter](https://flutter.dev/docs/development/ui/layout)
- [Flutter Step-by-step guide (blog post)](https://www.solutelabs.com/blog/flutter-tutorial-for-beginners-step-by-step-guide)
- Official flutter material
  - [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
  - [online documentation](https://flutter.dev/docs)

## Some things that I think are important or that I found useful

- Make full use of the IDE (shortcuts, auto-completion, navigating through source code, ...)
- Use proper Flutter code formatting [[flutter formatting](https://flutter.dev/docs/development/tools/formatting)]
- Read style guides [[official dart page](https://dart.dev/guides/language/effective-dart/style)], [[random medium article](https://medium.com/nonstopio/flutter-best-practices-c3db1c3cd694)]
- Take your time to think about meaningful names for variables/classes/filename/...everything. Will help sooo much to understand the code later on


## Git workflow - for everyone that has never used git

I think we should follow the feature branch workflow [[explanation](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow)]. We're quite a few people and I think it would be nice to always have one version of the app that is state-of-the-art and more importantly works!; this is the version in the `master` branch (please read about what branches are in git e.g. on the above webpage). Whenever you work on the code, just create a new branch and `commit` your changes in this branch first. Then we don't interefere with each other in the development and we can also discuss the code in github pull requests!

#### Here a short blob I wrote on git workflow once upon a time:
checkout latest master in your working directory and get updates from remote
```
git checkout master; git pull
```
create new branch and directly check it out (with `-b`)
```
git checkout -b my-awesome-new-feature
```
Now, develop your new feature, push it, and create a pull-request on github webpage with potentially assigning the issue. By pushing early we have the option to talk about details in the pull request during ongoing developments and can help each other. To push the branch, do something like this:
```
git push --set-upstream origin my-awesome-new-feature
```
I can only recommend to adopt a “commit early, push often” policy during feature developments ([[see nice read](https://www.worklytics.co/commit-early-push-often/)]).
The above command doesn't push anything if you haven't committed a change yet. A commit is (NOT LIKE IN SVN!) not uploaded!!! (that's what git push does) but only creates a local snapshot of the current code. 
```
git commit -m "add awesome function" path/to/awesome/function; 
```
(I usually use `git add file1 file2` and then commit everything at once with `git commit -m "my changes"`.)
Once you think you are done, check for potential changes that happened to master in the meantime (from other people), merge them into your branch with
```
git pull origin master # (one command to fetch updates in remote and merge master)
```
Here, you might encounter cases where you can’t merge because of local changes that aren’t committed or you will get merge conflicts you need to resolve. If you have done changes to files that you want to disregard you can e.g. stash them with `git stash` or just checkout the file from the remote master with `git checkout origin/master file/with/your/wrong/changes`  and then `git pull origin master` again. Afterwards, push your branch once more to the remote with
```
git push
```
You can also nicely follow the changes in the code in the github pull request and once you think everything is working and nice, you can merge it to `master`!
Afterwards, you might want to switch to `master` again in your local working dir and get the changes from the remote.
```
git checkout master; git pull 
```





