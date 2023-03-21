class Users {
  Users({
     this.userId,
     this.empId,
     this.name,
     this.password,
     this.avatarId,
     this.emailid,
     this.phoneno,
     this.role,
     this.createdBy,
     this.updatedBy,
     this.createdDate,
     this.updatedDate,
     this.flg,

  });

  int? userId;
  String? empId;
  String? name;
  String? password;
  String? avatarId;
  String? emailid;
  String? phoneno;
  String? role;
  int? createdBy;
  int? updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int? flg;

}


