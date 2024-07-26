import 'package:flutter/material.dart';
import 'package:mghheartaccess/model/exception.dart';

class MGHHeartExceptionView extends StatelessWidget {
  final Exception? exception;
  final String? title;
  final String? body;
  final Function? onRetry;
  final Function? onCancel;
  final String? retryButtonText;
  final String? cancelButtonText;

  const MGHHeartExceptionView({
    super.key,
    this.exception,
    this.onRetry,
    this.onCancel,
    this.body,
    this.title,
    this.cancelButtonText,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    String localTitle;
    String? localBody;
    final ThemeData theme = Theme.of(context);
    const double localIconSize = 75;
    final Color localIconColor = Colors.grey[300]!;
    IconData? localIconData;
    Icon localIcon;

    var retryText = retryButtonText ?? 'RETRY';
    var cancelText = cancelButtonText ?? 'CANCEL';

    if (exception is MGHHeartException) {
      MGHHeartException ctex = exception as MGHHeartException;
      localTitle = title ?? ctex.title!;
      //_body = body ?? ctex.detail;
      localBody = body ?? ctex.message;
      localBody ??= ctex.detail ?? 'no information available';
      localIconData = ctex.iconData;
    } else {
      localTitle = title ?? exception.runtimeType.toString();
      localBody = body ?? exception.toString();
      localIconData = Icons.error_outline;
    }
    localIcon = Icon(
      localIconData,
      size: localIconSize,
      color: localIconColor,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12.0),
          Center(
            child: localIcon,
          ),
          InkWell(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            localTitle,
                            style: theme.textTheme.headlineSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  localBody,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          ButtonBar(
            children: <Widget>[
              onRetry != null
                  ? TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[300],
                        //disabledForegroundColor: Colors.grey[300],
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                      child: Text(
                        retryText,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      //textColor: Colors.blue,
                      onPressed: () {
                        onRetry!();
                      },
                    )
                  : Container(),
              onCancel != null
                  ? TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                      child: Text(cancelText,
                          style: const TextStyle(color: Colors.blue)),
                      onPressed: () {
                        onCancel!();
                      },
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
