package scenes
{
    import flash.media.Sound;
    
    import org.catbird.core.Catbird;
    import org.catbird.display.MovieClip;
    import org.catbird.events.Event;
    import org.catbird.textures.Texture;

    public class MovieScene extends Scene
    {
        private var mMovie:MovieClip;
        
        public function MovieScene()
        {
            var frames:Vector.<Texture> = Game.assets.getTextures("flight");
            mMovie = new MovieClip(frames, 15);
            
            // add sounds
            var stepSound:Sound = Game.assets.getSound("wing_flap");
            mMovie.setFrameSound(2, stepSound);
            
            // move the clip to the center and add it to the stage
            mMovie.x = Constants.CenterX - int(mMovie.width / 2);
            mMovie.y = Constants.CenterY - int(mMovie.height / 2);
            addChild(mMovie);
            
            // like any animation, the movie needs to be added to the juggler!
            // this is the recommended way to do that.
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        }
        
        private function onAddedToStage():void
        {
            Catbird.juggler.add(mMovie);
        }
        
        private function onRemovedFromStage():void
        {
            Catbird.juggler.remove(mMovie);
        }
        
        public override function dispose():void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            super.dispose();
        }
    }
}