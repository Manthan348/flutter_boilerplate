import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppDateTimePickerMode { date, time, dateTime, dateRange }

enum AppDateTimePickerStyle { adaptive, material, cupertinoBottomSheet }

class AppDateTimePickerField extends StatefulWidget {
  const AppDateTimePickerField({
    super.key,
    required this.label,
    this.hint,
    this.mode = AppDateTimePickerMode.date,
    this.initialDateTime,
    this.initialDateRange,
    this.firstDate,
    this.lastDate,
    this.pickerStyle = AppDateTimePickerStyle.adaptive,
    this.cupertinoSheetHeight = 300,
    this.cupertinoDoneText = 'Done',
    this.cupertinoCancelText = 'Cancel',
    this.enabled = true,
    this.required = false,
    this.requiredMessage,
    this.prefixIcon,
    this.suffixIcon,
    this.onDateTimeChanged,
    this.onDateRangeChanged,
    this.validator,
  });

  final String label;
  final String? hint;
  final AppDateTimePickerMode mode;
  final DateTime? initialDateTime;
  final DateTimeRange? initialDateRange;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final AppDateTimePickerStyle pickerStyle;
  final double cupertinoSheetHeight;
  final String cupertinoDoneText;
  final String cupertinoCancelText;
  final bool enabled;
  final bool required;
  final String? requiredMessage;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<DateTime?>? onDateTimeChanged;
  final ValueChanged<DateTimeRange?>? onDateRangeChanged;
  final String? Function(DateTime? value, DateTimeRange? range)? validator;

  @override
  State<AppDateTimePickerField> createState() => _AppDateTimePickerFieldState();
}

class _AppDateTimePickerFieldState extends State<AppDateTimePickerField> {
  late final TextEditingController _textController;
  DateTime? _selectedDateTime;
  DateTimeRange? _selectedRange;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
    _selectedRange = widget.initialDateRange;
    _textController = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant AppDateTimePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialDateTime != widget.initialDateTime ||
        oldWidget.initialDateRange != widget.initialDateRange) {
      _selectedDateTime = widget.initialDateTime;
      _selectedRange = widget.initialDateRange;
      _syncText();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncText();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  DateTime get _firstDate =>
      widget.firstDate ?? DateTime(DateTime.now().year - 100);

  DateTime get _lastDate =>
      widget.lastDate ?? DateTime(DateTime.now().year + 100);

  DateTime _dateBase() => _selectedDateTime ?? DateTime.now();
  bool get _useCupertinoPicker {
    if (widget.pickerStyle == AppDateTimePickerStyle.cupertinoBottomSheet) {
      return true;
    }
    if (widget.pickerStyle == AppDateTimePickerStyle.material) {
      return false;
    }
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  DateTime _clampDate(DateTime date) {
    if (date.isBefore(_firstDate)) {
      return _firstDate;
    }
    if (date.isAfter(_lastDate)) {
      return _lastDate;
    }
    return date;
  }

  Future<void> _pick() async {
    if (!widget.enabled) {
      return;
    }

    switch (widget.mode) {
      case AppDateTimePickerMode.date:
        await _pickDateOnly();
      case AppDateTimePickerMode.time:
        await _pickTimeOnly();
      case AppDateTimePickerMode.dateTime:
        await _pickDateTime();
      case AppDateTimePickerMode.dateRange:
        await _pickDateRange();
    }
  }

  Future<void> _pickDateOnly() async {
    final DateTime initialDate = _clampDate(_dateBase());
    final bool useCupertinoPicker = _useCupertinoPicker;

    final DateTime? picked;
    if (useCupertinoPicker) {
      picked = await _showCupertinoDateTimePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: initialDate,
        minimumDate: _firstDate,
        maximumDate: _lastDate,
      );
    } else {
      picked = await showDatePicker(
        context: context,
        firstDate: _firstDate,
        lastDate: _lastDate,
        initialDate: initialDate,
      );
    }

    if (picked == null) {
      return;
    }

    setState(() {
      _selectedDateTime = DateTime(
        picked!.year,
        picked.month,
        picked.day,
        _selectedDateTime?.hour ?? 0,
        _selectedDateTime?.minute ?? 0,
      );
      _syncText();
    });
    widget.onDateTimeChanged?.call(_selectedDateTime);
  }

  Future<void> _pickTimeOnly() async {
    final DateTime base = _dateBase();
    if (_useCupertinoPicker) {
      final DateTime? picked = await _showCupertinoDateTimePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: base,
      );

      if (picked == null) {
        return;
      }

      setState(() {
        _selectedDateTime = DateTime(
          base.year,
          base.month,
          base.day,
          picked.hour,
          picked.minute,
        );
        _syncText();
      });
      widget.onDateTimeChanged?.call(_selectedDateTime);
      return;
    }

    final TimeOfDay initial = TimeOfDay.fromDateTime(base);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _selectedDateTime = DateTime(
        base.year,
        base.month,
        base.day,
        picked.hour,
        picked.minute,
      );
      _syncText();
    });
    widget.onDateTimeChanged?.call(_selectedDateTime);
  }

  Future<void> _pickDateTime() async {
    final DateTime base = _dateBase();
    if (_useCupertinoPicker) {
      final DateTime? picked = await _showCupertinoDateTimePicker(
        mode: CupertinoDatePickerMode.dateAndTime,
        initialDateTime: _clampDate(base),
        minimumDate: _firstDate,
        maximumDate: _lastDate,
      );

      if (picked == null) {
        return;
      }

      setState(() {
        _selectedDateTime = picked;
        _syncText();
      });
      widget.onDateTimeChanged?.call(_selectedDateTime);
      return;
    }

    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: _firstDate,
      lastDate: _lastDate,
      initialDate: base.isBefore(_firstDate)
          ? _firstDate
          : (base.isAfter(_lastDate) ? _lastDate : base),
    );

    if (date == null || !mounted) {
      return;
    }

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );

    if (time == null) {
      return;
    }

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      _syncText();
    });
    widget.onDateTimeChanged?.call(_selectedDateTime);
  }

  Future<void> _pickDateRange() async {
    final DateTimeRange initialRange =
        _selectedRange ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 7)),
        );

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: _firstDate,
      lastDate: _lastDate,
      initialDateRange: initialRange,
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _selectedRange = picked;
      _syncText();
    });
    widget.onDateRangeChanged?.call(_selectedRange);
  }

  Future<DateTime?> _showCupertinoDateTimePicker({
    required CupertinoDatePickerMode mode,
    required DateTime initialDateTime,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) async {
    DateTime tempValue = initialDateTime;

    return showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: widget.cupertinoSheetHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(widget.cupertinoCancelText),
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          onPressed: () => Navigator.of(context).pop(tempValue),
                          child: Text(widget.cupertinoDoneText),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: mode,
                      initialDateTime: initialDateTime,
                      minimumDate: minimumDate,
                      maximumDate: maximumDate,
                      use24hFormat: false,
                      onDateTimeChanged: (DateTime value) {
                        tempValue = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _syncText() {
    final MaterialLocalizations l10n = MaterialLocalizations.of(context);

    switch (widget.mode) {
      case AppDateTimePickerMode.date:
        if (_selectedDateTime == null) {
          _textController.text = '';
          return;
        }
        _textController.text = l10n.formatMediumDate(_selectedDateTime!);
      case AppDateTimePickerMode.time:
        if (_selectedDateTime == null) {
          _textController.text = '';
          return;
        }
        _textController.text = l10n.formatTimeOfDay(
          TimeOfDay.fromDateTime(_selectedDateTime!),
          alwaysUse24HourFormat: false,
        );
      case AppDateTimePickerMode.dateTime:
        if (_selectedDateTime == null) {
          _textController.text = '';
          return;
        }
        _textController.text =
            '${l10n.formatMediumDate(_selectedDateTime!)} ${l10n.formatTimeOfDay(TimeOfDay.fromDateTime(_selectedDateTime!))}';
      case AppDateTimePickerMode.dateRange:
        if (_selectedRange == null) {
          _textController.text = '';
          return;
        }
        _textController.text =
            '${l10n.formatMediumDate(_selectedRange!.start)} - ${l10n.formatMediumDate(_selectedRange!.end)}';
    }
  }

  String? _validate() {
    if (widget.required) {
      final bool hasValue = widget.mode == AppDateTimePickerMode.dateRange
          ? _selectedRange != null
          : _selectedDateTime != null;

      if (!hasValue) {
        return widget.requiredMessage ?? '${widget.label} is required';
      }
    }

    return widget.validator?.call(_selectedDateTime, _selectedRange);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      readOnly: true,
      enabled: widget.enabled,
      onTap: _pick,
      validator: (_) => _validate(),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon:
            widget.suffixIcon ?? const Icon(Icons.calendar_month_outlined),
      ),
    );
  }
}
