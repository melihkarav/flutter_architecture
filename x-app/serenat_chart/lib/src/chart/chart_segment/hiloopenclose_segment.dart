part of charts;

/// Creates the segments for HiloOpenClose series.
///
/// Generates the HiloOpenClose series points and has the [calculateSegmentPoints] method overrided to customize
/// the HiloOpenClose segment point calculation.
///
/// Gets the path and color from the [series].
class HiloOpenCloseSegment extends ChartSegment {
  num x,

      ///Low value.
      low,

      ///High value.
      high,

      ///Position of X.
      xPos,

      ///Postion of low.
      lowPos,

      ///Position of high.
      highPos,

      ///Center value of Y.
      centerY,

      ///High value of Y.
      highY,

      ///Center value of X.
      centerX,

      ///low value of X.
      lowX,

      ///High value of X.
      highX,

      ///Open value of X.
      openX,

      ///Open value of X.
      openY,

      ///Close value of Y.
      closeX,

      /// Close value of Y.
      closeY,

      /// High value of center.
      centerHigh,

      /// Low value of center.
      centerLow,

      /// Low value of Y.
      lowY,

      /// Start position.
      startPos,

      ///End position.
      endPos,

      ///Open value.
      open,

      ///Close value.
      close;

  Color _pointColorMapper;
  bool isBull = false;
  CartesianChartPoint<dynamic> _currentPoint;
  Path path;
  _ChartLocation centerLowPoint, centerHighPoint, lowPoint, highPoint;
  bool _showSameValue, isTransposed;
  HiloOpenCloseSegment currentSegment, oldSegment;
  HiloOpenCloseSeries<dynamic, dynamic> hiloOpenCloseSeries;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final Paint fillPaint = Paint();
    if (color != null) {
      fillPaint.color = _pointColorMapper ?? color.withOpacity(series.opacity);
    }
    fillPaint.strokeWidth = strokeWidth;
    fillPaint.style = PaintingStyle.fill;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    if (series.gradient == null) {
      if (strokeColor != null) {
        strokePaint.color =
            _currentPoint.isEmpty != null && _currentPoint.isEmpty
                ? series.emptyPointSettings.color
                : _pointColorMapper ?? strokeColor;
        strokePaint.color =
            (series.opacity < 1 && strokePaint.color != Colors.transparent)
                ? strokePaint.color.withOpacity(series.opacity)
                : strokePaint.color;
      }
    } else {
      strokePaint.color = series.gradient.colors[0];
    }
    strokePaint.strokeWidth = strokeWidth;
    strokePaint.style = PaintingStyle.stroke;
    strokePaint.strokeCap = StrokeCap.round;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    hiloOpenCloseSeries = series;
    isTransposed = series._chart._requireInvertedAxis;
    isBull = _currentPoint.open < _currentPoint.close;
    lowPoint = _currentPoint.lowPoint;
    highPoint = _currentPoint.highPoint;
    centerLowPoint = _currentPoint.centerLowPoint;
    centerHighPoint = _currentPoint.centerHighPoint;
    x = lowX = lowPoint.x;
    low = lowPoint.y;
    high = highPoint.y;
    highX = highPoint.x;
    centerHigh = centerHighPoint.x;
    highY = centerHighPoint.y;
    centerLow = centerLowPoint.x;
    lowY = centerLowPoint.y;
    openX = _currentPoint.openPoint.x;
    openY = _currentPoint.openPoint.y;
    closeX = _currentPoint.closePoint.x;
    closeY = _currentPoint.closePoint.y;

    _showSameValue = hiloOpenCloseSeries.showIndicationForSameValues &&
        (!isTransposed
            ? centerHighPoint.y == centerLowPoint.y
            : centerHighPoint.x == centerLowPoint.x);

    if (_showSameValue) {
      if (isTransposed) {
        x = lowPoint.x = lowPoint.x - 2;
        highPoint.x = highPoint.x + 2;
        centerHigh = centerHighPoint.x = centerHighPoint.x + 2;
        centerLow = centerLowPoint.x = centerLowPoint.x - 2;
      } else {
        low = lowPoint.y = lowPoint.y - 2;
        high = highPoint.y = highPoint.y + 2;
        highY = centerHighPoint.y = centerHighPoint.y + 2;
        lowY = centerLowPoint.y = centerLowPoint.y - 2;
      }
    }
  }

  /// Draws the path between open and close values.
  void drawHiloOpenClosePath(Canvas canvas) {
    path.moveTo(centerHigh, highY);
    path.lineTo(centerLow, lowY);
    canvas.drawPath(path, strokePaint);
    canvas.drawLine(
        Offset(openX, openY),
        Offset(isTransposed ? openX : centerHigh, isTransposed ? highY : openY),
        strokePaint);
    canvas.drawLine(
        Offset(closeX, closeY),
        Offset(
            isTransposed ? closeX : centerLow, isTransposed ? highY : closeY),
        strokePaint);
  }

  Path drawDashedHiloOpenClosePath(Canvas canvas) {
    path.moveTo(centerHigh, highY);
    path.lineTo(centerLow, lowY);
    path.moveTo(openX, openY);
    path.lineTo(
        isTransposed ? openX : centerHigh, isTransposed ? highY : openY);
    path.moveTo(
        isTransposed ? closeX : centerLow, isTransposed ? highY : closeY);
    path.lineTo(closeX, closeY);
    return path;
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    if (series.selectionSettings.enable) {
      series.selectionSettings._selectionRenderer._checkWithSelectionState(
          series.segments[currentSegmentIndex], series._chart);
    }
    if (strokePaint != null) {
      path = Path();
      if (series.animationDuration > 0 &&
          !series._chart._chartState._isLegendToggled) {
        if (!series._chart._chartState.widgetNeedUpdate) {
          if (isTransposed) {
            centerX = highX + ((lowX - highX) / 2);
            openX = centerX -
                ((centerX - _currentPoint.openPoint.x) * animationFactor);
            closeX = centerX +
                ((_currentPoint.closePoint.x - centerX) * animationFactor);
            highX = centerX + ((centerX - highX).abs() * animationFactor);
            lowX = centerX - ((lowX - centerX).abs() * animationFactor);
            canvas.drawLine(Offset(lowX, centerLowPoint.y),
                Offset(highX, centerHighPoint.y), strokePaint);
            canvas.drawLine(
                Offset(openX, openY), Offset(openX, highY), strokePaint);
            canvas.drawLine(
                Offset(closeX, lowY), Offset(closeX, closeY), strokePaint);
          } else {
            centerY = high + ((low - high) / 2);
            openY = centerY -
                ((centerY - _currentPoint.openPoint.y) * animationFactor);
            closeY = centerY +
                ((_currentPoint.closePoint.y - centerY) * animationFactor);
            highY = centerY - ((centerY - high) * animationFactor);
            lowY = centerY + ((low - centerY) * animationFactor);
            canvas.drawLine(Offset(centerHigh, highY), Offset(centerLow, lowY),
                strokePaint);
            canvas.drawLine(
                Offset(openX, openY), Offset(centerHigh, openY), strokePaint);
            canvas.drawLine(
                Offset(centerLow, closeY), Offset(closeX, closeY), strokePaint);
          }
        } else {
          currentSegment = series.segments[currentSegmentIndex];
          oldSegment = (currentSegment.oldSeries.segments.isNotEmpty &&
                  currentSegment.oldSeries.segments[0]
                      is HiloOpenCloseSegment &&
                  currentSegment.oldSeries.segments.length - 1 >=
                      currentSegmentIndex)
              ? currentSegment.oldSeries.segments[currentSegmentIndex]
              : null;
          _animateHiloOpenCloseSeries(
              isTransposed,
              isTransposed ? lowPoint.x : low,
              isTransposed ? highPoint.x : high,
              isTransposed
                  ? (oldSegment != null ? oldSegment.lowPoint.x : null)
                  : oldSegment?.low,
              isTransposed
                  ? (oldSegment != null ? oldSegment.highPoint.x : null)
                  : oldSegment?.high,
              openX,
              openY,
              closeX,
              closeY,
              isTransposed ? centerLowPoint.y : centerLow,
              isTransposed ? centerHighPoint.y : centerHigh,
              oldSegment?.openX,
              oldSegment?.openY,
              oldSegment?.closeX,
              oldSegment?.closeY,
              isTransposed
                  ? (oldSegment != null ? oldSegment.centerLowPoint.y : null)
                  : oldSegment?.centerLow,
              isTransposed
                  ? (oldSegment != null ? oldSegment.centerHighPoint.y : null)
                  : oldSegment?.centerHigh,
              animationFactor,
              strokePaint,
              canvas);
        }
      } else {
        if (series.dashArray[0] != 0 && series.dashArray[1] != 0) {
          _drawDashedLine(canvas, series.dashArray, strokePaint,
              drawDashedHiloOpenClosePath(canvas));
        } else {
          drawHiloOpenClosePath(canvas);
        }
      }
    }
  }
}
