package org.catbird.filters {
	
	
	/**
	 * Creates a new GlowFilter instance.
	 * @author k0t0vich
	 */
	public class GlowFilter extends BlurFilter {
		private var _color: uint;
		private var _alpha: Number;
		
		/**
		 * Creates a new GlowFilter instance with the specified parameters.
		 * @param color		(default = 0xFF0000) — Color of the glow, in hexadecimal format 0xRRGGBB. The default value is 0xFF0000.
		 * @param alpha		(default = 1.0) — Alpha transparency value for the glow color. Valid values are 0.0 to 1.0. For example, .25 sets a transparency value of 25%.
		 * @param blurX		(default = 6.0) — Amount of horizontal glow. 
		 * @param blurY		(default = 6.0) — Amount of vertical glow.
		 * @param quality   The resolution of the filter texture. "1" means stage resolution, "0.5" half the
         *  stage resolution. A lower resolution saves memory and execution time (depending on 
         *  the GPU), but results in a lower output quality. Values greater than 1 are allowed;
         *  such values might make sense for a cached filter when it is scaled up.
		 */
		public function GlowFilter(color:uint = 0xFF0000, alpha:Number = 1.0, blurX:Number = 6.0, blurY:Number = 6.0, quality:int = 1) {
			super(blurX, blurY, quality);			
			mode = FragmentFilterMode.BELOW;
			
			_color = color;
			_alpha = alpha;
			setUniformColor(true, _color, _alpha);
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get alpha():Number {
			return _alpha;
		}
		
		/**
		 * 
		 * @param value
		 */
		public function set alpha(value: Number):void {
			if (_alpha !== value) {
				_alpha = value;
				setUniformColor(true, _color, _alpha);
			}
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get color():uint {
			return _color;
		}
		
		/**
		 * 
		 * @param value
		 */
		public function set color(value: uint):void {
			if (_color !== value) {
				_color = value;
				setUniformColor(true, _color, _alpha);
			}
		}
		
	}
}

