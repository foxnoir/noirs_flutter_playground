import 'package:advanced_concepts/features/api_compare_lab/presentation/providers/api_compare_lab_provider.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';

class ApiCompareLabBeat {
  const ApiCompareLabBeat({
    required this.httpCall,
    required this.dioCall,
    required this.httpHint,
    required this.dioHint,
    this.fires = false,
  });

  final String httpCall;
  final String dioCall;
  final String httpHint;
  final String dioHint;
  final bool fires;
}

List<ApiCompareLabBeat> apiCompareLabBeats(
  AppLocalizations l10n,
  ApiCompareLabScenario scenario,
) {
  return switch (scenario) {
    ApiCompareLabScenario.get || ApiCompareLabScenario.unstable => _stack(
      l10n: l10n,
      path: '/books',
      afterFire: ApiCompareLabBeat(
        httpCall: 'status 200 → parse',
        dioCall: 'DioLogInterceptor.onResponse',
        httpHint: l10n.apiCompareHintHttpMap,
        dioHint: l10n.apiCompareHintDioOnResponse,
      ),
    ),
    ApiCompareLabScenario.timeout => _stack(
      l10n: l10n,
      path: '/timeout',
      httpSendCall: 'ApiClient._send  ·  .timeout(400ms)',
      afterFire: ApiCompareLabBeat(
        httpCall: 'TimeoutException → RequestTimeoutException',
        dioCall: 'DioAppExceptionInterceptor.onError',
        httpHint: l10n.apiCompareHintHttpTimeout,
        dioHint: l10n.apiCompareHintDioOnError,
      ),
    ),
    ApiCompareLabScenario.offline => _stack(
      l10n: l10n,
      path: '/offline',
      afterFire: ApiCompareLabBeat(
        httpCall: 'catch → NetworkException',
        dioCall: 'DioAppExceptionInterceptor.onError',
        httpHint: l10n.apiCompareHintHttpOffline,
        dioHint: l10n.apiCompareHintDioOffline,
      ),
    ),
    ApiCompareLabScenario.serverError => _stack(
      l10n: l10n,
      path: '/error',
      afterFire: ApiCompareLabBeat(
        httpCall: 'status >= 500 → ServerException',
        dioCall: 'DioAppExceptionInterceptor.onError',
        httpHint: l10n.apiCompareHintHttpServer,
        dioHint: l10n.apiCompareHintDioServer,
      ),
    ),
  };
}

List<ApiCompareLabBeat> _stack({
  required AppLocalizations l10n,
  required String path,
  required ApiCompareLabBeat afterFire,
  String httpSendCall = 'ApiClient._send',
}) {
  return [
    ApiCompareLabBeat(
      httpCall: "ApiClient.get('$path')",
      dioCall: "DioApiClient.get('$path')",
      httpHint: l10n.apiCompareHintEnter,
      dioHint: l10n.apiCompareHintEnter,
    ),
    ApiCompareLabBeat(
      httpCall: httpSendCall,
      dioCall: 'DioApiClient._send',
      httpHint: l10n.apiCompareHintHttpSend,
      dioHint: l10n.apiCompareHintDioSend,
    ),
    ApiCompareLabBeat(
      httpCall: '(no interceptor)',
      dioCall: 'DioLogInterceptor.onRequest',
      httpHint: l10n.apiCompareHintHttpNoInterceptor,
      dioHint: l10n.apiCompareHintDioOnRequest,
    ),
    ApiCompareLabBeat(
      httpCall: 'http.Client.get',
      dioCall: '_dio.request',
      httpHint: l10n.apiCompareHintFire,
      dioHint: l10n.apiCompareHintFire,
      fires: true,
    ),
    afterFire,
  ];
}
