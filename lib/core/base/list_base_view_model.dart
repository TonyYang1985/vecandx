import 'package:flutter/material.dart';

import './base_view_model.dart';

abstract class ListBaseViewModel<T> extends BaseViewModel {
  final searchController = TextEditingController();

  String _searchText = '';
  bool _refersh = false;
  int _offset = 0;
  int _pageSize = 10;
  int _page = 1;

  int _count = 0;
  List<T> _items = [];
  List<T> _previousItems = [];

  void getList({Function callback});
  void delete(T item, int index);
  void toggleActivation(T item, int index);
  void showDeleteConfirmation(T item, int index);
  void showActivationConfirmation(T item, int index);
  void navigateToAddPage();
  void navigateToEditPage(T item);

  void initialise() {
    getList();
  }

  void refreshDataTable({int pageSize = 10}) {
    refresh = true;
    _offset = 0;
    _pageSize = pageSize;
    previousItems = [];
    items = [];
    count = 0;
    Future.delayed(Duration(milliseconds: 300), () {
      refresh = false;
      getList();
    });
  }

  List<T> get items => _items;
  set items(List<T> value) {
    _items = value;
  }

  List<T> get previousItems => _previousItems;
  set previousItems(List<T> value) {
    _previousItems = value;
  }

  String get searchText => _searchText;
  set searchText(String value) {
    final previousValue = _searchText;
    _searchText = value;
    if (value.isEmpty) {
      notifyListeners();
    } else if (value.isNotEmpty && previousValue.isEmpty) {
      notifyListeners();
    }
  }

  bool get refresh => _refersh;
  set refresh(bool value) {
    _refersh = value;
    notifyListeners();
  }

  int get count => _count;
  set count(int value) {
    _count = value;
  }

  int get pageSize => _pageSize;
  set pageSize(int value) {
    _pageSize = value;
    notifyListeners();
    refreshDataTable(pageSize: value);
  }

  int get page => _page;
  set page(int pageNumber) {
    final currentPage = page;
    _page = pageNumber;

    previousItems = items;

    if (pageNumber < currentPage) {
      final start = (pageNumber - 1) * pageSize;
      previousItems.removeRange(start, previousItems.length);
    }

    getList(callback: () {
      items.insertAll(0, previousItems);
    });
  }

  int get offset => _offset;
  set offset(int value) {
    _offset = value;
    page = (value ~/ pageSize) + 1;
    notifyListeners();
  }
}
