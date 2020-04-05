import 'dart:convert';
import 'dart:io';
import 'package:uespi_reserva/modelos/usuario.dart';
import 'modelos/recurso.dart';
import 'package:http/http.dart' as http;

const urlMateriais = "https://uespi-reserva.herokuapp.com/api/materiais";
const urlUsuarios = "https://uespi-reserva.herokuapp.com/api/usuario";

Usuario user;

class Api {

   Future<List<Recurso>> getMateriais() async {
      var request = await http.get(urlMateriais);
      if(request.statusCode == 200){
        var jsonMateriais = json.decode(request.body);
        List<Recurso> materiais = List();
        for (var j in jsonMateriais){
          materiais.add(Recurso(id: j["id"].toString(), nome: j["nome"], tipo: j["tipo"]));
        }
        print(materiais.length);
        return materiais;
        
      }
        return null;

    }

    void cadastrarUsuario(String _nome, String _login, String _senha, String _curso) async{
     http.Response response = await http.post(
         urlUsuarios,
       body:
       {

         "nome":"$_nome",
         "login":"$_login",
         "senha":"$_senha",
         "curso":"$_curso"
       }
     );

     print(response.statusCode);
     print(response.body);
    }


   Future getUser() async {
     var request = await http.get(
       urlUsuarios + "/${Usuario.id}" ,
     headers: {
         HttpHeaders.authorizationHeader: 'Bearer ${Usuario.token}'
     });
     if(request.statusCode == 200){
       var jsonUsuario = json.decode(request.body);
       user = Usuario(
           nome: jsonUsuario["nome"],
           login: jsonUsuario["login"],
           senha: jsonUsuario["senha"],
           curso: jsonUsuario["curso"]
       );
     }

   }
}