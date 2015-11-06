# YQSlideDrawerController
参考ICSDDrawer写的一个侧边框，使用swift2.1


使用方法  left和center必须实现YQDrawerDelegate方法

  
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.blackColor()
        
        
        let colorsVC = YQLeftViewController()
        let plainColorVC = YQCenterViewController()
        
        let drawer:YQDrawerViewController = YQDrawerViewController()
        drawer.drawerDelegateLeft = colorsVC.self
        drawer.drawerDelegateCenter = plainColorVC.self
        drawer.initDrawerViewController(colorsVC, centerViewController: plainColorVC)

        window?.rootViewController = drawer
        
        return true
    }
