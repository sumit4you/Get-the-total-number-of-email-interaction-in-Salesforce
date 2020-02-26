/******************************
   @Author: Sumit Choubey
   @Date: 
   @Test class:
   @Description: 
   @version update: 1.0 February-3-2020 @sumit choubey 
   ****************************/

public with sharing class CaseTriggerHandler {
  
    /***
     @Input:- this method take input from Trigger(new value)
     @Return:- this method returns null
     @Description:- 
     ***/
    public static Case getEmailInteractionCount (Map<Id, Case> newmapvalue) {
            
      for(case thisCase : newmapvalue.values()) {
        for(AggregateResult thisAggResult : getAggregate(thisCase.Id)) {
          If(thisAggResult.get('incoming') == true) {
            thisCase.Incoming_Email_Count__c = (Decimal)thisAggResult.get('sum');
          } else if(thisAggResult.get('incoming') == false) {
            thisCase.Outgoing_Email_Count__c = (Decimal)thisAggResult.get('sum');
          }
        }
      } 
    return null;
    }
     
    /*** @get aggregate Email Message record ***/
    public static List<AggregateResult> getAggregate(Id csId){
      return [SELECT COUNT(Id) sum, 
                      Incoming incoming, 
                      ParentId id 
              FROM EmailMessage 
              WHERE ParentId =: csId 
              GROUP BY Incoming, ParentId];
    }
 }