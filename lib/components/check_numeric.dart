bool isNumeric(String str) {
  try{
    var value = double.parse(str);
    print("value "+value.toString()+"is numeric!");
  } on FormatException {
    return false;
  } 
  return true;
}