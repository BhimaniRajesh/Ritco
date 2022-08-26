<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="lsstatus_delete.aspx.cs" Inherits="GUI_Operations_TCS_lsstatus_delete" %>

<%@ OutputCache Location="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

     <script language="javascript" type="text/javascript">
     
     function LSNo_Submit(lsno)
    {
	if(lsno.value=="")
		 {
		  alert("Please enter the Loading Sheet No.")
		  lsno.focus();
		  return false;
		 }
	var lsno1= lsno.value
	}
	function dktcheck(d)
    {
         
              var txtdno=d.id;
             
              var dno=d.value;
              
                    createXMLHTTPObject();
                    
                     if (doc)
				     { 
             	         arg=new Date()
					     doc.onreadystatechange = doWork; 
					     doc.open("GET", "./dochk.aspx?dockno="+dno, false);
					     doc.send(null);
				      }
           
    }
    var doc = null; 
    var formobj;
    var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;
	
	function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) 
	    { 
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } 
	    else if (window.ActiveXObject) 
	    { 
	        try 
	        {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } 
	        catch (e) 
	        {
	            try 
	            {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } 
	            catch (e) 
	            {
	            
	            }
	        }
	    }
	}
	var p=true
	var res
	var txtVendor
	var txtVehicle
	function doWork() 
	{
	    if (doc.readyState == 4) 
	    {
	           res=doc.responseText.split("|");
	           if (res[0]!="OK")
	            {
	                alert(res[0])
	                p=false
	                rt=""
	                return false
	            }
	            else
	            {
                     
                      var s= document.getElementById("ctl00_MyCPH1_hi").value;
	                  //document.getElementById(s).value = res[1];
	                  
	            }
	    }
	}
     
     
	
////	if(lsno1.substring(2,1)!="L" || lsno1.length<14 )
////		 {
////		  alert("Invalid Loading Sheet No.")
////		  lsno.focus();
////		  return false;
////		 }
//    if (confirm("Do you want to delete this loading sheet ???")==true)		 
//     {
//      
//     }
//    else
//     {
//       return false;
//     } 
//	var str="DKT"	
//	//fshow(str)
//}

//function fshow(str)
//	{  
//	  if (str=="DT")
//	   {
//		display('ProcessIndiacator');
//		hidden('ProcessIndiacatorSubmit');
//	   }	
//	  if (str=="DKT")
//	   {
//		display('ProcessIndiacator_DOCKNO');
//		hidden('ProcessIndiacatorSubmit_DOCKNO');
//	   }	

//	}
     
     </script>
     
     
     
								 
	<br />
								
								



	<div align="center">
	
<table border="0"  cellpadding="3" cols="1" width="70%" bgcolor="#808080" cellspacing="1" class="boxbg">
	<tr class="bgbluegrey">
	<td  align="center" colspan="2">
	<font class="blackfnt">Enter Loading Sheet Number </font>
	</td>
	</tr>	
<tr bgcolor="#FFFFFF">	
    <td width="30%"><font class="blackfnt">Enter  Loading Sheet No. </font></td>
	<td valign="top" align="left" >
	<asp:TextBox ID="lsno" runat="server" onblur="return dktcheck(this)">
	</asp:TextBox>
	<asp:HiddenField ID="hi" runat="server" />
	</td>
  </tr>	
</table>
<br />
     <asp:Button ID="submit2" runat="server" Text="Delete Loading Sheet" OnClick="submit2_Click" />
   </div>  
     
</asp:Content>
