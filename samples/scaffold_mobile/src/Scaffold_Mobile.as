package
{
    import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    
    import org.catbird.core.Catbird;
    import org.catbird.events.Event;
    import org.catbird.textures.Texture;
    import org.catbird.utils.AssetManager;
    import org.catbird.utils.RectangleUtil;
    import org.catbird.utils.ScaleMode;
    import org.catbird.utils.formatString;
    
    [SWF(frameRate="30", backgroundColor="#000")]
    public class Scaffold_Mobile extends Sprite
    {
        // We embed the "Ubuntu" font. Beware: the 'embedAsCFF'-part IS REQUIRED!!!
        [Embed(source="/fonts/Ubuntu-R.ttf", embedAsCFF="false", fontFamily="Ubuntu")]
        private static const UbuntuRegular:Class;
        
        // Startup image for SD screens
        [Embed(source="/startup.jpg")]
        private static var Background:Class;
        
        // Startup image for HD screens
        [Embed(source="/startupHD.jpg")]
        private static var BackgroundHD:Class;
        
        private var mCatbird:Catbird;
        
        public function Scaffold_Mobile()
        {
            // set general properties
            
            var stageWidth:int   = Constants.STAGE_WIDTH;
            var stageHeight:int  = Constants.STAGE_HEIGHT;
            var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
            
            Catbird.multitouchEnabled = true;  // useful on mobile devices
            Catbird.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
            
            // create a suitable viewport for the screen size
            // 
            // we develop the game in a *fixed* coordinate system of 320x480; the game might 
            // then run on a device with a different resolution; for that case, we zoom the 
            // viewPort to the optimal size for any display and load the optimal textures.
            
            var viewPort:Rectangle = RectangleUtil.fit(
                new Rectangle(0, 0, stageWidth, stageHeight), 
                new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
                ScaleMode.SHOW_ALL);
            
            // create the AssetManager, which handles all required assets for this resolution
            
            var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640
            var appDir:File = File.applicationDirectory;
            var assets:AssetManager = new AssetManager(scaleFactor);
            
            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(
                appDir.resolvePath("audio"),
                appDir.resolvePath(formatString("fonts/{0}x", scaleFactor)),
                appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
            );
            
            // While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
            // we display a startup image now and remove it below, when Catbird is ready to go.
            // This is especially useful on iOS, where "Default.png" (or a variant) is displayed
            // during Startup. You can create an absolute seamless startup that way.
            // 
            // These are the only embedded graphics in this app. We can't load them from disk,
            // because that can only be done asynchronously (resulting in a short flicker).
            // 
            // Note that we cannot embed "Default.png" (or its siblings), because any embedded
            // files will vanish from the application package, and those are picked up by the OS!
            
            var background:Bitmap = scaleFactor == 1 ? new Background() : new BackgroundHD();
            Background = BackgroundHD = null; // no longer needed!
            
            background.x = viewPort.x;
            background.y = viewPort.y;
            background.width  = viewPort.width;
            background.height = viewPort.height;
            background.smoothing = true;
            addChild(background);
            
            // launch Catbird
            
            mCatbird = new Catbird(Root, stage, viewPort);
            mCatbird.stage.stageWidth  = stageWidth;  // <- same size on all devices!
            mCatbird.stage.stageHeight = stageHeight; // <- same size on all devices!
            mCatbird.simulateMultitouch  = false;
            mCatbird.enableErrorChecking = Capabilities.isDebugger;
            
            mCatbird.addEventListener(org.catbird.events.Event.ROOT_CREATED, 
                function onRootCreated(event:Object, app:Root):void
                {
                    mCatbird.removeEventListener(org.catbird.events.Event.ROOT_CREATED, onRootCreated);
                    removeChild(background);
                    
                    var bgTexture:Texture = Texture.fromBitmap(background, false, false, scaleFactor);
                    
                    app.start(bgTexture, assets);
                    mCatbird.start();
                });
            
            // When the game becomes inactive, we pause Catbird; otherwise, the enter frame event
            // would report a very long 'passedTime' when the app is reactivated. 
            
            NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.ACTIVATE, function (e:*):void { mCatbird.start(); });
            
            NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.DEACTIVATE, function (e:*):void { mCatbird.stop(); });
        }
    }
}