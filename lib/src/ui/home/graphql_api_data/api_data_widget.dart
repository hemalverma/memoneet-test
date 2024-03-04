import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/text_style.dart';
import 'api_data_widget_model.dart';

class ApiDataWidget extends ConsumerStatefulWidget {
  const ApiDataWidget({super.key});

  @override
  ConsumerState<ApiDataWidget> createState() => _ApiDataWidgetState();
}

class _ApiDataWidgetState extends ConsumerState<ApiDataWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(apiDataWidgetModelProvider.notifier).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ref.watch(apiDataWidgetModelProvider.select((value) => value.episodes));
    final status =
        ref.watch(apiDataWidgetModelProvider.select((value) => value.status));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GraphQl Api Data',
                style: AppTextStyles.headline6,
              ),
            ],
          ),
          Expanded(
            child: status == ApiDataStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : status == ApiDataStatus.error
                    ? Text(ref.read(apiDataWidgetModelProvider.select(
                        (value) => value.errorMessage ?? 'Error Occurred')))
                    : data == null
                        ? const Center(
                            child: Text('No Data'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text(data[index].episode),
                                title: Text(data[index].name),
                                subtitle: Text(data[index].airDate),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
