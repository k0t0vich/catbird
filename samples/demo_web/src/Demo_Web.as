package 
{
    import flash.display.Sprite;
    import flash.system.Capabilities;
    
    import org.catbird.core.Catbird;
    import org.catbird.events.Event;
    import org.catbird.textures.Texture;
    import org.catbird.utils.AssetManager;
    
    // If you set this class as your 'default application', it will run without a preloader.
    // To use a preloader, see 'Demo_Web_Preloader.as'.
    
    [SWF(width="320", height="480", frameRate="60", backgroundColor="#222222")]
    public class Demo_Web extends Sprite
    {
        [Embed(source = "/startup.jpg")]
        private var Background:Class;
        
        private var mCatbird:Catbird;
        
        public function Demo_Web()
        {
            if (stage) start();
            else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        private function start():void
        {
            Catbird.multitouchEnabled = true; // for Multitouch Scene
            Catbird.handleLostContext = true; // required on Windows, needs more memory
            
            mCatbird = new Catbird(Game, stage);
            mCatbird.simulateMultitouch = true;
            mCatbird.enableErrorChecking = Capabilities.isDebugger;
            mCatbird.start();
            
            // this event is dispatched when stage3D is set up
            mCatbird.addEventListener(Event.ROOT_CREATED, onRootCreated);
        }
        
        private function onAddedToStage(event:Object):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            start();
        }
        
        private function onRootCreated(event:Event, game:Game):void
        {
            // set framerate to 30 in software mode
            if (mCatbird.context.driverInfo.toLowerCase().indexOf("software") != -1)
                mCatbird.nativeStage.frameRate = 30;
            
            // define which resources to load
            var assets:AssetManager = new AssetManager();
            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(EmbeddedAssets);
            
            // background texture is embedded, because we need it right away!
            var bgTexture:Texture = Texture.fromBitmap(new Background());
            
            // game will first load resources, then start menu
            game.start(bgTexture, assets);
        }
    }
}