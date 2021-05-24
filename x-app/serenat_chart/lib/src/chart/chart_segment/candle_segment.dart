part of charts;

/// Creates the segments for bubble series.
///
/// Generates the candle series points and has the [calculateSegmentPoints] override method
/// used to customize the candle series segment point calculation.
///
/// Gets the path and fill color from the [series] to render the candle segment.
///
class CandleSegment extends ChartSegment {
  /// X position.
  num x;

  /// Low value.
  num low;

  /// High value.
  num high;

  /// X position value.
  num xPos;

  /// Low position value.
  num lowPos;

  /// High position value.
  num highPos;

  /// Center Y value.
  num centerY;

  ///High value of Y.
  num highY;

  /// Open value of X.
  num openX;

  /// Open value of Y.
  num openY;

  /// Close value of X.
  num closeX;

  /// Close value of Y.
  num closeY;

  /// Center high value.
  num centerHigh;

  /// Center low value.
  num centerLow;

  /// Y value of low value.
  num lowY;

  /// Start position value.
  num startPos;

  /// End position value.
  num endPos;

  /// Open value.
  num open;

  /// Close value.
  num close;

  Color _pointColorMapper;
  bool isBull = false;
  CartesianChartPoint<dynamic> _currentPoint;
  double width = 0;
  bool isSolid = false, isTransposed;
  Path path, linePath;
  bool _showSameValue;
  _ChartLocation openPoint,
      closePoint,
      lowPoint,
      highPoint,
      centerLowPoint,
      centerHighPoint;

  num centersY, topRectY, topLineY, bottomRectY, bottomLineY;

  CandleSeries<dynamic, dynamic> candleSeries;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    fillPaint = Paint()
      ..color = _currentPoint.isEmpty != null && _currentPoint.isEmpty
          ? series.emptyPointSettings.color
          : (_currentPoint.pointColorMapper ?? color);
    fillPaint.color =
        (series.opacity < 1 && fillPaint.color != Colors.transparent)
            ? fillPaint.color.withOpacity(series.opacity)
            : fillPaint.color;
    fillPaint.strokeWidth = strokeWidth;
    fillPaint.style = isSolid ? PaintingStyle.fill : PaintingStyle.stroke;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    if (series.gradient == null) {
      if (strokeColor != null) {
        strokePaint.color = _pointColorMapper ?? strokeColor;
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
    candleSeries = series;
    isBull = _currentPoint.open < _currentPoint.close;
    x = high = low = double.nan;
    isTransposed = series._chart._requireInvertedAxis;
    lowPoint = _currentPoint.lowPoint;
    highPoint = _currentPoint.highPoint;
    centerLowPoint = _currentPoint.centerLowPoint;
    centerHighPoint = _currentPoint.centerHighPoint;
    x = lowPoint.x;
    low = lowPoint.y;
    high = highPoint.y;
    centerHigh = centerHighPoint.x;
    highY = centerHighPoint.y;
    centerLow = centerLowPoint.x;
    lowY = centerLowPoint.y;
    openX = _currentPoint.openPoint.x;
    openY = _currentPoint.openPoint.y;
    closeX = _currentPoint.closePoint.x;
    closeY = _currentPoint.closePoint.y;

    _showSameValue = candleSeries.showIndicationForSameValues &&
        (!series._chart._requireInvertedAxis
            ? centerHighPoint.y == centerLowPoint.y
            : centerHighPoint.x == centerLowPoint.x);

    x = lowPoint.x =
        (_showSameValue && isTransposed) ? lowPoint.x - 2 : lowPoint.x;
    highPoint.x =
        (_showSameValue && isTransposed) ? highPoint.x + 2 : highPoint.x;
    low = lowPoint.y =
        (_showSameValue && !isTransposed) ? lowPoint.y - 2 : lowPoint.y;
    high = highPoint.y =
        (_showSameValue && !isTransposed) ? highPoint.y + 2 : highPoint.y;
    centerHigh = centerHighPoint.x = (_showSameValue && isTransposed)
        ? centerHighPoint.x + 2
        : centerHighPoint.x;
    highY = centerHighPoint.y = (_showSameValue && !isTransposed)
        ? centerHighPoint.y + 2
        : centerHighPoint.y;
    centerLow = centerLowPoint.x = (_showSameValue && isTransposed)
        ? centerLowPoint.x - 2
        : centerLowPoint.x;
    lowY = centerLowPoint.y = (_showSameValue && !isTransposed)
        ? centerLowPoint.y - 2
        : centerLowPoint.y;
  }

  void drawRectPath() {
    path.moveTo(
        !isTransposed ? openX : topRectY, !isTransposed ? topRectY : closeY);
    path.lineTo(
        !isTransposed ? closeX : topRectY, !isTransposed ? topRectY : openY);
    path.lineTo(!isTransposed ? closeX : bottomRectY,
        !isTransposed ? bottomRectY : openY);
    path.lineTo(!isTransposed ? openX : bottomRectY,
        !isTransposed ? bottomRectY : closeY);
    path.lineTo(
        !isTransposed ? openX : topRectY, !isTransposed ? topRectY : closeY);
    path.close();
  }

  void drawLine(Canvas canvas) {
    canvas.drawLine(
        Offset(centerHigh, topRectY), Offset(centerHigh, topLineY), fillPaint);
    canvas.drawLine(Offset(centerHigh, bottomRectY),
        Offset(centerHigh, bottomLineY), fillPaint);
  }

  void drawFillLine(Canvas canvas) {
    final bool isOpen = _currentPoint.open > _currentPoint.close;
    canvas.drawLine(
        Offset(topRectY, highY),
        Offset(
            topRectY +
                ((isOpen ? (openX - centerHigh) : (closeX - centerHigh)).abs() *
                    animationFactor),
            highY),
        fillPaint);
    canvas.drawLine(
        Offset(bottomRectY, highY),
        Offset(
            bottomRectY -
                ((isOpen ? (closeX - centerLow) : (openX - centerLow)).abs() *
                    animationFactor),
            highY),
        fillPaint);
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    if (series.selectionSettings.enable) {
      series.selectionSettings._selectionRenderer._checkWithSelectionState(
          series.segments[currentSegmentIndex], series._chart);
    }
    if (fillPaint != null &&
        !(series._chart._chartState.widgetNeedUpdate &&
            !series._chart._chartState._isLegendToggled)) {
      path = Path();
      linePath = Path();
      if (!isTransposed && _currentPoint.open > _currentPoint.close) {
        final num temp = closeY;
        closeY = openY;
        openY = temp;
      }

      if (series._chart._chartState._isLegendToggled) {
        animationFactor = 1;
      }
      centersY = closeY + ((closeY - openY).abs() / 2);
      topRectY = centersY - ((centersY - closeY).abs() * animationFactor);
      topLineY = topRectY - ((topRectY - highY).abs() * animationFactor);
      bottomRectY = centersY + ((centersY - openY).abs() * animationFactor);
      bottomLineY =
          bottomRectY + ((bottomRectY - lowY).abs() * animationFactor);

      bottomLineY = lowY < openY
          ? bottomRectY - ((openY - lowY).abs() * animationFactor)
          : bottomLineY;

      topLineY = highY > closeY
          ? topRectY + ((closeY - highY).abs() * animationFactor)
          : topLineY;

      if (isTransposed) {
        if (_currentPoint.open > _currentPoint.close) {
          centersY = closeX + ((openX - closeX).abs() / 2);
          topRectY = centersY + ((centersY - openX).abs() * animationFactor);
          bottomRectY =
              centersY - ((centersY - closeX).abs() * animationFactor);
        } else {
          centersY = openX + (closeX - openX).abs() / 2;
          topRectY = centersY + ((centersY - closeX).abs() * animationFactor);
          bottomRectY = centersY - ((centersY - openX).abs() * animationFactor);
        }
        if (_showSameValue) {
          canvas.drawLine(Offset(centerHighPoint.x, centerHighPoint.y),
              Offset(centerLowPoint.x, centerHighPoint.y), fillPaint);
        } else {
          path.moveTo(topRectY, highY);
          centerHigh < closeX
              ? path.lineTo(
                  topRectY - ((closeX - centerHigh).abs() * animationFactor),
                  highY)
              : path.lineTo(
                  topRectY + ((closeX - centerHigh).abs() * animationFactor),
                  highY);
          path.moveTo(bottomRectY, highY);
          centerLow > openX
              ? path.lineTo(
                  bottomRectY + ((openX - centerLow).abs() * animationFactor),
                  highY)
              : path.lineTo(
                  bottomRectY - ((openX - centerLow).abs() * animationFactor),
                  highY);
          linePath = path;
        }
        openX == closeX
            ? canvas.drawLine(
                Offset(openX, openY), Offset(closeX, closeY), fillPaint)
            : drawRectPath();
      } else {
        if (_currentPoint.open > _currentPoint.close) {
          final num temp = closeY;
          closeY = openY;
          openY = temp;
        }
        _showSameValue
            ? canvas.drawLine(Offset(centerHighPoint.x, highPoint.y),
                Offset(centerHighPoint.x, lowPoint.y), fillPaint)
            : drawLine(canvas);

        openY == closeY
            ? canvas.drawLine(
                Offset(openX, openY), Offset(closeX, closeY), fillPaint)
            : drawRectPath();
      }

      if (series.dashArray[0] != 0 &&
          series.dashArray[1] != 0 &&
          fillPaint.style != PaintingStyle.fill &&
          series.animationDuration <= 0) {
        _drawDashedLine(canvas, series.dashArray, fillPaint, path);
      } else {
        canvas.drawPath(path, fillPaint);
        if (fillPaint.style == PaintingStyle.fill) {
          if (isTransposed) {
            if (_currentPoint.open > _currentPoint.close) {
              _showSameValue
                  ? canvas.drawLine(
                      Offset(centerHighPoint.x, centerHighPoint.y),
                      Offset(centerLowPoint.x, centerHighPoint.y),
                      fillPaint)
                  : drawFillLine(canvas);
            } else {
              _showSameValue
                  ? canvas.drawLine(
                      Offset(centerHighPoint.x, centerHighPoint.y),
                      Offset(centerLowPoint.x, centerHighPoint.y),
                      fillPaint)
                  : drawFillLine(canvas);
            }
          } else {
            _showSameValue
                ? canvas.drawLine(Offset(centerHighPoint.x, highPoint.y),
                    Offset(centerHighPoint.x, lowPoint.y), fillPaint)
                : drawLine(canvas);
          }
        }
      }
    } else if (!series._chart._chartState._isLegendToggled) {
      final CandleSegment currentSegment = series.segments[currentSegmentIndex];
      final CandleSegment oldSegment =
          (currentSegment.oldSeries.segments.isNotEmpty &&
                  currentSegment.oldSeries.segments[0] is CandleSegment &&
                  currentSegment.oldSeries.segments.length - 1 >=
                      currentSegmentIndex)
              ? currentSegment.oldSeries.segments[currentSegmentIndex]
              : null;
      _animateCandleSeries(
          _showSameValue,
          high,
          isTransposed,
          _currentPoint.open,
          _currentPoint.close,
          lowY,
          highY,
          oldSegment?.lowY,
          oldSegment?.highY,
          openX,
          openY,
          closeX,
          closeY,
          centerLow,
          centerHigh,
          oldSegment?.openX,
          oldSegment?.openY,
          oldSegment?.closeX,
          oldSegment?.closeY,
          oldSegment?.centerLow,
          oldSegment?.centerHigh,
          animationFactor,
          fillPaint,
          canvas);
    }
  }
}
