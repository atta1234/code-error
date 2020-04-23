import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:foodfromforeign1/models/Country.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';


class Province{
  String name;
  int id;
  Province(this.name,this.id);
  toString(){
    return(name);
  }
}





class City{
  String name;
  int id;
  City(this.name,this.id);
  toString(){
    return(name);
  }
}


class CountryApi extends StatefulWidget {
  CountryApi({Key key}) : super(key: key);
  @override
  _CountryApiState createState() => _CountryApiState();
}

class _CountryApiState extends State<CountryApi> {
  //get countries
  final String url = "http://10.0.2.2/fff/api/allcountries/";
 List<Country> countries;
List<DropdownMenuItem<Country>> countriesDropdownItems=[];
Country selectedCountry;
  Future<String> getSWData() async {
    var res = await http .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = (res.body);
    setState(() {
     final String countriesJson = resBody;
 countries=(jsonDecode(countriesJson) as List<dynamic>).map<Country>((e) => Country(e['name'],e['id'])).toList();
    countriesDropdownItems = countries.map<DropdownMenuItem<Country>>((e) => DropdownMenuItem(child:Text(e.name),value:e,)).toList();
    });
    return 'sucess';
  }

//get province
final String urlstates = "http://10.0.2.2/fff/api/state/";
 List<Province> provinces;
List<DropdownMenuItem<Province>> provincesDropdownItems=[];
Province selectedProvince;
  Future<String> getprovincesData(id) async {
    var res = await http .get(Uri.encodeFull(urlstates+id.toString()), headers: {"Accept": "application/json"});
    var resBody = (res.body);
    setState(() {
     final String provincessJson = resBody;
 provinces=(jsonDecode(provincessJson) as List<dynamic>).map<Province>((f) => Province(f['name'],f['id'])).toList();
    provincesDropdownItems = provinces.map<DropdownMenuItem<Province>>((f) => DropdownMenuItem(child:Text(f.name),value:f,)).toList();
    });
    return 'sucess';
 }
 

//get province
final String urlcity = "http://10.0.2.2/fff/api/city/";
 List<City> ceties;
List<DropdownMenuItem<City>> cetiesDropdownItems=[];
City selectedCity;
  Future<String> getcitydata(int id) async {
    var res = await http .get(Uri.encodeFull(urlcity+id.toString()), headers: {"Accept": "application/json"});
    var resBody = (res.body);
   if(res.statusCode==200){ 
    setState(() {  
     final String cityJson = resBody;
 ceties=(jsonDecode(cityJson) as List<dynamic>).map<City>((f) => City(f['name'],f['id'])).toList();
    cetiesDropdownItems = ceties.map<DropdownMenuItem<City>>((f) => DropdownMenuItem(child:Text(f.name),value:f,)).toList();
    });
   }
   else{
     cetiesDropdownItems=[];
   }
    return 'sucess';
 }
 

 




 @override
     void initState() {
    this.getSWData();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child:Column(
      children: <Widget>[
           //Text('SEND DEAL TO YOUR FRIEND AND FAMILY RIGHT NOW',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color:Colors.redAccent),),

         SearchableDropdown.single(
        items: countriesDropdownItems,
        value: selectedCountry,
        hint: "Select one country",
        searchHint: "Select one country",
        onChanged: (value) {
          setState(() {
            selectedCountry = value;
            this.getprovincesData(value.id);
          });
        },
        isExpanded: true,
      ),
         

        SearchableDropdown.single(
        items: provincesDropdownItems,
        value: selectedProvince,
        hint: "Select one State",
        searchHint: "Select one State",
        onChanged: (value) {
          setState(() {
            selectedProvince = value;
           this.getcitydata(value.id);
          });
        },
        isExpanded: true,
      ),

        SearchableDropdown.single(
        items: cetiesDropdownItems,
        value: selectedCity,
        hint: "Select one City",
        searchHint: "Select one City",
        onChanged: (value) {
          setState(() {
            selectedCity = value;
          });
        },
        isExpanded: true,
      ),
      
//    InkWell(
//   onTap: () {
   
//   },
//   child:  Container(
//     //width: 100.0,
//     height: 50.0,
//     decoration:  BoxDecoration(
//       color: Colors.redAccent,
//       border:  Border.all(color: Colors.white, width: 2.0),
//       borderRadius:  BorderRadius.circular(10.0),
//     ),
//     child:  Center(child:  Text('Search  DEAL', style:  TextStyle(fontSize: 18.0, color: Colors.white),),),
//   ),
// ),


         ],

        )
        );
    
    
 


      
  }
}


