package scenes
{
    import org.catbird.display.Button;
    import org.catbird.display.Image;
    import org.catbird.events.Event;
    import org.catbird.filters.BlurFilter;
    import org.catbird.filters.ColorMatrixFilter;
    import org.catbird.text.TextField;

    public class FilterScene extends Scene
    {
        private var mButton:Button;
        private var mImage:Image;
        private var mInfoText:TextField;
        private var mFilterInfos:Array;
        
        public function FilterScene()
        {
            initFilters();
            
            mButton = new Button(Game.assets.getTexture("button_normal"), "Switch Filter");
            mButton.x = int(Constants.CenterX - mButton.width / 2);
            mButton.y = 15;
            mButton.addEventListener(Event.TRIGGERED, onButtonTriggered);
            addChild(mButton);
            
            mImage = new Image(Game.assets.getTexture("org.catbird_rocket"));
            mImage.x = int(Constants.CenterX - mImage.width / 2);
            mImage.y = 170;
            addChild(mImage);
            
            mInfoText = new TextField(300, 32, "", "Verdana", 19);
            mInfoText.x = 10;
            mInfoText.y = 330;
            addChild(mInfoText);
            
            onButtonTriggered();
        }
        
        private function onButtonTriggered():void
        {
            var filterInfo:Array = mFilterInfos.shift() as Array;
            mFilterInfos.push(filterInfo);
            
            mInfoText.text = filterInfo[0];
            mImage.filter  = filterInfo[1];
        }
        
        private function initFilters():void
        {
            mFilterInfos = [
                ["Identity", new ColorMatrixFilter()],
                ["Blur", new BlurFilter()],
                ["Drop Shadow", BlurFilter.createDropShadow()],
                ["Glow", BlurFilter.createGlow()]
            ];
            
            var invertFilter:ColorMatrixFilter = new ColorMatrixFilter();
            invertFilter.invert();
            mFilterInfos.push(["Invert", invertFilter]);
            
            var grayscaleFilter:ColorMatrixFilter = new ColorMatrixFilter();
            grayscaleFilter.adjustSaturation(-1);
            mFilterInfos.push(["Grayscale", grayscaleFilter]);
            
            var saturationFilter:ColorMatrixFilter = new ColorMatrixFilter();
            saturationFilter.adjustSaturation(1);
            mFilterInfos.push(["Saturation", saturationFilter]);
            
            var contrastFilter:ColorMatrixFilter = new ColorMatrixFilter();
            contrastFilter.adjustContrast(0.75);
            mFilterInfos.push(["Contrast", contrastFilter]);

            var brightnessFilter:ColorMatrixFilter = new ColorMatrixFilter();
            brightnessFilter.adjustBrightness(-0.25);
            mFilterInfos.push(["Brightness", brightnessFilter]);

            var hueFilter:ColorMatrixFilter = new ColorMatrixFilter();
            hueFilter.adjustHue(1);
            mFilterInfos.push(["Hue", hueFilter]);
        }
    }
}