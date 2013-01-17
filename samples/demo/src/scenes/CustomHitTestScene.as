package scenes
{
    import org.catbird.text.TextField;
    import org.catbird.utils.HAlign;
    import org.catbird.utils.VAlign;
    
    import utils.RoundButton;

    public class CustomHitTestScene extends Scene
    {
        public function CustomHitTestScene()
        {
            var description:String = 
                "Pushing the bird only works when the touch occurs within a circle." + 
                "This can be accomplished by overriding the method 'hitTest'.";
            
            var infoText:TextField = new TextField(300, 100, description);
            infoText.x = infoText.y = 10;
            infoText.vAlign = VAlign.TOP;
            infoText.hAlign = HAlign.CENTER;
            addChild(infoText);
            
            // 'RoundButton' is a helper class of the Demo, not a part of Catbird!
            // Have a look at its code to understand this sample.
            
            var button:RoundButton = new RoundButton(Game.assets.getTexture("org.catbird_round"));
            button.x = Constants.CenterX - int(button.width / 2);
            button.y = 150;
            addChild(button);
        }
    }
}