class DataResponse<T> {
  bool success;
  var data;
  var user;
  String message;
  int currentPage;
  int lastPage;
  String token;

  DataResponse.loading(this.message) : success = true;

  DataResponse.success(this.data) : success = true;

  DataResponse.forceUpdate(this.data) : success = true;

  DataResponse.successLogin(this.token, this.user) : success = true;

  DataResponse.successMessage(this.message) : success = true;

  DataResponse.error(this.message) : success = false;

  DataResponse.connectivityError() : success = false;

  @override
  String toString() {
    return "success : $success \n Message : $message \n Data : $data \n User: $user";
  }
}
