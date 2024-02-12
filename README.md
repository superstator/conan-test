# Hello Conan

**Ultra minimal example of a buildable conan/cmake project.**

Conan is great when it works, but the docs seem very incomplete and it's frustratingly hard to get a minimal setup in place. After a *lot* of trail and error and cursing various incomplete examples, I discovered that **IF** the CLion conan plugin was installed and **IF** the box was checked for "Use conan installed in the system" **AND** I cleaned up the right detritus from prior attempts, things started magically working. Actually building at the commandline or specifically building in a container did not. After a *lot* more trial and error I worked out that the Conan plugin is silently creating a `conan_provider.cmake` for me and adding that to the cmake build commands, which eventually led me [here](https://github.com/conan-io/cmake-conan), which does explain the need for this file. How you're supposed to figure that out without deducing it from the plugin's activity I'm not sure.

It is also not clear how you're supposed to get it outside the context of the CLion plugin. That plugin is versioned and clearly includes the provider, but `cmake-conan` itself doesn't appear to bother with formal releases. For now I'm just `curl`ing a specific commit and calling it good.

In any case, this repo presents a complete minimal hello world type project with a superfluous conan dependency. It should build and run with just `docker build https://github.com/superstator/conan-test.git`