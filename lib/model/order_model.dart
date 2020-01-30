class Order {
  static List selectedIroningList=[];
  static List selectedWashingList=[];
  static List selectedDryCleaningList=[];
  static double ironingCost=0,washingCost=0,dryCleaningCost=0;
  static double subTotal=0,deliveryCost=0,totalCost=0;
  static int ironingNumber=0,washingNumber=0,dryCleaningNumber=0,totalNumber=0;
  static String paymentType='COD';
}

// orderItem ={
//   "type":"washing/drycleaning/ironing",
//   "item":"",
//   "qty":"",
//   "costPerItem":""
// }
