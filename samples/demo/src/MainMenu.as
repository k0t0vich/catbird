package
{
    import flash.utils.getQualifiedClassName;
    
    import scenes.AnimationScene;
    import scenes.BenchmarkScene;
    import scenes.BlendModeScene;
    import scenes.CustomHitTestScene;
    import scenes.FilterScene;
    import scenes.MovieScene;
    import scenes.RenderTextureScene;
    import scenes.TextScene;
    import scenes.TextureScene;
    import scenes.TouchScene;
    
    import org.catbird.core.Catbird;
    import org.catbird.display.Button;
    import org.catbird.display.Image;
    import org.catbird.display.Sprite;
    import org.catbird.events.TouchEvent;
    import org.catbird.events.TouchPhase;
    import org.catbird.text.TextField;
    import org.catbird.textures.Texture;
    import org.catbird.utils.VAlign;

    public class MainMenu extends Sprite
    {
        public function MainMenu()
        {
            init();
        }
        
        private function init():void
        {
            var logo:Image = new Image(Game.assets.getTexture("logo"));
            addChild(logo);
            
            var scenesToCreate:Array = [
                ["Textures", TextureScene],
                ["Multitouch", TouchScene],
                ["TextFields", TextScene],
                ["Animations", AnimationScene],
                ["Custom hit-test", CustomHitTestScene],
                ["Movie Clip", MovieScene],
                ["Filters", FilterScene],
                ["Blend Modes", BlendModeScene],
                ["Render Texture", RenderTextureScene],
                ["Benchmark", BenchmarkScene]
            ];
            
            var buttonTexture:Texture = Game.assets.getTexture("button_big");
            var count:int = 0;
            
            for each (var sceneToCreate:Array in scenesToCreate)
            {
                var sceneTitle:String = sceneToCreate[0];
                var sceneClass:Class  = sceneToCreate[1];
                
                var button:Button = new Button(buttonTexture, sceneTitle);
                button.x = count % 2 == 0 ? 28 : 167;
                button.y = 160 + int(count / 2) * 52;
                button.name = getQualifiedClassName(sceneClass);
                addChild(button);
                ++count;
            }
            
            // show information about rendering method (hardware/software)
            
            var driverInfo:String = Catbird.context.driverInfo;
            var infoText:TextField = new TextField(310, 64, driverInfo, "Verdana", 10);
            infoText.x = 5;
            infoText.y = 475 - infoText.height;
            infoText.vAlign = VAlign.BOTTOM;
            infoText.addEventListener(TouchEvent.TOUCH, onInfoTextTouched);
            addChildAt(infoText, 0);
        }
        
        private function onInfoTextTouched(event:TouchEvent):void
        {
            if (event.getTouch(this, TouchPhase.ENDED))
                Catbird.current.showStats = !Catbird.current.showStats;
        }
    }
}