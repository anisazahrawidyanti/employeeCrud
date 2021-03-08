import 'package:employee_crud/pages/employee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
  //KOMENTAR-3: DEFINE VARIABLE
  final TextEditingController _name = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final snackbarKey = GlobalKey<ScaffoldState>();

  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();
  bool _isLoading = false;

  void submit(BuildContext context) {
    //MEMANGGIL FUNGSI YANG SUDAH DIDEFINISIKAN DI PROVIDER
    //DENGAN MENGIRIMKAN VALUE DATA NAME, SALARY DAN AGE
    if (!_isLoading) {
    //SET VALUE LOADING JADI TRUE, DAN TEMPATKAN DI DALAM SETSTATE UNTUK MEMBERITAHUKAN PADA WIDGET BAHWA TERJADI PERUBAHAN STATE
    setState(() {
      _isLoading = true;
    });
    
    Provider.of<EmployeeProvider>(context, listen: false)
        .storeEmployee(_name.text, _salary.text, _age.text)
        .then((res) {
      //JIKA TRUE
      if (res) {
        //MAKA REDIRECT KE HALAMAN MENAMPILKAN DATA EMPLOYEE
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Employee()));
      } else {
        //TAMPILKAN ALERT
         var snackbar = SnackBar(content: Text('Ops, Error. Hubungi Admin'),);
          snackbarKey.currentState.showSnackBar(snackbar);
          setState(() {
            _isLoading = false;
          });
       }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text('Add Employee'),
        actions: <Widget>[
          FlatButton(
            //LAKUKAN PENGECEKAN, JIKA _ISLOADING TRUE MAKA TAMPILKAN LOADING
            //JIKA FALSE, MAKA TAMPILKAN ICON SAVE
            child: _isLoading
                ? CircularProgressIndicator(
                    //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
            onPressed: () => submit(context),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            //KOMENTAR-1
            TextField(
              controller: _name,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Nama Lengkap',
              ),
              //JIKA TOMBOL SUBMIT PADA KEYBOARD DITEKAN
              onSubmitted: (_) {
                //MAKA FOCUSNYA AKAN DIPINDAHKAN PADA FORM INPUT SELANJUTNYA
                FocusScope.of(context).requestFocus(salaryNode);
              },
            ),
            TextField(
              controller: _salary,
              focusNode: salaryNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Gaji',
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(ageNode);
              },
            ),
            TextField(
              controller: _age,
              focusNode: ageNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Umur',
              ),
            ),
          ],
        ),
      ),
    );
  }
}