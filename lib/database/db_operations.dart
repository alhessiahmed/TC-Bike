mixin DbOperations<Model> {
  Future<int> create(Model model);

  Future<List<Model>> read();

  // Future<Model?> show(int id) async {}

  Future<bool> update(Model model);

  Future<bool> delete(int id);
}
