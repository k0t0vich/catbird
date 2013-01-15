package starling.filters {
	import starling.utils.deg2rad;

	/**
	 * Creates a new DropShadowFilter instance.
	 * @author k0t0vich
	 */
	public class DropShadowFilter extends BlurFilter {
		private var _angleRad: Number;
		private var _angle: Number;
		private var _distance: Number = 4.0;
		private var _color: uint;
		private var _alpha: Number;

		/**
		 * Creates a new DropShadowFilter instance with the specified parameters.
		 * @param distance	(default = 4.0) — Offset distance for the shadow, in pixels.
		 * @param angle		(default = 45) — Angle of the shadow, 0 to 360 degrees (floating point).
		 * @param color		(default = 0) — Color of the shadow, in hexadecimal format 0xRRGGBB. The default value is 0x000000.
		 * @param alpha		(default = 1.0) — Alpha transparency value for the shadow color. Valid values are 0.0 to 1.0. For example, .25 sets a transparency value of 25%.
		 * @param blurX		(default = 4.0) — Amount of horizontal blur. 
		 * @param blurY		(default = 4.0) — Amount of vertical blur.
		 * @param quality    (default = 1.0) — The resolution of the filter texture. "1" means stage resolution, "0.5" half the
         *  stage resolution. A lower resolution saves memory and execution time (depending on 
         *  the GPU), but results in a lower output quality. Values greater than 1 are allowed;
         *  such values might make sense for a cached filter when it is scaled up.
		 */
		public function DropShadowFilter(distance: Number = 4.0, angle: Number = 45, color: uint = 0, alpha: Number = 1.0, blurX: Number = 4.0, blurY: Number = 4.0, quality: int = 1) {
			super(blurX, blurY, quality);
			_angle = angle;
			_angleRad = deg2rad(_angle);
			_distance = distance;
			setOffset();

			mode = FragmentFilterMode.BELOW;
			
			_color = color;
			_alpha = alpha;
			setUniformColor(true, color, alpha);
		}

		private function setOffset():void {
			offsetX = Math.cos(_angleRad) * _distance;
			offsetY = Math.sin(_angleRad) * _distance;
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
				setUniformColor(true, color, alpha);
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
				setUniformColor(true, color, alpha);
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get distance():Number {
			return _distance;
		}

		/**
		 * 
		 * @param value
		 */
		public function set distance(value: Number):void {
			if (_distance !== value) {
				_distance = value;
				setOffset();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get angle():Number {
			return _angle;
		}

		/**
		 * 
		 * @param value
		 */
		public function set angle(value: Number):void {
			if (_angle == value) {
				_angle = value;
				_angleRad = deg2rad(_angle);
				setOffset();
			}
		}


	}
}
