import 'package:avk/router/path_exporter.dart';

class NameId {
  final String id;
  final String name;

  NameId({required this.id, required this.name});
}
class GenericDropdown<T> extends StatelessWidget {
  const GenericDropdown({
    required this.items,
    required this.onChanged,
    required this.itemLabelBuilder,
    required this.headerLabelBuilder,
    super.key,
    this.selectedItem,
    this.hintText,
    this.searchHintText,
    this.validator,
    this.maxWidth,
    this.formKey,
    this.isSearchFieldRequired = true,
  });

  final List<T> items;
  final T? selectedItem;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final String? searchHintText;
  final double? maxWidth;
  final String Function(T item) itemLabelBuilder;
  final String Function(T selectedItem) headerLabelBuilder;
  final bool isSearchFieldRequired;
  final GlobalKey? formKey;
  @override
  Widget build(BuildContext context) {
    final Widget dropdown = isSearchFieldRequired
        ? CustomDropdown<T>.search(
      formKey: formKey,
      initialItem: selectedItem,
      items: items,
      onChanged: onChanged,
      hintText: hintText,
      searchHintText: searchHintText,
      validator: validator,
      hideSelectedFieldWhenExpanded: true,
      listItemBuilder: (BuildContext ctx, item, bool isSelected, onSelect) =>
          _defaultItemBuilder(ctx, item),
      headerBuilder: (BuildContext ctx, item, _) => _defaultHeaderBuilder(ctx, item),

    )
        : CustomDropdown<T>(
      formKey: formKey,
      initialItem: selectedItem,
      items: items,
      onChanged: onChanged,
      hintText: hintText,
      validator: validator,
      hideSelectedFieldWhenExpanded: true,
      listItemBuilder: (BuildContext ctx, T item, bool isSelected, _) =>
          _defaultItemBuilder(ctx, item),
      headerBuilder: (BuildContext ctx, T item, _) => _defaultHeaderBuilder(ctx, item),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth ?? 287),
      child: dropdown,
    );
  }

  Widget _defaultItemBuilder(BuildContext context, T item) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            itemLabelBuilder(item),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Widget _defaultHeaderBuilder(BuildContext context, T selectedItem) {
    return Text(
      headerLabelBuilder(selectedItem),
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
