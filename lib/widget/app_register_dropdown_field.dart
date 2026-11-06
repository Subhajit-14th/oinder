import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class AppDropdownField<T> extends StatefulWidget {
  // —— Label ——
  final bool showLabel;
  final String labelText;
  final InlineSpan? richLabel;

  // —— Core ——
  final List<T> items;
  final T? value;
  final String Function(T item) itemAsString;
  final ValueChanged<T> onChanged;

  // —— UI ——
  final String hintText;
  final TextEditingController controller;
  final bool enabled;

  const AppDropdownField({
    super.key,
    this.showLabel = true,
    this.labelText = '',
    this.richLabel,
    required this.items,
    required this.itemAsString,
    required this.onChanged,
    required this.controller,
    this.value,
    this.hintText = '',
    this.enabled = true,
  });

  @override
  State<AppDropdownField<T>> createState() => _AppDropdownFieldState<T>();
}

class _AppDropdownFieldState<T> extends State<AppDropdownField<T>>
    with SingleTickerProviderStateMixin {
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
  }

  @override
  void didUpdateWidget(covariant AppDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null) {
      widget.controller.text = widget.itemAsString(widget.value as T);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry);
    _animationController.forward();
    setState(() => _isOpen = true);
  }

  Future<void> _closeDropdown() async {
    await _animationController.reverse();
    _overlayEntry.remove();
    setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (_) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, size.height + 2),
          showWhenUnlinked: false,
          child: Material(
            color: Colors.transparent,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(14),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    children: widget.items.map((item) {
                      return InkWell(
                        onTap: () {
                          widget.controller.text = widget.itemAsString(item);
                          widget.onChanged(item);
                          _closeDropdown();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Text(
                            widget.itemAsString(item),
                            style: Styles.textStyle(fontSize: 15),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? Colors.white54 : AppColor.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel && widget.labelText.isNotEmpty) ...[
          widget.richLabel != null
              ? RichText(text: widget.richLabel!)
              : Texts(widget.labelText, fontSize: 15),
          const SizedBox(height: 12),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: widget.enabled ? _toggleDropdown : null,
            child: AbsorbPointer(
              child: TextFormField(
                controller: widget.controller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: Icon(
                    _isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
