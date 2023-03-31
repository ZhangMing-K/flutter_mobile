## Iris File Structure

This is the Iris Mobile App architecture quick guide for new developers.



Iris has a clean modular architecture, which aims primarily to respect the following principles:

### 1- Beware of "God class":

If your controller is becoming giant, think carefully if the functions inserted there could not be broken into other functions. If this is possible, create a separate controller for each of these functions, and add that controller to your Binding. You can access this controller through the main controller at any time.
Motivation: Imagine that in the future we need to change something in the comment controller on an emergency basis, if it has embedded in the same file as 10 other functions, it will take us longer to know what to modify. In addition, it allows each person on the Team to have responsibilities in different modules, without causing merge conflicts on github, since the same file will not be changed simultaneously.

### 2- Invert dependencies, and try to extend instead of modifying entities:

If you didn't understand anything about the title, I'll exemplify:

Imagine that we need a response from the server to decide whether to send the user to page X, or Y.

You could simply do this:

```dart

class UserRepository{
    Future<User> getUser(int id){
        return client.getUser(id);
    }
}
class UserController extends GetxController{
    final userRepository = UserRepository();

    void getUser(){
        final user = userRepository.getUser(1);
        if(user != null){
            saveUser(user);
            navigateToHome();
        } else {
            navigateToLogin();
        }
    }

    void saveUser(){}
    void navigateToHome(){}
    void navigateToLogin(){}
}
```

This code works, but how could we test it?
If I change the getUser method to receive a [UserData] instead of [User], would I have to refactor all my code for that?

All of these problems are solved with a very simple step, always create abstract classes, and inject the actual implementation into your Bindings, in the example above, this would simply become:


```dart
class IUserRepository{ // added this class
 Future<User> getUser(int id)
}

class UserRepository{
    Future<User> getUser(int id){
        return client.getUser(id);
    }
}
class UserController extends GetxController{
    
    UserController({userRepository})
    
    /// Use Interface rather [UserRepository] class 
    final IUserRepository userRepository;
    // you also can use "final IUserRepository userRepository = Get.find();"
    // and not to use Contructor

    void getUser(){
        final user = userRepository.getUser(1);
        if(user != null){
            saveUser(user);
            navigateToHome();
        } else {
            navigateToLogin();
        }
    }

    void saveUser(){}
    void navigateToHome(){}
    void navigateToLogin(){}
}
```
Motivation: This simple change allows us to write the following test:

```dart
void main() {

  Get.put(UserController(repository:UserRepositoryMock(1)), tag: 'success');
  Get.put(UserController(repository:UserRepositoryMock(0)), tag: 'failure');
  
  testWidgets('test login failure', (tester) async { 
    Get.find<UserController>(tag: 'failure').getUser();
    expect(Get.currentRoute, Paths.Login);
  });

  testWidgets('test login success', (tester) async {
    Get.find<UserController>(tag: 'success').getUser();
    expect(Get.currentRoute, Paths.Home);
  });
}

class UserRepositoryMock extends IUserRepository {
  UserRepositoryMock(this.userId);
  final int userId;

  @override
  Future<User> getUser(int id) {
    return (userId == 0) ? null : User(username: 'foo');
  }
}
```

Thus, we have the guarantee that if the user receives a valid User, he will navigate to the home. If anything fails in this process, our test will fail, and github actions will report that the PR has not passed the test.

## The view should only have pure widgets.

The build method should have as little logical processing as possible. When it is called, Skia is waiting to render a painting. If you delay the build method, you are skipping 1, 2, 20, 30 frames that should be displayed, this will be demonstrated by the user as a small janking.
There are some things that have no impact on this, such as:
1- Reading maps, lists, sets.
2- Creation of an instance
There are things that negatively impact this, and they are:

1- Creating loops
2- Any operation that has spent computational over 1/400 seconds on average devices.

## Do not insert mutable variables inside a StatelessWidget.
When a "setState" is called, it will check if the widget is mounted, to call markNeedRebuild();
This function, in turn, will mark the element as dirty, and call owner.scheduleBuildFor(this), which will add the element and all its dependents for a rebuild check List. On update method, the widget is compared to itself, and removed and reinserted in the tree if it is different (on StatelessWidget) or called state.rebuild (on StatefulWidgets).
By using mutable variables within a StatelessWidget, any reconstruction of an ancestor will remove and recreate the widget in the tree (hashcode will change and even its constructor will be called again), so that using const widgets can prevent your widget from being rebuilt, in addition to having a small performance gain.
So, consider using only final variables in your widget, and abuse the Get.parameters, or Get.arguments, to pass data from a controller on one page, directly to the controller on the other, without passing the data through the constructor. Passing the data through the constructor of a StatelessWidget is still a good option, as long as the data you are going to pass is constant, otherwise your StatelessWidget will always be marked as dirty, and reset from the tree with any update.

### Routes, Paths, and any route configuration are in the [app/routes] folder

### Themes, Internacionalization, or others shared configurations (settings that once changed, reflect on the entire app, such as language, darkmode, etc) are on [app/shared] folder. The configuration of this resources are on app/app_controller.dart

### MaterialApp configurations, or others configurations of View, are on [app/app_view]. 

### Global dependencys are injected on app/bindings.dart 

### Modules are responsible for containing the core of each project resource. Each module can have infinite submodules, and in the future, each Sprint of a resource will have a final test of the module, in order to ensure that all resources have been developed and do not fail

### Vendor has the packages that needed to be modified and were internalized. Keep the name of the original repository, to find new features of this package.


