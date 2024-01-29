import 'package:dio/dio.dart';
import 'package:flutter_timer/src/data/api/dio/dio_client.dart';
import 'package:flutter_timer/src/data/api/odoo_api.dart';
import 'package:flutter_timer/src/data/odoo_repository.dart';
import 'package:flutter_timer/src/di/base_injection_module.dart';
import 'package:flutter_timer/src/presentation/components/timer_list_item/odoo_timer_list_item_bloc.dart';
import 'package:flutter_timer/src/presentation/pages/create_timer/create_timer_bloc.dart';
import 'package:flutter_timer/src/presentation/pages/task_details/taks_details_bloc.dart';
import 'package:flutter_timer/src/presentation/pages/timesheets/timesheets_bloc.dart';
import 'package:stark/stark.dart';

class AppModule extends BaseInjectModule {
  @override
  Set<Bind> dataBinds() => {
        single<Dio>(
          (i) => DioClient.getClient(baseUrl: "htts://testapi.com"),
        ),
        single((i) => OdooApi(i.get())),
        single((i) => OdooRepository(i.get())),
      };

  @override
  Set<Bind> domainBinds() => <Bind>{};

  @override
  Set<Bind> presentationBinds() => {
        single((i) => TimesheetsBloc(i.get())),
        single((i) => CreateTimerBloc(i.get())),
        singleWithParams((i, p) => TaskDetailsBloc(i.get(), p?["odooTimer"])),
        singleWithParams(
            (i, p) => OdooTimerListItemBloc(i.get(), p?["odooTimer"])),
      };
}
