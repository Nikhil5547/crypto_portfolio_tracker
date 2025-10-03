import 'package:crypto_portfolio_tracker/core/export_file.dart';

class AddAssetScreen extends GetView<AssAssetController> {
  AddAssetScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AssAssetController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: TextViewWidget(title: StringConstants.addAsset, fontWeight: FontWeight.w800, textColor: Colors.white),
          ),
          body: Form(
            key: _formKey,
            child: (controller.isLoading)
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10),
                            Autocomplete<CoinResponseModel>(
                              optionsBuilder: (TextEditingValue textValue) {
                                String value = textValue.text.trim().toLowerCase();
                                if (textValue.text.isEmpty) {
                                  return [];
                                }
                                return controller.conList
                                    .where(
                                      (coin) =>
                                          (coin.name ?? '').toLowerCase().startsWith(value) || (coin.symbol ?? '').toLowerCase().startsWith(value),
                                    )
                                    .take(15)
                                    .toList();
                              },
                              displayStringForOption: (CoinResponseModel option) => option.name ?? '',
                              fieldViewBuilder:
                                  (
                                    BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted,
                                  ) {
                                    return TextFormField(
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(
                                        hintText: StringConstants.search,
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      validator: (value) {
                                        if (value?.isEmpty ?? false) {
                                          return StringConstants.errorMsg;
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (String value) {
                                        onFieldSubmitted();
                                      },
                                    );
                                  },
                              optionsViewBuilder:
                                  (BuildContext context, AutocompleteOnSelected<CoinResponseModel> onSelected, Iterable<CoinResponseModel> options) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        elevation: 4.0,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width - 32,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: options.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              final CoinResponseModel option = options.elementAt(index);
                                              return ListTile(
                                                subtitle: TextViewWidget(title: option.name ?? '', fontSize: 14),
                                                title: TextViewWidget(title: option.symbol?.toUpperCase(), fontSize: 16),
                                                onTap: () {
                                                  onSelected(option);
                                                  controller.onSelect(option);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                            ),
                            SizedBox(height: 10),
                            TextFormFieldWidget(
                              hintText: StringConstants.enterQty,
                              textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                              onChanged: controller.setQty,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return StringConstants.errorMsg;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                if ((_formKey.currentState?.validate() ?? false)) {
                                  controller.addPortfolio();
                                }
                              },
                              child: TextViewWidget(title: StringConstants.save, fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
