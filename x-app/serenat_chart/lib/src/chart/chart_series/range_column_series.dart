part of charts;

/// Renders the range column series.
///
/// To render a range column chart, create an instance of RangeColumnSeries and add to the series collection property of [SfCartesianChart].
///
/// RangeColumnSeries is similar to column series but requires two Y values for a point,
/// your data should contain high and low values.
/// High and low value specify the maximum and minimum range of the point.
///
/// * [highValueMapper] - Field in the data source, which is considered as high value for the data points.
/// * [lowValueMapper] - Field in the data source, which is considered as low value for the data points.
class RangeColumnSeries<T, D> extends XyDataSeries<T, D> {
  RangeColumnSeries(
      {@required List<T> dataSource,
      @required ChartValueMapper<T, D> xValueMapper,
      @required ChartValueMapper<T, num> highValueMapper,
      @required ChartValueMapper<T, num> lowValueMapper,
      ChartValueMapper<T, dynamic> sortFieldValueMapper,
      ChartValueMapper<T, Color> pointColorMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      SortingOrder sortingOrder,
      this.isTrackVisible = false,
      String xAxisName,
      String yAxisName,
      String name,
      Color color,
      double width,
      double spacing,
      MarkerSettings markerSettings,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      bool isVisible,
      LinearGradient gradient,
      BorderRadius borderRadius,
      bool enableTooltip,
      double animationDuration,
      Color trackColor,
      Color trackBorderColor,
      double trackBorderWidth,
      double trackPadding,
      Color borderColor,
      List<Trendline> trendlines,
      double borderWidth,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      String legendItemText,
      double opacity,
      List<double> dashArray,
      List<int> initialSelectedDataIndexes})
      : trackColor = trackColor ?? Colors.grey,
        trackBorderColor = trackBorderColor ?? Colors.transparent,
        trackBorderWidth = trackBorderWidth ?? 1,
        trackPadding = trackPadding ?? 0,
        spacing = spacing ?? 0,
        borderRadius = borderRadius ?? const BorderRadius.all(Radius.zero),
        super(
            name: name,
            xValueMapper: xValueMapper,
            highValueMapper: highValueMapper,
            lowValueMapper: lowValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            trendlines: trendlines,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            color: color,
            width: width ?? 0.7,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            isVisible: isVisible,
            gradient: gradient,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            borderColor: borderColor,
            borderWidth: borderWidth,
            selectionSettings: selectionSettings,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            dashArray: dashArray,
            initialSelectedDataIndexes: initialSelectedDataIndexes);
  num _rectPosition;
  num _rectCount;

  ///Color of the track.
  ///
  ///Defaults to `grey`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                  trackColor: Colors.red
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color trackColor;

  ///Color of the track border.
  ///
  ///Defaults to `transparent`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                  trackBorderColor: Colors.red
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color trackBorderColor;

  ///Width of the track border.
  ///
  ///Defaults to `1`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                  trackBorderColor: Colors.red ,
  ///                  trackBorderWidth: 2
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double trackBorderWidth;

  ///Padding of the track.
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                  trackPadding: 2
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double trackPadding;

  ///Spacing between the columns.
  ///
  ///The value ranges from 0 to 1. 1 represents 100% and 0 represents 0% of the available space.
  ///
  ///Spacing also affects the width of the range column. For example, setting 20% spacing
  ///and 100% width renders the column with 80% of total width.
  ///
  ///Defaults to `0`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                  spacing: 0,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double spacing;

  ///Renders range column with track.
  ///
  /// Track is a rectangular bar rendered from the start to the end of the axis. Range Column Series will be rendered
  /// above the track.
  ///
  ///Defaults to `false`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                  isTrackVisible: true,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool isTrackVisible;

  ///Customizes the corners of the range column.
  ///
  /// Each corner can be customized with a desired value or with a single value.
  ///
  ///Defaults to `zero`.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                  borderRadius: BorderRadius.circular(5),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final BorderRadius borderRadius;

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => RangeColumnSegment();

  /// Creates a collection of segments for the points in the series.
  @override
  void createSegments() {}

  void drawSegment(Canvas canvas, ChartSegment segment) {
    segment.onPaint(canvas);
  }

  ChartSegment addSegment(CartesianChartPoint<dynamic> currentPoint,
      int pointIndex, int seriesIndex, num animateFactor) {
    final RangeColumnSegment segment = createSegment();
    segment._seriesIndex = seriesIndex;
    segment.currentSegmentIndex = pointIndex;
    segment.series = this;
    segment.chart = _chart;
    segment.animationFactor = animateFactor;
    segment._currentPoint = currentPoint;
    segment.path = _dashedBorder(currentPoint, borderWidth);
    if (borderRadius != null) {
      segment.segmentRect = getRRectFromRect(currentPoint.region, borderRadius);

      //Tracker rect
      if (isTrackVisible) {
        segment._trackRect =
            getRRectFromRect(currentPoint.trackerRectRegion, borderRadius);
      }
    }
    customizeSegment(segment);

    segments.add(segment);
    return segment;
  }

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment segment) {
    final RangeColumnSegment rangeColumnSegment = segment;
    rangeColumnSegment.color = segment.series._seriesColor;
    rangeColumnSegment.strokeColor = segment.series.borderColor;
    rangeColumnSegment.strokeWidth = segment.series.borderWidth;
    rangeColumnSegment.strokePaint = rangeColumnSegment.getStrokePaint();
    rangeColumnSegment.fillPaint = rangeColumnSegment.getFillPaint();
    rangeColumnSegment._trackerFillPaint =
        rangeColumnSegment._getTrackerFillPaint();
    rangeColumnSegment._trackerStrokePaint =
        rangeColumnSegment._getTrackerStrokePaint();
  }

  ///Draws marker with different shape and color of the appropriate data point in the series.
  @override
  void drawDataMarker(int index, Canvas canvas, Paint fillPaint,
      Paint strokePaint, double pointX, double pointY) {
    canvas.drawPath(_markerShapes[index], strokePaint);
    canvas.drawPath(_markerShapes[index], fillPaint);
    canvas.drawPath(_markerShapes2[index], strokePaint);
    canvas.drawPath(_markerShapes2[index], fillPaint);
  }

  /// Draws data label text of the appropriate data point in a series.
  @override
  void drawDataLabel(int index, Canvas canvas, String dataLabel, double pointX,
          double pointY, int angle, ChartTextStyle style) =>
      _drawText(canvas, dataLabel, Offset(pointX, pointY), style, angle);
}
