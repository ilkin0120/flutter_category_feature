import 'package:flutter/material.dart';

import '../../features/categories/domain/constants/icon_groups.dart';

class GetDefaultIconsUseCase {
  Map<String, List<IconData>> call() {
    return IconGroups.allIconGroups();
  }
}
