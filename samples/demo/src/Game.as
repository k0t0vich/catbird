package 
{
    import flash.ui.Keyboard;
    import flash.utils.getDefinitionByName;
    
    import scenes.Scene;
    
    import org.catbird.core.Catbird;
    import org.catbird.display.Button;
    import org.catbird.display.Image;
    import org.catbird.display.Sprite;
    import org.catbird.events.Event;
    import org.catbird.events.KeyboardEvent;
    import org.catbird.textures.Texture;
    import org.catbird.utils.AssetManager;
    
    import utils.ProgressBar;

    public class Game extends Sprite
    {
        // Embed the Ubuntu Font. Beware: the 'embedAsCFF'-part IS REQUIRED!!!
        [Embed(source="../../demo/assets/fonts/Ubuntu-R.ttf", embedAsCFF="false", fontFamily="Ubuntu")]
        private static const UbuntuRegular:Class;
        
        private var mLoadingProgress:ProgressBar;
        private var mMainMenu:MainMenu;
        private var mCurrentScene:Scene;
        
        private static var sAssets:AssetManager;
        
        public function Game()
        {
            // nothing to do here -- Startup will call "start" immediately.
        }
        
        public function start(background:Texture, assets:AssetManager):void
        {
            sAssets = assets;
            
            // The background is passed into this method for two reasons:
            // 
            // 1) we need it right away, otherwise we have an empty frame
            // 2) the Startup class can decide on the right image, depending on the device.
            
            addChild(new Image(background));
            
            // The AssetManager contains all the raw asset data, but has not created the textures
            // yet. This takes some time (the assets might be loaded from disk or even via the
            // network), during which we display a progress indicator. 
            
            mLoadingProgress = new ProgressBar(175, 20);
            mLoadingProgress.x = (background.width  - mLoadingProgress.width) / 2;
            mLoadingProgress.y = (background.height - mLoadingProgress.height) / 2;
            mLoadingProgress.y = background.height * 0.7;
            addChild(mLoadingProgress);
            
            assets.loadQueue(function(ratio:Number):void
            {
                mLoadingProgress.ratio = ratio;

                // a progress bar should always show the 100% for a while,
                // so we show the main menu only after a short delay. 
                
                if (ratio == 1)
                    Catbird.juggler.delayCall(function():void
                    {
                        mLoadingProgress.removeFromParent(true);
                        mLoadingProgress = null;
                        showMainMenu();
                    }, 0.15);
            });
            
            addEventListener(Event.TRIGGERED, onButtonTriggered);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
        }
        
        private function showMainMenu():void
        {
            if (mMainMenu == null)
                mMainMenu = new MainMenu();
            
            addChild(mMainMenu);
        }
        
        private function onKey(event:KeyboardEvent):void
        {
            if (event.keyCode == Keyboard.SPACE)
                Catbird.current.showStats = !Catbird.current.showStats;
            else if (event.keyCode == Keyboard.X)
                Catbird.context.dispose();
        }
        
        private function onButtonTriggered(event:Event):void
        {
            var button:Button = event.target as Button;
            
            if (button.name == "backButton")
                closeScene();
            else
                showScene(button.name);
        }
        
        private function closeScene():void
        {
            mCurrentScene.removeFromParent(true);
            mCurrentScene = null;
            showMainMenu();
        }
        
        private function showScene(name:String):void
        {
            if (mCurrentScene) return;
            
            var sceneClass:Class = getDefinitionByName(name) as Class;
            mCurrentScene = new sceneClass() as Scene;
            mMainMenu.removeFromParent();
            addChild(mCurrentScene);
        }
        
        public static function get assets():AssetManager { return sAssets; }
    }
}