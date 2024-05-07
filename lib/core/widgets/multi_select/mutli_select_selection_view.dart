part of "multi_select_form_field.dart";

class _MultiSelectSelectionView extends StatefulWidget {
  final String label;
  final List<FormOptions> items;
  final List selectedItems;
  final String hintText;
  final ValueChanged<List>? onChanged;
  final bool allowMultiSelect;

  const _MultiSelectSelectionView({
    required this.label,
    required this.items,
    required this.hintText,
    this.selectedItems = const [],
    this.onChanged,
    required this.allowMultiSelect,
  });

  @override
  State<_MultiSelectSelectionView> createState() =>
      _MultiSelectSelectionViewState();
}

class _MultiSelectSelectionViewState extends State<_MultiSelectSelectionView> {
  List selectedItem = [];
  List<FormOptions> items = [];
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    items = [...widget.items];
    selectedItem = [...widget.selectedItems];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;
    final appDecorationTheme =
        Theme.of(context).extension<AppDecorationTheme>()!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Select ${widget.label}",
          actions: [
            if (widget.allowMultiSelect)
              InkWell(
                onTap: () {
                  setState(() {
                    selectedItem = widget.items.map((e) => e.value).toList();
                  });
                },
                child: Text(
                  "Select All",
                  style: appTextTheme.bodySmallMedium.copyWith(
                    color: appColorTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.pagePadding,
              ),
              margin: EdgeInsets.only(bottom: 10.hp),
              child: SearchtextField(
                hintText: "Enter Search Text",
                isFilled: true,
                controller: _searchTextController,
                onSearchPressed: () {
                  setState(() {
                    items = widget.items
                        .where((e) => e.label
                            .toLowerCase()
                            .contains(_searchTextController.text.toLowerCase()))
                        .toList();
                  });
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  bool isSelected = selectedItem.contains(items[index].value);
                  return InkWell(
                    onTap: () {
                      if (widget.allowMultiSelect) {
                        if (selectedItem.contains(items[index].value)) {
                          selectedItem.remove(items[index].value);
                        } else {
                          selectedItem.add(items[index].value);
                        }
                      } else {
                        if (selectedItem.isEmpty) {
                          selectedItem.add(items[index].value);
                        } else if (selectedItem[0] == items[index].value) {
                          selectedItem.clear();
                        } else {
                          selectedItem[0] = items[index].value;
                        }
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: CustomTheme.cardPadding,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: appColorTheme.borderLayout,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              items[index].label,
                              style: selectedItem.contains(items[index].value)
                                  ? appTextTheme.bodyNormalRegular
                                  : appTextTheme.bodyNormalMedium,
                            ),
                          ),
                          Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? appColorTheme.primary
                                    : appColorTheme.gray,
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? appColorTheme.primary
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: items.length,
              ),
            ),
            switch (context.bottomInsetsPadding) {
              0.0 => Container(
                  padding: EdgeInsets.only(
                    left: CustomTheme.cardPadding,
                    right: CustomTheme.cardPadding,
                    top: 20,
                    bottom: context.bottomViewPadding > 0
                        ? context.bottomViewPadding + 8
                        : 20,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      appDecorationTheme.e2,
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: widget.allowMultiSelect,
                        child: Text(
                          "${selectedItem.length} Selected",
                          style: appTextTheme.bodyLargeRegular,
                        ),
                      ),
                      CustomRoundedButtom(
                        title: "Confirm Select",
                        onPressed: () {
                          if (widget.onChanged != null) {
                            widget.onChanged!(selectedItem);
                          }
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              _ => Container(
                  height: context.bottomInsetsPadding,
                ),
            },
          ],
        ),
      ),
    );
  }
}
