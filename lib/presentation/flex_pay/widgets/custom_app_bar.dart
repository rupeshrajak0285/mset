import '../../../common_libraries.dart';


class OctaveTabData {
  final String label;
  final Widget content;
  final bool isEnabled;

  OctaveTabData({
    required this.label,
    required this.content,
    this.isEnabled = true,
  });
}

class OctaveTabBarWidget extends StatefulWidget {
  final List<OctaveTabData> tabs;
  final ValueChanged<int>? onTabChanged;
  final int initialIndex; // ✅ NEW
  final Color indicatorColor;
  final double indicatorHeight;
  final Duration animationDuration;

  const OctaveTabBarWidget({
    super.key,
    required this.tabs,
    this.onTabChanged,
    this.initialIndex = 0, // ✅ NEW
    this.indicatorColor = const Color(0xFF22D3EE),
    this.indicatorHeight = 4.0,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<OctaveTabBarWidget> createState() => _OctaveTabBarWidgetState();
}

class _OctaveTabBarWidgetState extends State<OctaveTabBarWidget> {
  late final PageController _pageController;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _tabKeys = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _tabKeys.addAll(List.generate(widget.tabs.length, (_) => GlobalKey()));
    _pageController = PageController(initialPage: _selectedIndex)
      ..addListener(() {
        final page = _pageController.page ?? _selectedIndex.toDouble();
        final newIndex = page.round();
        if (_selectedIndex != newIndex) {
          setState(() => _selectedIndex = newIndex);
          widget.onTabChanged?.call(newIndex);
          _scrollToSelectedTab(newIndex);
        }
      });
  }

  @override
  void didUpdateWidget(covariant OctaveTabBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ✅ If parent passes new initialIndex, reflect the change
    if (widget.initialIndex != oldWidget.initialIndex &&
        widget.initialIndex != _selectedIndex) {
      _onTabTap(widget.initialIndex);
    }

    if (oldWidget.tabs.length != widget.tabs.length) {
      _tabKeys.clear();
      _tabKeys.addAll(List.generate(widget.tabs.length, (_) => GlobalKey()));
    }
  }

  void _onTabTap(int index) {
    if (!widget.tabs[index].isEnabled) return;
    _pageController.animateToPage(
      index,
      duration: widget.animationDuration,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _scrollToSelectedTab(int index) async {
    final keyContext = _tabKeys[index].currentContext;
    if (keyContext == null) return;

    final box = keyContext.findRenderObject() as RenderBox?;
    final tabPosition = box?.localToGlobal(Offset.zero);
    final tabWidth = box?.size.width ?? 0;

    final scrollBox = context.findRenderObject() as RenderBox?;
    if (tabPosition == null || scrollBox == null) return;

    final scrollPos = _scrollController.offset;
    final screenWidth = scrollBox.size.width;

    final targetScrollX = scrollPos + tabPosition.dx - (screenWidth / 2) + (tabWidth / 2);

    _scrollController.animateTo(
      targetScrollX.clamp(
        _scrollController.position.minScrollExtent,
        _scrollController.position.maxScrollExtent,
      ),
      duration: widget.animationDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabBar(context),
        const OctaveHorizontalDivider(margin: EdgeInsets.zero),
        SizedBox(height: 15,),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.tabs.length,
            itemBuilder: (context, index) => widget.tabs[index].content,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            final currentPage = _pageController.page ?? _selectedIndex.toDouble();

            return SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(widget.tabs.length, (index) {
                  final tab = widget.tabs[index];
                  final isSelected = index == _selectedIndex;

                  final textStyle = isSelected
                      ? TextStyle(color: Colors.white, fontWeight: FontWeight.w400)
                      : TextStyle(color: Color(0xFF6B7280),fontWeight: FontWeight.w400);

                  final key = _tabKeys[index];

                  final textPainter = TextPainter(
                    text: TextSpan(text: tab.label, style: textStyle),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  )..layout();

                  final textWidth = textPainter.width;

                  final selectedness = 1.0 - (currentPage - index).abs().clamp(0.0, 1.0);
                  final indicatorWidth = textWidth * selectedness;

                  return GestureDetector(
                    key: key,
                    onTap: () => _onTabTap(index),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 28,),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tab.label, style: textStyle),
                          const SizedBox(height: 8),
                          Container(
                            height: widget.indicatorHeight,
                            width: indicatorWidth,
                            decoration: BoxDecoration(
                              color: index == currentPage.round()
                                  ? widget.indicatorColor
                                  : widget.indicatorColor.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}
class OctaveHorizontalDivider extends StatelessWidget {
  final double thickness;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  const OctaveHorizontalDivider({
    super.key,
    this.thickness = 1,
    this.color,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,  // take full available width
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      height: thickness,       // fixed height (thickness)
      color: color ?? Color(0xFF6B7280),
    );
  }
}