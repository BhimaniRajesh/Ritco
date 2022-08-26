<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="document_cancel.aspx.cs" Inherits="GUI_Operations_document_cancel_document_cancel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
function GetXmlHttpObject()
{
  var xmlHttp=null;
  try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    // Internet Explorer
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
    }
  return xmlHttp;
}

function docBlur(id)
{
   
    
  var txtdocno=document.getElementById(id);
  var docno=txtdocno.value;  
  var rdcn=document.getElementById("ctl00_MYCPH1_rdcn");  
    
    if(rdcn.checked==false)
         return false;
        
    var findobj=false;
    findobj=GetXmlHttpObject();
    if(findobj)
    {
     var strpg="BringDocDetails.aspx?mode=doc&code=" + docno + "&sid=" + Math.random() + "&ss=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        /// uncancelled docket
                        alert(res[1]);
                        return false;
                    }
                    else if(res[0]=="true")
                    {
                       //alert("Docket is cancelled");
                    }
                }
         }
         
    findobj.send(null);
    }
    
    
    return false;
}


/*****************************************************************************************************
                    THC VALIDATION FUNCTION - EXECUTED ON TXTTHC BLUR
******************************************************************************************************/
//function thcBlur(id)
//{
//   
//    
//  var txtdocno=document.getElementById(id);
//  var docno=txtdocno.value;  
//  var rdthc=document.getElementById("ctl00_MYCPH1_rdTHC");  
//    
//    if(rdthc.checked==false)
//         return false;
//        
//    var findobj=false;
//    findobj=GetXmlHttpObject();
//    if(findobj)
//    {
//     var strpg="BringDocDetails.aspx?mode=thc&code=" + docno + "&sid=" + Math.random() + "&ss=" + Math.random();
//     findobj.open("GET",strpg,true);
//     findobj.onreadystatechange=function()
//         {
//             if(findobj.readyState==4 && findobj.status==200)
//                {
//                    var res=findobj.responseText.split("|");
//                    if(res[0]=="false")
//                    {
//                        /// uncancelled docket
//                        alert(res[1]);
//                        return false;
//                    }
//                    else if(res[0]=="true")
//                    {
//                       //alert("Docket is cancelled");
//                    }
//                }
//         }
//         
//    findobj.send(null);
//    }
//    
//    
//    return false;
//}


/*****************************************************************************************************
                    Manifest VALIDATION FUNCTION - EXECUTED ON TXTTHC BLUR
******************************************************************************************************/
function manifestBlur(id)
{
   
    
  var txtdocno=document.getElementById(id);
  var docno=txtdocno.value;  
  var rdmanifest=document.getElementById("ctl00_MYCPH1_rdManifiest");  
    
    if(rdmanifest.checked==false)
         return false;
        
    var findobj=false;
    findobj=GetXmlHttpObject();
    if(findobj)
    {
     var strpg="BringDocDetails.aspx?mode=manifest&code=" + docno + "&sid=" + Math.random() + "&ss=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        /// uncancelled docket
                        alert(res[1]);
                        return false;
                    }
                    else if(res[0]=="true")
                    {
                       //alert("Docket is cancelled");
                    }
                }
         }
         
    findobj.send(null);
    }
    
    
    return false;
}


function cancel_doc(txtCNno,txtManifiest,btnGo,rdCN,rdManifiest)
{

                                        if (rdCN.checked==false && rdManifiest.checked==false )
										  {
								          	alert("Please select the document to cancel")
								          	return false				         
										  }
										else
										 {
											if (rdCN.checked)
											 {
											    var dktval=txtCNno.value
												if (txtCNno.value=="")
												 {
												   alert("Enter C.NOTE No.")
												   return false
												 }
												
											  }
										      else if (rdManifiest.checked)
											  {
											    var tcval=txtManifiest.value
												if (txtManifiest.value=="")
												 {
												   alert("Enter Manifest No.")
												   return false
												 }
												

											 }  
											
											 
											
										  }
}

</script>

<br />
<div align="center">

<table border="0" cellpadding="3" cols="1"  width="75%" bgcolor="#808080" cellspacing="1" class="boxbg" align="center">
							<tr class="bgbluegrey">
							<td  align="center" colspan="3">
							<font class="blackfnt">Document Cancellation by Numbers</font>
							</td>
							</tr>
										<tr bgcolor="#ffffff">
											<td align="left"><font class="blackfnt">Enter CN No.</font></td>
																
											<td colspan="2" bgcolor="#ffffff" align="left">
											
											    <asp:RadioButton ID="rdCN" runat="server" GroupName="grpradiobtn" />
											    <asp:TextBox ID="txtCNno" runat="server"></asp:TextBox>
											
											
											</td>
										</tr>
														
										<tr bgcolor="#ffffff">
												<td align="left"><font class="blackfnt">Enter Manifest No.</font></td>
																
												<td colspan="2" bgcolor="#ffffff" align="left">
												
												    <asp:RadioButton ID="rdManifiest" runat="server" GroupName="grpradiobtn"  />
												    <asp:TextBox ID="txtManifiest" runat="server"></asp:TextBox>
												
												</td>
										</tr>
														
										<%--<tr bgcolor="#ffffff" visible="false" runat="server">
												<td align="left"><font class="blackfnt">Enter THC No.</font></td>
																
												<td colspan="2" bgcolor="#ffffff" align="left">
												
												    <asp:RadioButton ID="rdTHC" runat="server" GroupName="grpradiobtn"  />
												    <asp:TextBox ID="txtTHC" runat="server"></asp:TextBox>
												
												</td>
										</tr>--%>

										

										
										<tr bgcolor="#ffffff">
											<td colspan="3" align="center">
											<%--<a href="javascript:cancel_doc()"><img src="../../images/go.gif" border="0"></a>--%>
											<asp:Button ID="btnGo" runat="server" Width="38px" Text="GO" OnClick="btnGo_Click"/>
											</td>
										</tr>

								</table>

</div>


</asp:Content>
