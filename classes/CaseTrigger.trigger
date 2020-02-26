/******************************
   @Author: Sumit Choubey
   @Date:
   @Description: 
   @version update: 1.0 February-3-2020 @sumit choubey 
   ****************************/

Trigger CaseTrigger on Case (Before Insert, after Insert , after update, before update) {
 
    If(Trigger.isBefore && Trigger.isUpdate) {
       //*** Call to Apex Case Trigger Handler ***// 
       CaseTriggerHandler.getEmailInteractionCount(Trigger.newMap);
    }
}