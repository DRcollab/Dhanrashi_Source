
import 'package:cloud_firestore/cloud_firestore.dart';
import 'global.dart';

Future fetchVariables( FirebaseFirestore fireStore) async{
  fireStore.collection('pjdhan_variables').get().then((QuerySnapshot snapshot){
    snapshot.docs.forEach((element) {
      Global.stockReturn = element.get('stock_return');
      Global.avgReturn = element.get('avg_roi');
      Global.bondYield = element.get('bond_yield');
      Global.fdReturn = element.get('fd_return');
      Global.goldReturn = element.get('gold_return');
      Global.mfReturn = element.get('mf_return');
      Global.realEstateReturn = element.get('re_return');

      Global.carInflation = element.get('car_inflation');
      Global.houseInflation = element.get('house_inflation');
      Global.educationInflation = element.get('education_inflation');
      Global.retailInflation = element.get('avg_inflation');
      Global.tourInflation = element.get('travel_inflation');
      Global.healthInflation = element.get('health_inflation');



    });
  }).catchError((onError){

    throw onError;
  });
}