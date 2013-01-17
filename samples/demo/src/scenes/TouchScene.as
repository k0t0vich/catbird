package scenes
{
    import org.catbird.display.Image;
    import org.catbird.text.TextField;
    import org.catbird.utils.deg2rad;
    
    import utils.TouchSheet;

    public class TouchScene extends Scene
    {
        public function TouchScene()
        {
            var description:String = "[use Ctrl/Cmd & Shift to simulate multi-touch]";
            
            var infoText:TextField = new TextField(300, 25, description);
            infoText.x = infoText.y = 10;
            addChild(infoText);
            
            // to find out how to react to touch events have a look at the TouchSheet class! 
            // It's part of the demo.
            
            var sheet:TouchSheet = new TouchSheet(new Image(Game.assets.getTexture("org.catbird_sheet")));
            sheet.x = Constants.CenterX;
            sheet.y = Constants.CenterY;
            sheet.rotation = deg2rad(10);
            addChild(sheet);
        }
    }
}