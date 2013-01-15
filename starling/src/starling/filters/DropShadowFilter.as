package starling.filters {
	import starling.utils.deg2rad;

	public class DropShadowFilter extends BlurFilter {
		private var _angleRad: Number;
		private var _angle: Number;
		private var _distance: Number = 4.0;
		private var _color: uint;
		private var _alpha: Number;

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

		public function get alpha():Number {
			return _alpha;
		}

		public function set alpha(value: Number):void {
			if (_alpha !== value) {
				_alpha = value;
				setUniformColor(true, color, alpha);
			}
		}

		public function get color():uint {
			return _color;
		}

		public function set color(value: uint):void {
			if (_color !== value) {
				_color = value;
				setUniformColor(true, color, alpha);
			}
		}

		public function get distance():Number {
			return _distance;
		}

		public function set distance(value: Number):void {
			if (_distance !== value) {
				_distance = value;
				setOffset();
			}
		}

		public function get angle():Number {
			return _angle;
		}

		public function set angle(value: Number):void {
			if (_angle == value) {
				_angle = value;
				_angleRad = deg2rad(_angle);
				setOffset();
			}
		}


	}
}
