import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/features/members/data/models/member_model.dart';

abstract interface class MemberLocalDataSource {
  Future<MemberModel> getMemberById(String id);
  Future<void> updateMember(MemberModel member);
}

/// Seeds an in-memory store from the bundled `assets/data/members.json`
/// asset, then reads and writes that store — assets can't be written back
/// to at runtime, so `_store` (not a cache) is what stands in for
/// persistence until a real `/api/members` implementation is swapped in.
class MemberLocalDataSourceImpl implements MemberLocalDataSource {
  MemberLocalDataSourceImpl({this.assetPath = 'assets/data/members.json'});

  final String assetPath;

  /// The in-memory "database" backing this mock. Null until [_ensureStore]
  /// seeds it from [assetPath]; from then on all reads and writes go
  /// through this list directly, so mutations (see [updateMember]) persist
  /// for the lifetime of this instance.
  List<MemberModel>? _store;

  Future<List<MemberModel>> _ensureStore() async {
    final store = _store;
    if (store != null) return store;

    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as List<dynamic>;
    final members = decoded
        .map((json) => MemberModel.fromJson(json as Map<String, dynamic>))
        .toList();
    _store = members;
    return members;
  }

  @override
  Future<MemberModel> getMemberById(String id) async {
    final members = await _ensureStore();
    for (final member in members) {
      if (member.id == id) return member;
    }
    throw NotFoundException("Member with ID '$id' was not found.");
  }

  @override
  Future<void> updateMember(MemberModel member) async {
    final members = await _ensureStore();
    final index = members.indexWhere((existing) => existing.id == member.id);
    if (index == -1) {
      throw NotFoundException("Member with ID '${member.id}' was not found.");
    }
    members[index] = member;
  }
}
