/*
 * Copyright � 1996 - 2017 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
*/
    function setQuiescePort(form, key)
    {
        var a = key.value.split(',');
        form.port.value=a[0];
        form.package.value=a[1];
        form.portAlias.value=a[2];
    }

    function toggleSystemTasksChecked(){
       if(document.setQuiescePortForm.systemTasksDisabled.checked){
            document.setQuiescePortForm.systemTasksDisabled.value = true;
       }else{
            document.setQuiescePortForm.systemTasksDisabled.value = false;
       }
    }

    function toggleAuditingDisabledChecked(){
        if(document.setQuiescePortForm.auditingDisabled.checked){
                document.setQuiescePortForm.auditingDisabled.value = true;
        }else{
                document.setQuiescePortForm.auditingDisabled.value = false;
        }
    }

    function toggleAlertingDisabledChecked(){
            if(document.setQuiescePortForm.alertingDisabled.checked){
                    document.setQuiescePortForm.alertingDisabled.value = true;
            }else{
                    document.setQuiescePortForm.alertingDisabled.value = false;
            }
    }

    function toggleStatisticsDataCollectorDisabledChecked(){
         if(document.setQuiescePortForm.statisticsDataCollectorDisabled.checked){
               document.setQuiescePortForm.statisticsDataCollectorDisabled.value = true;
         }else{
               document.setQuiescePortForm.statisticsDataCollectorDisabled.value = false;
         }
}