part of charts;

/// Creates the segments for 100% stacked column series.
///
/// Generates the stacked column100 series points and has the [calculateSegmentPoints] method overrided to customize
/// the stacked column100 segment point calculation.
///
/// Gets the path and color from the [series].
class StackedColumn100Segment extends ChartSegment {
  /// value x1.
  num x1;

  /// Value y1.
  num y1;

  /// Value x2.
  num x2;

  /// Value y2.
  num y2;

  /// Stacked value.
  double stackValues;
  BorderRadius _borderRadius;
  CartesianChartPoint<dynamic> _currentPoint;

  /// Rendering path.
  Path path;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final bool hasPointColor = series.pointColorMapper != null ? true : false;

    /// Get and set the paint options for column series.
    if (series.gradient == null) {
      if (color != null) {
        fillPaint = Paint()
          ..color = _currentPoint.isEmpty == true
              ? series.emptyPointSettings.color
              : ((hasPointColor && _currentPoint.pointColorMapper != null)
                  ? _currentPoint.pointColorMapper
                  : color)
          ..style = PaintingStyle.fill;
      }
    } else {
      fillPaint = _getLinearGradientPaint(series.gradient, _currentPoint.region,
          series._chart._requireInvertedAxis);
    }
    if (fillPaint.color != null)
      fillPaint.color =
          (series.opacity < 1 && fillPaint.color != Colors.transparent)
              ? fillPaint.color.withOpacity(series.opacity)
              : fillPaint.color;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    if (strokeColor != null) {
      strokePaint = Paint()
        ..color = _currentPoint.isEmpty == true
            ? series.emptyPointSettings.borderColor
            : strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _currentPoint.isEmpty == true
            ? series.emptyPointSettings.borderWidth
            : strokeWidth;
      _defaultStrokeColor = strokePaint;
    }
    series.borderWidth == 0
        ? strokePaint.color = Colors.transparent
        : strokePaint.color;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    final StackedColumn100Series<dynamic, dynamic> stackedColumn100Series =
        series;
    _borderRadius = stackedColumn100Series.borderRadius;
    if (_currentPoint.region != null) {
      segmentRect = RRect.fromRectAndCorners(
        _currentPoint.region,
        bottomLeft: _borderRadius.bottomLeft,
        bottomRight: _borderRadius.bottomRight,
        topLeft: _borderRadius.topLeft,
        topRight: _borderRadius.topRight,
      );
    }

    path = _dashedBorder(_currentPoint, series.borderWidth);
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    _renderStackingRectSeries(fillPaint, strokePaint, path, animationFactor,
        series, canvas, segmentRect, _currentPoint);
  }

  /// Method to set data.
  void _setData(List<num> values) {
    x1 = values[0];
    y1 = values[1];
  }
}
