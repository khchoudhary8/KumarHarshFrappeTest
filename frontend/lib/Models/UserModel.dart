class UserModel{
  String id;
  String name;
  String email;
  String phone;
  String mem_status;
  List<int> bookList;
  String dues;

  UserModel(this.id, this.name, this.email, this.phone, this.mem_status,
      this.bookList, this.dues);
}