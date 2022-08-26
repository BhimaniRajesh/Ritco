<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MyExpenseVoucherFV.ascx.cs" Inherits="UserControls_MyExpenseVoucherFV" %>
<script language="javascript">

 var mVehiclePopoupPath= "<%=Session["VehiclePopoupPath"]%>";       
        
function openPopupSKU1(txtVehNo) 
{
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1").rows.length; intIndex++)
   {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;
      
            if (document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1_ctl" + str_Index + "_txtVehNo").value;
                
               }
      
        
    }
    window.open("" + mVehiclePopoupPath  +  "UserControls/wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
}
        
        
        
        
function openPopupSKU2(txtVehNo) 
{
   //alert("2");
   //alert(url);
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2").rows.length; intIndex++)
   {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;

      
            if (document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2_ctl" + str_Index + "_txtVehNo").value;}
      
        
    }
    
    window.open("" + mVehiclePopoupPath  +  "UserControls/wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
    //window.open("?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");

    //window.open(" + url + "?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
    
}
        
        
        
        
        
function openPopupSKU3(txtVehNo) 
{
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3").rows.length; intIndex++)
   {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;

      
            if (document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl" + str_Index + "_txtVehNo").value;}
      
        
    }
    
    
    

    window.open("" + mVehiclePopoupPath  +  "UserControls/wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
}
        
        
        
        
        
function openPopupSKU4(txtVehNo) 
{
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4").rows.length; intIndex++)
   {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;

      
            if (document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl" + str_Index + "_txtVehNo").value;}
      
        
    }
    
    
    

    window.open("" + mVehiclePopoupPath  +  "UserControls/wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
}
        



function openPopupSKU(txtVehNo) 
{
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense").rows.length; intIndex++)
 {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;

      
            if (document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl" + str_Index + "_txtVehNo").value;}
      
        
   }

    window.open("" + mVehiclePopoupPath  +  "UserControls/wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
}




 
        function CheckValid()
        {
            
            
            var grid1;
            var grid2;
            var grid3;
            var grid4;
            var grid5;
            var r1;
            var r2;
            var r3;
            var r4;
            var r5;
            
            var mStat='<%=Request.QueryString["Stat"]%>'
            var mCrewSal = '<%=Request.QueryString["CrewSal"]%>'; 
            var mVehTrack = '<%=Request.QueryString["VehTrack"]%>';
            var mFinExp = '<%=Request.QueryString["FinExp"]%>';
            var mRepair = '<%=Request.QueryString["Repair"]%>';
            
            if(mStat=="S")
            {
                grid1=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1");
                 r1=grid1.rows.length;
            }
            
            if(mCrewSal=="C")
            {
                grid2=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2");
                 r2=grid2.rows.length;
            }
            
            if(mVehTrack=="V")
            {
                grid3=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3");
                 r3=grid3.rows.length;
             }
            if(mFinExp=="F")
            { 
                grid4=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4");
                r4=grid4.rows.length;
            }
           
            if(mRepair=="R")
            { 
                grid5=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense");
                r5=grid5.rows.length;
            }
           
            var Amt=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_txtTotalAmt").value;
            var ExeAmt=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_txtTotalExeAmt").value;
       
     
            var Nat1="";
            var Nat11="";
            var Nat2="";
            var Nat22="";
            var Nat3="";
            var Nat33="";
            var Nat4="";
            var Nat44="";
            
            var Nat5="";
            var Nat55="";
            
            var Veh_e="";
            
            
      
      
      
      
      
   if(r1>0)
      {
          //alert("a2");
         for(i=0;i< r1-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1_ctl" + j + "_";
           
                }    
          
              Nat1=document.getElementById(pref + "ddlNature").value;
              
              var    Veh1=document.getElementById(pref + "txtVehNo").value ;
                         
             if(Veh1=="")
             {
             
             alert("Enter Vehicle No!");
               document.getElementById(pref + "txtVehNo").focus();
             return false;
            
             }
        
        
        
        
        
        
        
        
         
        //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
         Nat1=Nat1+Veh1;
       
         for(k=0;k<r1-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(m<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1_ctl" + m + "_";
              }    
             
             //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
             Veh_e=document.getElementById(pref + "txtVehNo").value ;  
             Nat11=document.getElementById(pref + "ddlNature").value + Veh_e ;

           if(Nat1==Nat11)
           {
           alert("Please Select different Expense in each row!");
           document.getElementById(pref + "ddlNature").focus();
           return false;
           }
         }
       }
     }
   }
  
  
      if(r2>0)
      {
          //alert("a2");
         for(i=0;i< r2-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2_ctl" + j + "_";
           
                }    
          
              Nat2=document.getElementById(pref + "ddlNature").value;
              
              var    Veh2=document.getElementById(pref + "txtVehNo").value ;
                         
             if(Veh2=="")
             {
             
             alert("Enter Vehicle No!");
               document.getElementById(pref + "txtVehNo").focus();
             return false;
            
             }
        
        
        
        
        
        
        
        
         
        //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
         Nat2=Nat2+Veh2;
       
         for(k=0;k<r2-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(m<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2_ctl" + m + "_";
              }    
             
             //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
             Veh_e=document.getElementById(pref + "txtVehNo").value ;  
             Nat22=document.getElementById(pref + "ddlNature").value + Veh_e ;

           if(Nat2==Nat22)
           {
           alert("Please Select different Expense in each row!");
           document.getElementById(pref + "ddlNature").focus();
           return false;
           }
         }
       }
     }
   }
  
  
   /*if(r3>0)
      {
          // alert("a3");
         for(i=0;i< r3-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl" + j + "_";
           
                }    
          
              Nat3=document.getElementById(pref + "ddlNature").value;
              
              
               var    Veh3=document.getElementById(pref + "txtVehNo").value ;
             
             
             if(Veh3=="")
             {
             
             alert("Enter Vehicle No!");
                document.getElementById(pref + "txtVehNo").focus();
             return false;
         
             }
              
              
              
              
        
           
        //----- change done on 28-Aug-08 for duplication of expense head with vehicle no         
         Nat3=Nat3+Veh3;
         
         for(k=0;k<r3-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(k<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl" + m + "_";
              }    
          
             //Nat33=document.getElementById(pref + "ddlNature").value ;
      
             //----- change done on 28-Aug-08 for duplication of expense head with vehicle no         
             Veh_e=document.getElementById(pref + "txtVehNo").value ;  
             Nat33=document.getElementById(pref + "ddlNature").value + Veh_e ;
      
                    
           if(Nat3==Nat33)
           {
           alert("Please Select different Expense in each row!");
           return false;
           }
         }
       }
     }
   }
  */
  
  
  
    if(r3>0)
      {
          //alert("a2");
         for(i=0;i< r3-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl" + j + "_";
           
                }    
          
              Nat3=document.getElementById(pref + "ddlNature").value;
              
              var    Veh3=document.getElementById(pref + "txtVehNo").value ;
                         
             if(Veh3=="")
             {
             
             alert("Enter Vehicle No!");
               document.getElementById(pref + "txtVehNo").focus();
             return false;
            
             }
        
        
        
        
        
        
        
        
         
        //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
         Nat3=Nat3+Veh3;
       
         for(k=0;k<r3-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(m<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl" + m + "_";
              }    
             
             //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
             Veh_e=document.getElementById(pref + "txtVehNo").value ;  
             Nat33=document.getElementById(pref + "ddlNature").value + Veh_e ;

           if(Nat3==Nat33)
           {
           alert("Please Select different Expense in each row!");
           document.getElementById(pref + "ddlNature").focus();
           return false;
           }
         }
       }
     }
   }
  
  
  
   /*if(r4>0)
      {
          //alert("a4");
         for(i=0;i< r4-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl" + j + "_";
           
                }    
          
              Nat4=document.getElementById(pref + "ddlNature").value;
              
              
         var    Veh44=document.getElementById(pref + "txtVehNo").value ;
             
             
             if(Veh44=="")
             {
             
             alert("Enter Vehicle No!");
                document.getElementById(pref + "txtVehNo").focus();
             return false;
          
             }
             
             
              
              
        
         //----- change done on 28-Aug-08 for duplication of expense head with vehicle no         
         Nat4=Nat4+Veh44;
      
       
         for(k=0;k<r4-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(k<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl" + m + "_";
              }    
          
             //Nat44=document.getElementById(pref + "ddlNature").value ;
             
             
            //----- change done on 28-Aug-08 for duplication of expense head with vehicle no         
             Veh_e=document.getElementById(pref + "txtVehNo").value ;  
             Nat44=document.getElementById(pref + "ddlNature").value + Veh_e ;
      
                            
           if(Nat4==Nat44)
           {
           alert("Please Select different Expense in each row!");
           return false;
           }
         }
       }
     }
     
   }
  */
  
  
  
  
    if(r4>0)
      {
          //alert("a2");
         for(i=0;i< r4-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl" + j + "_";
           
                }    
          
              Nat4=document.getElementById(pref + "ddlNature").value;
              
              var    Veh4=document.getElementById(pref + "txtVehNo").value ;
                         
             if(Veh4=="")
             {
             
             alert("Enter Vehicle No!");
               document.getElementById(pref + "txtVehNo").focus();
             return false;
            
             }
        
        
        
        
        
        
        
        
         
        //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
         Nat4=Nat4+Veh4;
       
         for(k=0;k<r4-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(m<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl" + m + "_";
              }    
             
             //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
             Veh_e=document.getElementById(pref + "txtVehNo").value ;  
             Nat44=document.getElementById(pref + "ddlNature").value + Veh_e ;

           if(Nat4==Nat44)
           {
           alert("Please Select different Expense in each row!");
           document.getElementById(pref + "ddlNature").focus();
           return false;
           }
         }
       }
     }
   }
  
  
  
  
  
 /* if(r5>0)
     {
          //alert("a5");
         for(i=0;i< r5-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl" + j + "_";
           
                }    
          
              Nat5=document.getElementById(pref + "ddlNature").value;
              
              
         var    Veh55=document.getElementById(pref + "txtVehNo").value ;
             
             
             if(Veh55=="")
             {
             
             alert("Enter Vehicle No!");
                document.getElementById(pref + "txtVehNo").focus();
             return false;
          
             }
             
             
       //----- change done on 28-Aug-08 for duplication of expense head with vehicle no         
         Nat5=Nat5+Veh55;
         
         
         for(k=0;k<r5-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(k<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl" + m + "_";
              }    
          
             //Nat55=document.getElementById(pref + "ddlNature").value ;
               //----- change done on 28-Aug-08 for duplication of expense head with vehicle no         
             Veh_e=document.getElementById(pref + "txtVehNo").value ;  
             Nat55=document.getElementById(pref + "ddlNature").value + Veh_e ;
      
             
      
                            
           if(Nat5==Nat55)
           {
           alert("Please Select different Expense in each row!");
           document.getElementById(pref + "ddlNature").focus();
           return false;
           }
         }
       }
     }
  }
  */
  
  
    if(r5>0)
      {
          //alert("a2");
         for(i=0;i< r5-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl" + j + "_";
           
                }    
          
              Nat5=document.getElementById(pref + "ddlNature").value;
              
              var    Veh5=document.getElementById(pref + "txtVehNo").value ;
                         
             if(Veh5=="")
             {
             
             alert("Enter Vehicle No!");
               document.getElementById(pref + "txtVehNo").focus();
             return false;
            
             }
        
        
        
        
        
        
        
        
         
        //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
         Nat5=Nat5+Veh5;
       
         for(k=0;k<r5-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(m<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl" + m + "_";
              }    
             
             //----- change done on 27-Aug-08 for duplication of expense head with vehicle no         
             Veh_e=document.getElementById(pref + "txtVehNo").value ;  
             Nat55=document.getElementById(pref + "ddlNature").value + Veh_e ;

           if(Nat5==Nat55)
           {
           alert("Please Select different Expense in each row!");
           document.getElementById(pref + "ddlNature").focus();
           return false;
           }
         }
       }
     }
   }
  
   
                  if(Amt=="")
               {
             
                
                   alert("Total Amount  Should be Greater than 0!")
                  return false;
                                  
                 
               }
                  
                   if(Amt!="")
               {
                  if( parseFloat(Amt)<=0)
                 {
                
                   alert("Total Amount  Should be Greater than 0!")
                  return false;
                                  
                  }
               }
                  
                  
                    if(ExeAmt=="")
                  {
                                  
                     alert("Approved Total Amount  Should be Greater than 0!")
                     return false;
                
                   
                   }
                                    
                  
                    if(ExeAmt!="")
                  {
                    if( parseFloat(ExeAmt)<=0)
                     {
                 
                        alert("Approved Total Amount  Should be Greater than 0!")
                        return false;
                
                     }
                 }
            
  
  

   
  
        
  
  }

  function calculateBalance()
    {
            var mStat='<%=Request.QueryString["Stat"]%>'
            var mCrewSal = '<%=Request.QueryString["CrewSal"]%>'; 
            var mVehTrack = '<%=Request.QueryString["VehTrack"]%>';
            var mFinExp = '<%=Request.QueryString["FinExp"]%>';
            var mRepair = '<%=Request.QueryString["Repair"]%>';
            //alert(mStat);
            var grid1;
            var r1;
            
            var grid2;
            var r2;
            
            var grid3;
            var r3;
            
            var grid4;
            var r4;
            
            var grid5;
            var r5;

            
            
            if(mStat=="S")
            {
                grid1=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1");
                r1=grid1.rows.length;
            }
            if(mCrewSal=="C")
            {
             grid2=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2");
             r2=grid2.rows.length;
           }
           if(mVehTrack=="V")
           {
             grid3=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3");
             r3=grid3.rows.length;
            }
            if(mFinExp=="F")
            {
                grid4=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4");
                r4=grid4.rows.length;
            }
            
            if(mRepair=="R")
            {
                grid5=document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense");
                r5=grid5.rows.length;
            }
            
      
       var totadv="0.00",totamt="0.00";
      
      // var mtotadv="0.00",mtotamt="0.00";
      var totadv1="0.00",totamt1="0.00";
        var totadv2="0.00",totamt2="0.00";
          var totadv3="0.00",totamt3="0.00";
            var totadv4="0.00",totamt4="0.00";
            var totadv5="0.00",totamt5="0.00";

       
        for(i=0;i< r1-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense1_ctl" + j + "_";
           
                }    
          
            var amt1=document.getElementById(pref + "txtAmt");
            var EAmt1=document.getElementById(pref + "txtExeAmt");
       
    
         if(amt1.value!="")
         {
           totadv1=parseFloat(totadv1) + parseFloat(amt1.value);
         }
       
        if(EAmt1.value!="")
         {
           totamt1=parseFloat(totamt1) + parseFloat(EAmt1.value);
         }
         
            
    }
 
  
    
      
         for(i=0;i< r2-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense2_ctl" + j + "_";
           
                }    
          
            var amt2=document.getElementById(pref + "txtAmt");
            var EAmt2=document.getElementById(pref + "txtExeAmt");
    
    
         if(amt2.value!="")
         {
           totadv2=parseFloat(totadv2) + parseFloat(amt2.value);
         }
       
        if(EAmt2.value!="")
         {
           totamt2=parseFloat(totamt2) + parseFloat(EAmt2.value);
         }
         
        
       
            
    }
  
    
     for(i=0;i< r3-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense3_ctl" + j + "_";
           
                }    
          
            var amt3=document.getElementById(pref + "txtAmt");
            var EAmt3=document.getElementById(pref + "txtExeAmt");
    
    
         if(amt3.value!="")
         {
           totadv3=parseFloat(totadv3) + parseFloat(amt3.value);
         }
       
        if(EAmt3.value!="")
         {
           totamt3=parseFloat(totamt3) + parseFloat(EAmt3.value);
         }
         
        
       
            
    }
     
  
     for(i=0;i< r4-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense4_ctl" + j + "_";
           
                }    
          
            var amt4=document.getElementById(pref + "txtAmt");
            var EAmt4=document.getElementById(pref + "txtExeAmt");
    
    
         if(amt4.value!="")
         {
           totadv4=parseFloat(totadv4) + parseFloat(amt4.value);
         }
       
        if(EAmt4.value!="")
         {
           totamt4=parseFloat(totamt4) + parseFloat(EAmt4.value);
         }
         
        
       
            
    }
    
        
      
      
      for(i=0;i< r5-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_UCMyExpenseVoucher1_dgExpense_ctl" + j + "_";
           
                }    
          
            var amt5=document.getElementById(pref + "txtAmt");
            var EAmt5=document.getElementById(pref + "txtExeAmt");
    
    
         if(amt5.value!="")
         {
           totadv5=parseFloat(totadv5) + parseFloat(amt5.value);
         }
       
        if(EAmt5.value!="")
         {
           totamt5=parseFloat(totamt5) + parseFloat(EAmt5.value);
         }
         
        
       
            
    }     
           
        totadv=parseFloat(totadv1)+parseFloat(totadv2)+parseFloat(totadv3)+parseFloat(totadv4)+parseFloat(totadv5);
       
            
     
        
        totamt=parseFloat(totamt1)+parseFloat(totamt2)+parseFloat(totamt3)+parseFloat(totamt4)+parseFloat(totamt5);
          
           document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_txtTotalAmt").value= totadv;       
           
           document.getElementById("ctl00_MyCPH1_UCMyExpenseVoucher1_txtTotalExeAmt").value=totamt;       
            
           
        
         
   }
        
 function validFloat(event,txtid)
      {
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
        return true;
        
         if(event.keyCode==46)
          if(txt.indexOf('.')!=-1)
            event.keyCode=0;
        
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
        {event.keyCode=0;return false;}
     } 



</script>



<asp:UpdatePanel ID="UpdatePanel10" runat="server" RenderMode="Inline" UpdateMode="Conditional">
    <ContentTemplate>
        <br>
        <table cellspacing="1" cellpadding="3" width="90%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan=4 align="center"><font class=blackfnt><b>ACCOUNT DETAILS-EXPENSE INCURRED</b></font></td>
            </tr>
            
         <%
         string Stat = Request.QueryString["Stat"];
         if (Stat=="S" )
          { %>    
            <tr style="background-color: white">
                <td width="10%" nowrap><font class=blackfnt>Enter no. of rows</font></td>
                <td  colspan="3" align=left>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:TextBox ID="txtRow1" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="txtRow1_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow1"  ></asp:RequiredFieldValidator>
                        </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow1" EventName="TextChanged" />
                    </Triggers>
                  </asp:UpdatePanel> 
                </td>
            </tr> 

       
            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>STATUTORY EXPENSE</b></font></td>
            </tr>

            <tr style="background-color: white">
                <td   colspan="4" align="left" style="height: 185px">
                        <asp:DataGrid ID="dgExpense1" runat="server" AutoGenerateColumns="False"
                               CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                               BorderWidth="3px" Width="100%" OnItemDataBound="dgExpense_ItemDataBound" >
                               <Columns>
                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                             <ItemTemplate>
                                                 <center>
                                                    <%# Container.ItemIndex+1 %>.
                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                  </center>
                                              </ItemTemplate>
                                              <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                              <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>

                                        <asp:TemplateColumn HeaderText="Nature Of Expense">
                                              <ItemTemplate>
                                                    <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:DropDownList>
                                              </ItemTemplate>
                                              <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                     Font-Underline="False" Wrap="False" />
                                               <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                     Font-Underline="False" Wrap="False" />
                                         </asp:TemplateColumn>
                                                        
                                          <asp:TemplateColumn HeaderText="Vehicle No.">
                                               <ItemTemplate>
                                                      <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                           <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                            Width="14px"><a>...</a></asp:Label> 
                                                           <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                                                           <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                           Font-Underline="False" Wrap="False" />
                                                 <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                           Font-Underline="False" Wrap="False" />
                                          </asp:TemplateColumn>
                                                     
                                          <asp:TemplateColumn HeaderText="Amount Spent">
                                                 <ItemTemplate>
                                                          <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="65" BorderStyle="Groove"   onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  ></asp:TextBox>
                                                          <asp:RegularExpressionValidator ID="REVtxtAmt" runat="server" ControlToValidate="txtAmt"   ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                  </ItemTemplate>
                                                  <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                  <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                           </asp:TemplateColumn>
                                                        
                                           <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                 <ItemTemplate>
                                                          <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100" Width="100px" BorderStyle="Groove"   ></asp:TextBox> 
                                                  </ItemTemplate>
                                                  <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                             Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                             Font-Underline="False" Wrap="true" />
                                            </asp:TemplateColumn>
                                                    
                                            <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                    <ItemTemplate>
                                                            <asp:TextBox ID="txtExeAmt" runat="server" MaxLength="7" Width="100px" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'    ></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server" ControlToValidate="txtExeAmt"   ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                     </ItemTemplate>
                                                     <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="False" />
                                                      <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="true" />
                                             </asp:TemplateColumn>
                                                        
                                                        
                                              <asp:TemplateColumn HeaderText="Remarks">
                                                      <ItemTemplate>
                                                            <asp:TextBox ID="txtRemarks" runat="server"  MaxLength="250"  Width="100px" BorderStyle="Groove" ></asp:TextBox>
                                                      </ItemTemplate>
                                                      <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                              Font-Underline="False" Wrap="False" />
                                                       <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                               Font-Underline="False" Wrap="False" />
                                               </asp:TemplateColumn>
                           </Columns>
                                 <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                             ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                  <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                   <ItemStyle ForeColor="#000066" />
                                            <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                 Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                       </asp:DataGrid>
                </td>
            </tr>
            <%} %>
            
            
          <% 
              string CrewSal = Request.QueryString["CrewSal"]; 
              if (CrewSal == "C")
             {    %>  
           <tr style="background-color: white">
              <td width="10%" nowrap><font class=blackfnt>Enter no. of rows</font></td>
              <td  colspan="3" align=left style="height: 69px">
                   <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                            <asp:TextBox ID="txtRow2" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true"  OnTextChanged="txtRow2_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow2"  ></asp:RequiredFieldValidator>
                    </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow2" EventName="TextChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                </td>
            </tr> 
 
            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>CREW SALARY EXPENSE</b></font></td>
            </tr>
           
            <tr style="background-color: white">
                <td colspan="4" align="left">
                        <asp:DataGrid ID="dgExpense2" runat="server" AutoGenerateColumns="False"
                                  CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                  BorderWidth="3px" Width="100%" OnItemDataBound="dgExpense2_ItemDataBound" >
                               <Columns>
                                       <asp:TemplateColumn HeaderText="Sr.No.">
                                                <ItemTemplate>
                                                     <center>
                                                          <%# Container.ItemIndex+1 %>.
                                                          <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                      </center>
                                                 </ItemTemplate>
                                                 <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="False" />
                                                 <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="False" />
                                       </asp:TemplateColumn>
                                                        
                                       <asp:TemplateColumn HeaderText="Nature Of Expense">
                                                 <ItemTemplate>
                                                         <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:DropDownList>
                                                 </ItemTemplate>
                                                 <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="False" />
                                                  <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                             Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>

                                        <asp:TemplateColumn HeaderText="Vehicle No.">
                                                  <ItemTemplate>
                                                        <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                         <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                             Width="14px"><a>...</a></asp:Label> 
                                                          <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                                                           <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                   </ItemTemplate>
                                                   <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                              Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                              Font-Underline="False" Wrap="False" />
                                         </asp:TemplateColumn>
                                                        
                                          <asp:TemplateColumn HeaderText="Amount Spent">
                                                     <ItemTemplate>
                                                             <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="65" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  ></asp:TextBox>
                                                             <asp:RegularExpressionValidator ID="REVtxtAmt" runat="server" ControlToValidate="txtAmt"   ValidationGroup="VGDtFromTo"
                                                                 ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                 Width="1px"></asp:RegularExpressionValidator>
                                                     </ItemTemplate>
                                                     <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                      <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                           </asp:TemplateColumn>
                                                      
                                            <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100" Width="100px" BorderStyle="Groove"   ></asp:TextBox> 
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                            </asp:TemplateColumn>
                                                      
                                            <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                           <ItemTemplate>
                                                                  <asp:TextBox ID="txtExeAmt" runat="server" MaxLength="7" Width="100px" BorderStyle="Groove"   onblur="javascript:return calculateBalance()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'  ></asp:TextBox>
                                                                  <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server" ControlToValidate="txtExeAmt"  ValidationGroup="VGDtFromTo"
                                                                  ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                  Width="1px"></asp:RegularExpressionValidator>
                                                           </ItemTemplate>
                                                           <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                  Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                  Font-Underline="False" Wrap="true" />
                                            </asp:TemplateColumn>
                                                        
                                            <asp:TemplateColumn HeaderText="Remarks">
                                                          <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server"   MaxLength="250" Width="100px" BorderStyle="Groove" ></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                             </Columns>
                                      <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                   ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                       <FooterStyle BackColor="White" ForeColor="#000066" />
                                       <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                       <ItemStyle ForeColor="#000066" />
                                       <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                  Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                    </asp:DataGrid>
                </td>
            </tr>
           <%} %> 
         
         <%
             string VehTrack = Request.QueryString["VehTrack"];
             if(VehTrack=="V") 
           {%>   
            <tr style="background-color: white">
                <td width="10%" nowrap><font class=blackfnt>Enter no. of rows</font></td>
                <td  colspan="3" align=left>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:TextBox ID="txtRow3" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="txtRow3_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow3"  ></asp:RequiredFieldValidator>
                        </ContentTemplate>
                        <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow3" EventName="TextChanged" />
                    </Triggers>
                   </asp:UpdatePanel> 
                </td>
            </tr> 
          
            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>VEHICLE TRACKING SERVICE EXPENSE</b></font></td>
            </tr>
             <tr style="background-color: white">
                <td  colspan="4" align="left">
                          <asp:DataGrid ID="dgExpense3" runat="server" AutoGenerateColumns="False"
                                            CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                            BorderWidth="3px" Width="100%" OnItemDataBound="dgExpense3_ItemDataBound" >
                                     <Columns>
                                              <asp:TemplateColumn HeaderText="Sr.No.">
                                                      <ItemTemplate>
                                                             <center>
                                                                 <%# Container.ItemIndex+1 %>.
                                                                 <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                              </center>
                                                        </ItemTemplate>
                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                         <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                       
                                                 <asp:TemplateColumn HeaderText="Nature Of Expense">
                                                        <ItemTemplate>
                                                                <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:DropDownList>
                                                        </ItemTemplate>
                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                 Font-Underline="False" Wrap="False" />
                                                  </asp:TemplateColumn>
                                                    
                                                  <asp:TemplateColumn HeaderText="Vehicle No.">
                                                         <ItemTemplate>
                                                               <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                               <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                                Width="14px"><a>...</a></asp:Label> 
                                                                <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                                                                <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                         </ItemTemplate>
                                                         <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                   <asp:TemplateColumn HeaderText="Amount Spent">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="65" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  ></asp:TextBox>
                                                                   <asp:RegularExpressionValidator ID="REVtxtAmt" runat="server" ControlToValidate="txtAmt"   ValidationGroup="VGDtFromTo"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                    Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                               Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                   </asp:TemplateColumn>
                                                        
                                                   <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100"  Width="100px" BorderStyle="Groove"   ></asp:TextBox> 
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                   </asp:TemplateColumn>
                                                        
                                                   <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                           <ItemTemplate>
                                                                <asp:TextBox ID="txtExeAmt" runat="server" MaxLength="7"   Width="100px" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'   ></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server" ControlToValidate="txtExeAmt"   ValidationGroup="VGDtFromTo"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                    Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                    </asp:TemplateColumn>
                                                        
                                                    <asp:TemplateColumn HeaderText="Remarks">
                                                             <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="250" Width="100px" BorderStyle="Groove" ></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                   </asp:TemplateColumn>
                                     </Columns>
                                               <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                    ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle ForeColor="#000066" />
                                                 <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                      Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                        </asp:DataGrid>
                </td>
           </tr>
            <%} %>
            
          <%
              string FinExp = Request.QueryString["FinExp"];
              if(FinExp=="F")
            { %>  
           <tr style="background-color: white">
                <td width="10%" nowrap><font class=blackfnt>Enter no. of rows</font></td>
                <td  colspan="3" align=left>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:TextBox ID="txtRow4" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="txtRow4_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow4"  ></asp:RequiredFieldValidator>
                        </ContentTemplate>
                        <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow4" EventName="TextChanged" />
                        </Triggers>
                        </asp:UpdatePanel> 
                </td>
            </tr> 
           
            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>FINANCIAL EXPENSE</b></font></td>
            </tr>
                        
             <tr style="background-color: white">
                <td  colspan="4"   align="left">
                            <asp:DataGrid ID="dgExpense4" runat="server" AutoGenerateColumns="False"
                                             CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                              BorderWidth="3px" Width="100%" OnItemDataBound="dgExpense4_ItemDataBound" >
                                               <Columns>
                                                     <asp:TemplateColumn HeaderText="Sr.No.">
                                                          <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                          </ItemTemplate>
                                                          <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                          <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                     </asp:TemplateColumn>
                                                      
                                                     <asp:TemplateColumn HeaderText="Nature Of Expense">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:DropDownList>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                     </asp:TemplateColumn>
                                                        
                                                     <asp:TemplateColumn HeaderText="Vehicle No.">
                                                             <ItemTemplate>
                                                                    <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                                    <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                                    Width="14px"><a>...</a></asp:Label> 
                                                                    <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                                                                    <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                     </asp:TemplateColumn>
                                                       
                                                     <asp:TemplateColumn HeaderText="Amount Spent">
                                                            <ItemTemplate>
                                                                    <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="65" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  ></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="REVtxtAmt" runat="server" ControlToValidate="txtAmt"  ValidationGroup="VGDtFromTo"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                    Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                      </asp:TemplateColumn>
                                                        
                                                      <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100"  Width="60px" BorderStyle="Groove"   ></asp:TextBox> 
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                      </asp:TemplateColumn>
                                                        
                                                       <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                            <ItemTemplate>
                                                               <asp:TextBox ID="txtExeAmt" runat="server" MaxLength="7" Width="100px" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'   ></asp:TextBox>
                                                               <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server" ControlToValidate="txtExeAmt"   ValidationGroup="VGDtFromTo"
                                                               ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                               Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                       </asp:TemplateColumn>
                                                        
                                                        
                                                       <asp:TemplateColumn HeaderText="Remarks">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="250"  Width="100px" BorderStyle="Groove" ></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                       </asp:TemplateColumn>
                                            </Columns>
                                                <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                 <FooterStyle BackColor="White" ForeColor="#000066" />
                                                 <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                 <ItemStyle ForeColor="#000066" />
                                                 <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                       </asp:DataGrid>
                                 
                </td>
            </tr>
            <%} %>
            
            
          
            <%
              string Repair = Request.QueryString["Repair"];
              if(Repair=="R")
            { %> 
           <tr style="background-color: white"> 
            <td width="10%" nowrap><font class=blackfnt>Enter no. of rows</font></td>
                <td align=left>
                        <asp:UpdatePanel ID="UpdatePanel6" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                <asp:TextBox ID="txtRow" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow"  ></asp:RequiredFieldValidator>
                    </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                   
                    </Triggers>
                    </asp:UpdatePanel> 
                </td>
            </tr> 
           
           <tr class="bgbluegrey">
                <td colspan=4 align="center"><font class=blackfnt><b>REPAIR & MAINTAINENCE EXPENSE</b></font></td>
            </tr>
             
            <tr style="background-color: white">
                <td colspan=4 align=left>
                 
                            <asp:DataGrid ID="dgExpense" runat="server" AutoGenerateColumns="False"
                                              CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                               BorderWidth="3px" Width="100%" OnItemDataBound="dgExpenseRepair_ItemDataBound" >
                                        <Columns>
                                                <asp:TemplateColumn HeaderText="Sr.No.">
                                                       <ItemTemplate>
                                                               <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                        </ItemTemplate>
                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                  </asp:TemplateColumn>
                                                        
                                                  <asp:TemplateColumn HeaderText="Nature Of Expense">
                                                        <ItemTemplate>
                                                              <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove"  ></asp:DropDownList>
                                                        </ItemTemplate>
                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                               Font-Underline="False" Wrap="False" />
                                                         <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                               Font-Underline="False" Wrap="False" />
                                                   </asp:TemplateColumn>
                                                        
                                                   <asp:TemplateColumn HeaderText="Vehicle No.">
                                                          <ItemTemplate>
                                                                <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                                <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                                Width="14px"><a>...</a></asp:Label> 
                                                                <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                                                                <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                          </ItemTemplate>
                                                          <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                          <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                    </asp:TemplateColumn>
                                                        
                                                    <asp:TemplateColumn HeaderText="Amount Spent">
                                                           <ItemTemplate>
                                                                <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="80" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>' ></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="REVtxtAmt"  ValidationGroup="VGDtFromTo" runat="server" ControlToValidate="txtAmt"
                                                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                     </asp:TemplateColumn>
                                                        
                                                     <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100"  Width="100px" BorderStyle="Groove"   ></asp:TextBox> 
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="True" />
                                                      </asp:TemplateColumn>
                                                        
                                                      <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtExeAmt" runat="server"   MaxLength="7" Width="100px" BorderStyle="Groove" onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>' ></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server"   ValidationGroup="VGDtFromTo"  ControlToValidate="txtExeAmt"
                                                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="True" />
                                                      </asp:TemplateColumn>
                                                        
                                                      <asp:TemplateColumn HeaderText="Remarks">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="250"  Width="100px" BorderStyle="Groove"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                      </asp:TemplateColumn>
                                        </Columns>
                                                <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                      ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <ItemStyle ForeColor="#000066" />
                                                <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                      Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                        </asp:DataGrid>
               
                </td>
            </tr>
            <%} %>
          
            
            
        </table>   
       <table Width="90%"   cellspacing="1" cellpadding="3" class="boxbg" border="0">
            <tr style="background-color: white">
                    <td  width="37%">
                        <font class=blackfnt><b>Total</b></font>
                    </td>
                    <td align="left" width="31%">
                        <asp:TextBox ID="txtTotalAmt" runat="server"  ReadOnly="true" Width="65px" BorderStyle="Groove"></asp:TextBox>
                    </td>
                    <td align="left" >
                        <asp:TextBox ID="txtTotalExeAmt" runat="server"  ReadOnly="true" Width="100" BorderStyle="Groove"></asp:TextBox>
                    </td>
       
      </tr>
     </table>
     <br>
     <%--<table  width="100%">
  
     <tr>
     <td align="center">
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>"    ValidationGroup="VGDtFromTo" OnClick="SubmitData"  OnClientClick="javascript:return CheckValid()"   />
      </td>
      </tr> 

  </table>--%>
  
    </ContentTemplate>
           <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                <asp:AsyncPostBackTrigger ControlID="txtRow1" EventName="TextChanged" />
                <asp:AsyncPostBackTrigger ControlID="txtRow2" EventName="TextChanged" />
                <asp:AsyncPostBackTrigger ControlID="txtRow3" EventName="TextChanged" />
                <asp:AsyncPostBackTrigger ControlID="txtRow4" EventName="TextChanged" />
           </Triggers>
    </asp:UpdatePanel> 
